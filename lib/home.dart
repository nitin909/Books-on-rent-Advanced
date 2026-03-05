import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import './user.dart';
import 'package:scrren_cart/save.dart';
import 'chat_bot_screen.dart';

class home extends StatefulWidget {
  const home({super.key});
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with TickerProviderStateMixin {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController  = TextEditingController();
  TextEditingController dobController       = TextEditingController();
  TextEditingController addressController   = TextEditingController();
  TextEditingController mobController       = TextEditingController();
  TextEditingController pinController       = TextEditingController();

  List<user> usersList = [];
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedFile;

  // Entrance animation
  late AnimationController _enterController;
  late Animation<double>   _avatarScale;
  late Animation<double>   _avatarOpacity;
  late Animation<double>   _fieldsOpacity;
  late Animation<Offset>   _fieldsSlide;
  late Animation<double>   _btnOpacity;
  late Animation<Offset>   _btnSlide;

  // Avatar pick animation
  late AnimationController _avatarController;
  late Animation<double>   _avatarPulse;

  // Save button press
  late AnimationController _saveController;
  late Animation<double>   _saveScale;

  @override
  void initState() {
    super.initState();

    // Page entrance
    _enterController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1100),
    );
    _avatarScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _enterController,
          curve: const Interval(0.0, 0.45, curve: Curves.elasticOut)),
    );
    _avatarOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _enterController,
          curve: const Interval(0.0, 0.3, curve: Curves.easeIn)),
    );
    _fieldsOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _enterController,
          curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );
    _fieldsSlide = Tween<Offset>(
      begin: const Offset(0, 0.3), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterController,
        curve: const Interval(0.3, 0.75, curve: Curves.easeOutCubic)));
    _btnOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _enterController,
          curve: const Interval(0.65, 1.0, curve: Curves.easeOut)),
    );
    _btnSlide = Tween<Offset>(
      begin: const Offset(0, 0.5), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterController,
        curve: const Interval(0.65, 1.0, curve: Curves.easeOutCubic)));

    // Avatar pick pulse
    _avatarController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 600),
    );
    _avatarPulse = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.12), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.12, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _avatarController, curve: Curves.easeOut));

    // Save button press
    _saveController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 120),
    );
    _saveScale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _saveController, curve: Curves.easeInOut),
    );

    _enterController.forward();
  }

  @override
  void dispose() {
    _enterController.dispose();
    _avatarController.dispose();
    _saveController.dispose();
    super.dispose();
  }

  Future<void> uploadImage({required String fileName}) async {
    log("ADD IMAGE TO FIREBASE");
    await FirebaseStorage.instance.ref().child(fileName).putFile(
      File(_selectedFile!.path),
    );
  }

  Future<String> downloadImageURL({required String fileName}) async {
    log("GET URL FROM FIREBASE");
    String url = await FirebaseStorage.instance.ref().child(fileName).getDownloadURL();
    log("UPLOADED URL : $url");
    return url;
  }

  Future<void> addDataToFirebase({required String url}) async {
    log("UPLOAD DATA TO CLOUD");
    Map<String, dynamic> data = {
      'profilePic': url,
      'firstName': firstnameController.text.trim(),
      'lastName':  lastnameController.text.trim(),
      'dob':       dobController.text.trim(),
      'address':   addressController.text.trim(),
      'mobile':    mobController.text.trim(),
      'pin':       pinController.text.trim(),
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
        firstName:  value['firstName'],
        lastName:   value['lastName'],
        dob:        value['dob'],
        address:    value['address'],
        mobile:     value['mobile'],
        pin:        value['pin'],
        id:         value.id,
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
          ),
        ],
      ),

      floatingActionButton: _AnimatedFAB(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const ChatBotScreen(),
              transitionsBuilder: (_, anim, __, child) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
                child: child,
              ),
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        },
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),

              // Avatar with scale-in + pulse on change
              ScaleTransition(
                scale: _avatarScale,
                child: FadeTransition(
                  opacity: _avatarOpacity,
                  child: ScaleTransition(
                    scale: _avatarPulse,
                    child: (_selectedFile == null)
                        ? Image.asset("assets/prof.png", height: 120)
                        : Image.file(
                            File(_selectedFile!.path),
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Camera button with press animation
              FadeTransition(
                opacity: _avatarOpacity,
                child: _TappableCameraButton(
                  onTap: () async {
                    _selectedFile = await _imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (_selectedFile != null) {
                      _avatarController.forward(from: 0);
                      setState(() {});
                    }
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Fields slide up
              SlideTransition(
                position: _fieldsSlide,
                child: FadeTransition(
                  opacity: _fieldsOpacity,
                  child: Column(
                    children: [
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
                                  setState(() {
                                    dobController.text =
                                        DateFormat.yMd().format(pickedDate);
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
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Save button slides up + press bounce
              SlideTransition(
                position: _btnSlide,
                child: FadeTransition(
                  opacity: _btnOpacity,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ScaleTransition(
                      scale: _saveScale,
                      child: GestureDetector(
                        onTapDown: (_) => _saveController.forward(),
                        onTapUp: (_) async {
                          await _saveController.reverse();
                          HapticFeedback.mediumImpact();
                          _handleSave();
                        },
                        onTapCancel: () => _saveController.reverse(),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xff0095FF),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
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
                      ),
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

  Future<void> _handleSave() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select image first")),
      );
      return;
    }
    String fileName = _selectedFile!.name + DateTime.now().toString();
    await uploadImage(fileName: fileName);
    String url = await downloadImageURL(fileName: fileName);
    await addDataToFirebase(url: url);
    await getDataFromFirebase();
    if (!mounted) return;
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => Save(
          name: '${firstnameController.text.trim()} ${lastnameController.text.trim()}',
          dob:  dobController.text.trim(),
          address: addressController.text.trim(),
          pin: pinController.text.trim(),
          mob: mobController.text.trim(),
          profilepic: url,
        ),
        transitionsBuilder: (_, anim, __, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
    setState(() {});
  }

  Widget buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: _FocusTextField(controller: controller, hint: hint),
    );
  }
}

// Animated FAB — scales in on mount
class _AnimatedFAB extends StatefulWidget {
  final VoidCallback onPressed;
  const _AnimatedFAB({required this.onPressed});
  @override
  State<_AnimatedFAB> createState() => _AnimatedFABState();
}

class _AnimatedFABState extends State<_AnimatedFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 600));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.chat, color: Colors.white),
        onPressed: widget.onPressed,
      ),
    );
  }
}

// Camera button with press effect
class _TappableCameraButton extends StatefulWidget {
  final VoidCallback onTap;
  const _TappableCameraButton({required this.onTap});
  @override
  State<_TappableCameraButton> createState() => _TappableCameraButtonState();
}

class _TappableCameraButtonState extends State<_TappableCameraButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 120));
    _scale = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) async {
        await _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: const CircleAvatar(
          radius: 22,
          backgroundColor: Colors.blue,
          child: Icon(Icons.camera_alt, color: Colors.white),
        ),
      ),
    );
  }
}

// TextField with animated focus border
class _FocusTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  const _FocusTextField({required this.controller, required this.hint});
  @override
  State<_FocusTextField> createState() => _FocusTextFieldState();
}

class _FocusTextFieldState extends State<_FocusTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Color?>   _borderColor;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 200));
    _borderColor = ColorTween(
      begin: Colors.grey,
      end: Colors.blue,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _focus.addListener(() {
      _focus.hasFocus ? _ctrl.forward() : _ctrl.reverse();
    });
  }

  @override
  void dispose() { _ctrl.dispose(); _focus.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _borderColor,
      builder: (_, __) => TextField(
        controller: widget.controller,
        focusNode: _focus,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: _borderColor.value ?? Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: _borderColor.value ?? Colors.blue, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
