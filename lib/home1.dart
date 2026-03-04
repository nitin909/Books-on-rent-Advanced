// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:scrren_cart/first.dart';
import 'package:scrren_cart/search.dart';

import './fav.dart';
import 'book_detail_page.dart';
import './order_details_page.dart';
import './success_page.dart';
import 'book_detail_page.dart';
import './home.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import 'optionspage.dart';
import 'book_detail_page.dart';
import 'appcolor.dart';
import 'order_details_page.dart';
import 'appdata_modal.dart';

class Mynavbar extends StatefulWidget {
  const Mynavbar({super.key});
  @override
  State createState() {
    return _navbarState();
  }
}

class _navbarState extends State {
  int navbarindex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List screens = [
    const HomePage(),
    const ListViewAnimation(),
    const OrderDetailsPage(),
    const home(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        index: _selectedIndex,
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
          const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 30,
          ),
          const Icon(
            Icons.history,
            color: Colors.white,
            size: 30,
          ),
          const Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
