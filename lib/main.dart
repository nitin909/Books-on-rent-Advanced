import 'package:flutter/material.dart';
import 'package:scrren_cart/datasave.dart';
import 'package:scrren_cart/demo.dart';
import 'package:scrren_cart/book_detail_page.dart';
import 'package:scrren_cart/fav.dart';
import 'package:scrren_cart/first.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:scrren_cart/home.dart';
import 'package:scrren_cart/login.dart';
import 'package:scrren_cart/save.dart';
import 'package:scrren_cart/search.dart';
//import 'package:scrren_cart/shopping_bag.dart';
import 'package:scrren_cart/ss1.dart';
import './search_functionality.dart';
import 'package:scrren_cart/signup.dart';
import 'dart:developer';
import './ss.dart';
import './bookspage.dart';
import './save.dart';
import './order_details_page.dart';

import 'package:flutter/material.dart';
import 'package:scrren_cart/splash_screen.dart';
import './showCustomSnackbar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scrren_cart/signup.dart';
import './animated.dart';
import 'package:google_fonts/google_fonts.dart';
import './shopingba.dart';
import './optionspage.dart';
import 'package:scrren_cart/appcolor.dart';
import 'package:scrren_cart/fav.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:scrren_cart/login.dart';
import 'package:scrren_cart/splash_screen.dart';

//import './optionspage.dart';
import './ss1.dart';
import 'book_detail_page.dart';
//import './signup.dart';
import './login.dart';
//import './fav.dart';
//chatbot page
import 'chat_bot_screen.dart';

//cloudinary file
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyB6Rf2GIBi1glIvkluOmRCf5k1A5xyT2_E",
        appId: "1:669178018117:android:8e76838e6cf051d4fb662c",
        messagingSenderId: "yUVaAZ4KygMGqA9cUDqNsQQfYyC2",
        projectId: "test-a7076",
        storageBucket: "test-a7076.firebasestorage.app"),
  );

  // Cloudinary initialization
  CloudinaryContext.cloudinary =
      Cloudinary.fromCloudName(cloudName: 'dduaiju3n');

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int con = 0;
  int con1 = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
