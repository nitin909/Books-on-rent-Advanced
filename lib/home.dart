import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import './user.dart';
import 'package:scrren_cart/save.dart';

// CHATBOT IMPORT
import 'chat_bot_screen.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  List<user> usersList = [];

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedFile;

  Future<void> uploadImage({required String fileName}) async {
    log("ADD IMAGE TO FIREBASE");

    await FirebaseStorage.instance.ref().child(fileName).putFile(
          File(_selectedFile!.path),
        );
  }

  Future<String> downloadImageURL({required String fileName}) async {
    log("GET URL FROM FIREBASE");

    String url =
        await FirebaseStorage.instance.ref().child(fileName).getDownloadURL();

    log("UPLOADED URL : $url");
    return url;
  }

  Future<void> addDataToFirebase({required String url}) async {
    log("UPLOAD DATA TO CLOUD");

    Map<String, dynamic> data = {
      'profilePic': url,
      'firstName': firstnameController.text.trim(),
      'lastName': lastnameController.text.trim(),
      'dob': dobController.text.trim(),
      'address': addressController.text.trim(),
      'mobile': mobController.text.trim(),
      'pin': pinController.text.trim(),
    };

    await FirebaseFirestore.instance
        .collection("usersInfo")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data);

    _selectedFile = null;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data added successfully")),
    );
  }

  Future<void> getDataFromFirebase() async {
    usersList.clear();

    QuerySnapshot response =
        await FirebaseFirestore.instance.collection("usersInfo").get();

    for (var value in response.docs) {
      usersList.add(user(
        profilePic: value['profilePic'],
        firstName: value['firstName'],
        lastName: value['lastName'],
        dob: value['dob'],
        address: value['address'],
        mobile: value['mobile'],
        pin: value['pin'],
        id: value.id,
      ));
    }

    log("LENGTH OF USERS LIST: ${usersList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logged out")),
              );
            },
          )
        ],
      ),

      // CHATBOT BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.chat, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotScreen()),
          );
        },
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),

              // Profile Image
              (_selectedFile == null)
                  ? Image.asset("assets/prof.png", height: 120)
                  : Image.file(
                      File(_selectedFile!.path),
                      height: 120,
                      fit: BoxFit.cover,
                    ),

              const SizedBox(height: 10),

              // Camera Icon Button
              GestureDetector(
                onTap: () async {
                  _selectedFile =
                      await _imagePicker.pickImage(source: ImageSource.gallery);

                  if (_selectedFile != null) {
                    setState(() {});
                  }
                },
                child: const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.camera_alt, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              buildTextField(firstnameController, "First Name"),
              buildTextField(lastnameController, "Last Name"),

              // DOB
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "DOB",
                    hintStyle: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat.yMd().format(pickedDate);

                          setState(() {
                            dobController.text = formattedDate;
                          });
                        }
                      },
                      child: const Icon(Icons.calendar_month),
                    ),
                  ),
                ),
              ),

              buildTextField(mobController, "Mobile No."),
              buildTextField(addressController, "Address"),
              buildTextField(pinController, "Pincode"),

              const SizedBox(height: 10),

              // SAVE BUTTON
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  color: const Color(0xff0095FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () async {
                    if (_selectedFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select image first"),
                        ),
                      );
                      return;
                    }

                    String fileName =
                        _selectedFile!.name + DateTime.now().toString();

                    await uploadImage(fileName: fileName);
                    String url = await downloadImageURL(fileName: fileName);

                    await addDataToFirebase(url: url);
                    await getDataFromFirebase();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Save(
                            name: firstnameController.text.trim() +
                                " " +
                                lastnameController.text.trim(),
                            dob: dobController.text.trim(),
                            address: addressController.text.trim(),
                            pin: pinController.text.trim(),
                            mob: mobController.text.trim(),
                            profilepic: url,
                          );
                        },
                      ),
                    );

                    setState(() {});
                  },
                  child: Text(
                    "SAVE",
                    style: GoogleFonts.quicksand(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
