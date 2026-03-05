// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:scrren_cart/first.dart';
import 'package:scrren_cart/search.dart';

import './fav.dart';
import 'book_detail_page.dart';
import './order_details_page.dart';
import './success_page.dart';
import './home.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:google_fonts/google_fonts.dart";

import 'optionspage.dart';
import 'appcolor.dart';
import 'order_details_page.dart';
import 'appdata_modal.dart';

class Mynavbar extends StatefulWidget {
  const Mynavbar({super.key});
  @override
  State createState() => _navbarState();
}

class _navbarState extends State<Mynavbar> with TickerProviderStateMixin {
  int navbarindex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _selectedIndex = 0;

  // Each tab gets its own AnimationController for the icon bounce
  late List<AnimationController> _iconControllers;
  late List<Animation<double>>   _iconScales;

  // Screen slide animation
  late AnimationController _screenController;
  late Animation<double>   _screenOpacity;

  final List screens = [
    const HomePage(),
    const ListViewAnimation(),
    const OrderDetailsPage(),
    const home(),
  ];

  @override
  void initState() {
    super.initState();

    // Icon bounce controllers — one per tab
    _iconControllers = List.generate(4, (_) => AnimationController(
      vsync: this, duration: const Duration(milliseconds: 350),
    ));
    _iconScales = _iconControllers.map((ctrl) =>
      TweenSequence([
        TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.35), weight: 50),
        TweenSequenceItem(tween: Tween<double>(begin: 1.35, end: 1.0), weight: 50),
      ]).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeOut)),
    ).toList();

    // Screen fade
    _screenController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 250),
    );
    _screenOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _screenController, curve: Curves.easeOut),
    );
    _screenController.forward();
  }

  @override
  void dispose() {
    for (final c in _iconControllers) c.dispose();
    _screenController.dispose();
    super.dispose();
  }

  void _onTabTap(int index) {
    if (_selectedIndex == index) return;

    // Haptic + bounce the tapped icon
    HapticFeedback.lightImpact();
    _iconControllers[index].forward(from: 0);

    // Fade screen transition
    _screenController.reverse().then((_) {
      setState(() => _selectedIndex = index);
      _screenController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _screenOpacity,
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        index: _selectedIndex,
        items: [
          ScaleTransition(
            scale: _iconScales[0],
            child: Icon(Icons.home, color: Colors.white, size: 30),
          ),
          ScaleTransition(
            scale: _iconScales[1],
            child: const Icon(Icons.favorite, color: Colors.white, size: 30),
          ),
          ScaleTransition(
            scale: _iconScales[2],
            child: const Icon(Icons.history, color: Colors.white, size: 30),
          ),
          ScaleTransition(
            scale: _iconScales[3],
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
        ],
        onTap: _onTabTap,
      ),
    );
  }
}
