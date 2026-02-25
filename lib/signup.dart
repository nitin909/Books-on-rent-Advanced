// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrren_cart/fav.dart';
import './showCustomSnackbar.dart';
import 'package:scrren_cart/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage1 extends StatelessWidget {
  const SignupPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/login.png"), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Centering All Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Text Above Form Fields
                  Text(
                    "Create Your Account",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Form Fields
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Password Field with show/hide toggle
                  TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  const SizedBox(
                    height: 10.0,
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (emailController.text.trim().isNotEmpty &&
                          passwordController.text.trim().isNotEmpty) {
                        try {
                          UserCredential userCredential = await _firebaseAuth
                              .createUserWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          await FirebaseFirestore.instance
                              .collection("usersInfo")
                              .doc(userCredential.user!.uid)
                              .set(
                            {
                              'profilePic': "",
                              'firstName': "",
                              'lastName': "",
                              'dob': "",
                              'address': "",
                              'mobile': '',
                              'pin': ''
                            },
                          );

                          CustomSnackbar.showCustomSnackbar(
                            message: "User Register Successfully",
                            context: context,
                          );
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }));
                        } on FirebaseAuthException catch (error) {
                          print("${error.code}");
                          print("${error.message}");
                          CustomSnackbar.showCustomSnackbar(
                            message: error.message!,
                            context: context,
                          );
                        }
                      } else {
                        CustomSnackbar.showCustomSnackbar(
                          message: "Please enter valid fields",
                          context: context,
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: const Center(
                        child: Text(
                          "Register User",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // // Submit Button
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Handle submit action
                  //     Navigator.of(context)
                  //         .push(MaterialPageRoute(builder: (context) {
                  //       return  LoginPage();
                  //     }));
                  //     setState(() {

                  //     });
                  //   },
                  //   child: Text(
                  //     'Submit',
                  //     style: GoogleFonts.quicksand(
                  //       fontSize: 26,
                  //       fontWeight: FontWeight.w700,
                  //       color: const Color.fromRGBO(0, 0, 0, 1),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
