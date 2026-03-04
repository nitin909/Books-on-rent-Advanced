//import 'package:books_on_rent/account.dart';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import 'package:scrren_cart/book_detail_page.dart';
import 'package:scrren_cart/favourites_list.dart';
import 'optionspage.dart';
import 'appcolor.dart';
import 'appdata_modal.dart';

// CHATBOT IMPORTS
import 'chat_bot_screen.dart';
import 'animated_chat_button.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State {
  Widget sectionCards({
    required String card1Name,
    required String card1Pic,
    required int index,
    required List listdata,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (listdata == AppdataModal.listEducation) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OptionsPage(
                    optlist: AppdataModal.listEducation,
                    optindex: index,
                  ),
                ),
              );
            } else {
              log("INdex: $index");
              log(" data from index ${listdata[index]}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Detailpage(listbook: listdata[index], index: index),
                ),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.only(right: 15, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            width: 175,
            height: 175,
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    card1Pic,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FavouritesList.favouriteList.add({
                      "name": card1Name,
                      "pic": card1Pic,
                    });
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    weight: 500,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Pic Title / Books Name
        SizedBox(
          width: 175,
          child: Center(
            child: Text(
              card1Name,
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.visible,
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }

  String name = "";
  String url = "";

  Future<void> getProfileData() async {
    DocumentSnapshot response = await FirebaseFirestore.instance
        .collection("usersInfo")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    name = response['firstName'];
    url = response['profilePic'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8, left: 0),
                  margin: const EdgeInsets.only(top: 50),
                  width: 70,
                  height: 70,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.color4,
                  ),
                  child: url.isEmpty
                      ? Image.asset("assets/images/pr.jpg")
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(url),
                        ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 35, left: 20),
                  child: Text(
                    name.isNotEmpty ? "Hi, $name" : "Welcome ",
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        const Shadow(
                          offset: Offset(0, 4),
                          blurRadius: 2.0,
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Slogan Text
            Container(
              width: (MediaQuery.of(context).size.width) * 3 / 4,
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                "Discover the perfect book for every need!",
                style: GoogleFonts.quicksand(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // EDUCATION AND ACADEMICS
                      Text(
                        "Educational & Academic >",
                        style: GoogleFonts.quicksand(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColor.color1,
                        ),
                      ),
                      SizedBox(
                        height: 235,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: AppdataModal.listEducation.length,
                          itemBuilder: (context, index) {
                            return sectionCards(
                              card1Name: AppdataModal.listEducation[index]['cardname'],
                              card1Pic: AppdataModal.listEducation[index]['cardpic'],
                              index: index,
                              listdata: AppdataModal.listEducation,
                            );
                          },
                        ),
                      ),

                      // BUSINESS & FINANCE
                      Text(
                        "Business & Finance >",
                        style: GoogleFonts.quicksand(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColor.color5,
                        ),
                      ),
                      SizedBox(
                        height: 235,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: AppdataModal.listBookSections[0]['listBusiness'].length,
                          itemBuilder: (context, index) {
                            return sectionCards(
                              card1Name: AppdataModal.listBookSections[0]['listBusiness'][index]['cardname'],
                              card1Pic: AppdataModal.listBookSections[0]['listBusiness'][index]['cardpic'],
                              index: index,
                              listdata: AppdataModal.listBookSections[0]['listBusiness'],
                            );
                          },
                        ),
                      ),

                      // CHILDREN BOOKS
                      Text(
                        "Children's Books >",
                        style: GoogleFonts.quicksand(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColor.color6,
                        ),
                      ),
                      SizedBox(
                        height: 235,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: AppdataModal.listBookSections[0]['listChildrens'].length,
                          itemBuilder: (context, index) {
                            return sectionCards(
                              card1Name: AppdataModal.listBookSections[0]['listChildrens'][index]['cardname'],
                              card1Pic: AppdataModal.listBookSections[0]['listChildrens'][index]['cardpic'],
                              index: index,
                              listdata: AppdataModal.listBookSections[0]['listChildrens'],
                            );
                          },
                        ),
                      ),

                      // POETRY
                      Text(
                        "Poetry >",
                        style: GoogleFonts.quicksand(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColor.color6,
                        ),
                      ),
                      SizedBox(
                        height: 235,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: AppdataModal.listBookSections[0]['listPoetry'].length,
                          itemBuilder: (context, index) {
                            return sectionCards(
                              card1Name: AppdataModal.listBookSections[0]['listPoetry'][index]['cardname'],
                              card1Pic: AppdataModal.listBookSections[0]['listPoetry'][index]['cardpic'],
                              index: index,
                              listdata: AppdataModal.listBookSections[0]['listPoetry'],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // ANIMATED HELP BUTTON
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AnimatedChatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotScreen()),
          );
        },
      ),
    );
  }
}
