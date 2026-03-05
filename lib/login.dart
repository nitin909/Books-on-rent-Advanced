import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrren_cart/book_detail_page.dart';
import 'package:scrren_cart/first.dart';
import 'package:scrren_cart/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './showCustomSnackbar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scrren_cart/signup.dart';
import './animated.dart';
import 'package:google_fonts/google_fonts.dart';
import './home1.dart';
import 'package:scrren_cart/appcolor.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  TextEditingController emailController    = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _isPasswordVisible = false;

  // Animation controllers
  late AnimationController _enterController;
  late AnimationController _buttonController;

  late Animation<double>  _titleOpacity;
  late Animation<Offset>  _titleSlide;
  late Animation<double>  _formOpacity;
  late Animation<Offset>  _formSlide;
  late Animation<double>  _btnOpacity;
  late Animation<Offset>  _btnSlide;
  late Animation<double>  _buttonScale;

  @override
  void initState() {
    super.initState();

    // Page entrance — staggered top-down
    _enterController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1200),
    );

    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _enterController,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, -0.5), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic)));

    _formOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _enterController,
          curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );
    _formSlide = Tween<Offset>(
      begin: const Offset(0, 0.3), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterController,
        curve: const Interval(0.3, 0.75, curve: Curves.easeOutCubic)));

    _btnOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _enterController,
          curve: const Interval(0.6, 1.0, curve: Curves.easeOut)),
    );
    _btnSlide = Tween<Offset>(
      begin: const Offset(0, 0.5), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic)));

    // Button press bounce
    _buttonController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 140),
    );
    _buttonScale = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    );

    _enterController.forward();
  }

  @override
  void dispose() {
    _enterController.dispose();
    _buttonController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) return;

    // Button press animation
    await _buttonController.forward();
    await _buttonController.reverse();
    HapticFeedback.lightImpact();

    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      userCredential.user!.uid;
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => Mynavbar(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    } on FirebaseAuthException catch (error) {
      log("C2W : ERROR :${error.code}");
      log("C2W : ERROR :${error.message}");
      CustomSnackbar.showCustomSnackbar(
        message: error.code,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image — unchanged
          SizedBox(
            height: 1000,
            child: Image.asset("assets/back.jpg", fit: BoxFit.cover),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // Title slides down
                      SlideTransition(
                        position: _titleSlide,
                        child: FadeTransition(
                          opacity: _titleOpacity,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "Login to your account",
                                style: GoogleFonts.quicksand(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.color2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Fields slide up
                      SlideTransition(
                        position: _formSlide,
                        child: FadeTransition(
                          opacity: _formOpacity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                // Email field with focus animation
                                _AnimatedTextField(
                                  controller: emailController,
                                  hintText: "Email",
                                  obscureText: false,
                                ),
                                const SizedBox(height: 30),
                                // Password field
                                _AnimatedTextField(
                                  controller: passwordController,
                                  hintText: "Password",
                                  obscureText: !_isPasswordVisible,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () => setState(() =>
                                        _isPasswordVisible = !_isPasswordVisible),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Button + signup slide up
                      SlideTransition(
                        position: _btnSlide,
                        child: FadeTransition(
                          opacity: _btnOpacity,
                          child: Column(
                            children: [
                              // Login button with press animation
                              ScaleTransition(
                                scale: _buttonScale,
                                child: GestureDetector(
                                  onTap: _handleLogin,
                                  child: Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 5.0),
                                    child: const Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Sign up row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => SignupPage1(),
                                          transitionsBuilder: (_, anim, __, child) =>
                                              SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(1, 0),
                                              end: Offset.zero,
                                            ).animate(CurvedAnimation(
                                                parent: anim,
                                                curve: Curves.easeOutCubic)),
                                            child: child,
                                          ),
                                          transitionDuration:
                                              const Duration(milliseconds: 400),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      " Sign up",
                                      style: GoogleFonts.quicksand(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Animated text field — border glows on focus
class _AnimatedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  const _AnimatedTextField({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  State<_AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<_AnimatedTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _focusController;
  late Animation<double> _borderAnim;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200),
    );
    _borderAnim = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _focusController, curve: Curves.easeOut),
    );
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusController.forward();
      } else {
        _focusController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _focusController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _borderAnim,
      builder: (_, __) => TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.white,
              width: _borderAnim.value,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(0, 0, 0, 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}

Widget inputFile({required String label, bool obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black87)),
      const SizedBox(height: 5),
      TextField(
        obscureText: obscureText,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
