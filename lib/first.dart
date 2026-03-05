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
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  late AnimationController _pageController;
  late Animation<double>   _headerFade;
  late Animation<Offset>   _headerSlide;
  late Animation<double>   _contentFade;
  late Animation<Offset>   _contentSlide;

  String name = "";
  String url  = "";

  @override
  void initState() {
    super.initState();

    _pageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _headerFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pageController,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.25), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _pageController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic)));

    _contentFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pageController,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut)),
    );
    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.15), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _pageController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic)));

    _pageController.forward();
    Future.delayed(Duration.zero, () async => await getProfileData());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> getProfileData() async {
    DocumentSnapshot response = await FirebaseFirestore.instance
        .collection("usersInfo")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    name = response['firstName'];
    url  = response['profilePic'];
    setState(() {});
  }

  Route _slideRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, anim, __, child) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0), end: Offset.zero,
        ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  Widget sectionCards({
    required String card1Name,
    required String card1Pic,
    required int index,
    required List listdata,
  }) {
    return _BookCard(
      cardName: card1Name,
      cardPic: card1Pic,
      onTap: () {
        if (listdata == AppdataModal.listEducation) {
          Navigator.push(context, _slideRoute(
            OptionsPage(
              optlist: AppdataModal.listEducation,
              optindex: index,
            ),
          ));
        } else {
          Navigator.push(context, _slideRoute(
            Detailpage(listbook: listdata[index], index: index),
          ));
        }
      },
      onFavTap: () {
        FavouritesList.favouriteList.add({
          "name": card1Name,
          "pic": card1Pic,
        });
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ FIXED: correct key names, no typo
    final List listBusiness  = AppdataModal.listBookSections[0]['listBusiness'];
    final List listChildrens = AppdataModal.listBookSections[0]['listChildrens'];
    final List listPoetry    = AppdataModal.listBookSections[0]['listPoetry'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header
            SlideTransition(
              position: _headerSlide,
              child: FadeTransition(
                opacity: _headerFade,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 8),
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
                                  child: Image.network(
                                    url,
                                    cacheWidth: 140,
                                    cacheHeight: 140,
                                  ),
                                ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 35, left: 20),
                          child: Text(
                            name.isNotEmpty ? "Hi, $name" : "Welcome",
                            style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              shadows: const [
                                Shadow(
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
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Book sections
            Expanded(
              child: SlideTransition(
                position: _contentSlide,
                child: FadeTransition(
                  opacity: _contentFade,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        _SectionTitle(title: "Educational & Academic >", color: AppColor.color1),
                        SizedBox(
                          height: 235,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            addRepaintBoundaries: true,
                            itemCount: AppdataModal.listEducation.length,
                            itemBuilder: (context, index) => sectionCards(
                              card1Name: AppdataModal.listEducation[index]['cardname'],
                              card1Pic:  AppdataModal.listEducation[index]['cardpic'],
                              index:     index,
                              listdata:  AppdataModal.listEducation,
                            ),
                          ),
                        ),

                        _SectionTitle(title: "Business & Finance >", color: AppColor.color5),
                        SizedBox(
                          height: 235,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            addRepaintBoundaries: true,
                            itemCount: listBusiness.length,
                            itemBuilder: (context, index) => sectionCards(
                              card1Name: listBusiness[index]['cardname'],
                              card1Pic:  listBusiness[index]['cardpic'],
                              index:     index,
                              listdata:  listBusiness,
                            ),
                          ),
                        ),

                        _SectionTitle(title: "Children's Books >", color: AppColor.color6),
                        SizedBox(
                          height: 235,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            addRepaintBoundaries: true,
                            itemCount: listChildrens.length,
                            itemBuilder: (context, index) => sectionCards(
                              card1Name: listChildrens[index]['cardname'],
                              card1Pic:  listChildrens[index]['cardpic'],
                              index:     index,
                              listdata:  listChildrens,
                            ),
                          ),
                        ),

                        _SectionTitle(title: "Poetry >", color: AppColor.color6),
                        SizedBox(
                          height: 235,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            addRepaintBoundaries: true,
                            itemCount: listPoetry.length,
                            itemBuilder: (context, index) => sectionCards(
                              card1Name: listPoetry[index]['cardname'],
                              card1Pic:  listPoetry[index]['cardpic'],
                              index:     index,
                              listdata:  listPoetry,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AnimatedChatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatBotScreen()),
          );
        },
      ),
    );
  }
}

// ── Section title ──────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  final Color  color;
  const _SectionTitle({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 2),
      child: Text(
        title,
        style: GoogleFonts.quicksand(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}

// ── Book card ──────────────────────────────────────────────────────
class _BookCard extends StatefulWidget {
  final String cardName;
  final String cardPic;
  final VoidCallback onTap;
  final VoidCallback onFavTap;

  const _BookCard({
    required this.cardName,
    required this.cardPic,
    required this.onTap,
    required this.onFavTap,
  });

  @override
  State<_BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<_BookCard> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15, top: 10),
      width: 175,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 175,
                height: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.cardPic,
                        width: 175,
                        height: 175,
                        fit: BoxFit.cover,
                        cacheWidth: 350,
                        cacheHeight: 350,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => _isFav = !_isFav);
                        if (_isFav) widget.onFavTap();
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, anim) => ScaleTransition(
                          scale: anim, child: child,
                        ),
                        child: Icon(
                          _isFav ? Icons.favorite : Icons.favorite_border,
                          key: ValueKey(_isFav),
                          color: _isFav ? Colors.red : Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: SizedBox(
              width: 175,
              child: Text(
                widget.cardName,
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
