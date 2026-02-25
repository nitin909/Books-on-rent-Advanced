
import 'dart:ui';
import 'package:scrren_cart/favourites_list.dart';

import './model.dart';
import 'package:scrren_cart/bookmodel.dart';
import 'package:scrren_cart/main.dart';
import 'book_detail_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import './appcolor.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import './login.dart';
import 'package:google_fonts/google_fonts.dart';

class ListViewAnimation extends StatefulWidget {
  const ListViewAnimation({super.key});

  @override
  State<ListViewAnimation> createState() => _ListViewAnimationState();
}

class _ListViewAnimationState extends State<ListViewAnimation> {
  double width = 0;
  bool myAnimation = false;
  final colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        myAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 36, 49),
      appBar: AppBar(
        backgroundColor: AppColor.color4,
        title: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                'FAVORITE ❤️',
                textStyle: GoogleFonts.quicksand(
                    fontSize: 20, fontWeight: FontWeight.normal),
                colors: colorizeColors,
              ),
              ColorizeAnimatedText(
                'Read Books 📔',
                textStyle: GoogleFonts.quicksand(
                    fontSize: 20, fontWeight: FontWeight.normal),
                colors: colorizeColors,
              ),
              ColorizeAnimatedText(
                'Increase Knowledge',
                textStyle: GoogleFonts.quicksand(
                    fontSize: 20, fontWeight: FontWeight.normal),
                colors: colorizeColors,
              ),
            ],
            isRepeatingAnimation: true,
            onTap: () {},
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 20),
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: FavouritesList.favouriteList.length,
                itemBuilder: (context, index) {
                  final myUser = FavouritesList.favouriteList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      duration: Duration(milliseconds: 400 + (index * 250)),
                      curve: Curves.easeIn,
                      transform: Matrix4.translationValues(
                          myAnimation ? 0 : width, 0, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage(myUser['pic']!),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myUser['name']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Text(
                                //   myUser.username,
                                // ),
                              ],
                            ),
                            Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      FavouritesList.favouriteList
                                          .removeAt(index);
                                          setState(() {
                                            
                                          });
                                    },
                                    
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
