import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrren_cart/first.dart';
import 'package:scrren_cart/model.dart';
import 'package:scrren_cart/signup.dart';
import 'package:scrren_cart/ss.dart';
import './home1.dart';

import './animated.dart';
import './home.dart';

// ignore: must_be_immutable
class Save extends StatefulWidget {
  String name, dob, mob, address, pin, profilepic;

  Save(
      {required this.name,
      required this.dob,
      required this.address,
      required this.mob,
      required this.pin,
      required this.profilepic});

  @override
  State<Save> createState() => _SaveState();
}

class _SaveState extends State<Save> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Mynavbar();
                }));
              },
              child: Icon(Icons.home)),
          actions: [
            GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(
                      
                  //     builder: (context) {
                  //       return SignupPage1();
                  //     },
                      
                  //   ),
                  // );
                },
                child: const Icon(Icons.logout)),
          ],
        ),
        body: Stack(
          children: [
            const MyWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 80, left: 20),
                    child: Image.network(widget.profilepic)),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Name",
                        style: GoogleFonts.quicksand(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 80,
                    // ),
                    Text(
                      widget.name,
                      style: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "DOB",
                        style: GoogleFonts.quicksand(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.dob,
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "MOBILE NO.",
                        style: GoogleFonts.quicksand(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.mob,
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "ADDRESS",
                        style: GoogleFonts.quicksand(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.address,
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "PINCODE",
                        style: GoogleFonts.quicksand(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.pin,
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
