// import 'dart:developer';

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:scrren_cart/fav.dart';
// import 'package:scrren_cart/first.dart';
// import 'package:scrren_cart/home.dart';
// import 'package:scrren_cart/order_details_page.dart';
// import 'package:scrren_cart/success_page.dart';

// class BottomNavBar extends StatefulWidget {
//   // final String email;
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   List screens = [
//     const HomePage(),
//     const ListViewAnimation(),
//     const OrderDetailsPage(),
//     const SuccessPage(),
//     const home(),
//   ];

//   int _selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: const Color.fromARGB(255, 61, 166, 252),
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.transparent,
//         color: Colors.blue,
//         index: _selectedIndex,
//         items: const [
//           Icon(
//             Icons.home,
//             color: Colors.white,
//             size: 30,
//           ),
//           Icon(
//             Icons.favorite,
//             color: Colors.white,
//             size: 30,
//           ),
//           Icon(
//             Icons.history,
//             color: Colors.white,
//             size: 30,
//           ),
//           Icon(
//             Icons.receipt,
//             color: Colors.white,
//             size: 30,
//           ),
//           Icon(
//             Icons.person,
//             color: Colors.white,
//             size: 30,
//           ),
//         ],
//         onTap: (index) {
//           log("Selected index: ${_selectedIndex}");
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//       body: screens[_selectedIndex],
//     );
//   }
// }
