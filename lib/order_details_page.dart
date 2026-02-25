import 'package:scrren_cart/first.dart';
import 'package:scrren_cart/home1.dart';

import './appcolor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appdata_modal.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.color4,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Mynavbar();
              }));
            },
            child: Icon(size: 30, Icons.home),
          )
        ],
        backgroundColor: Colors.white,
        title: Text(
          "Order",
          style:
              GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: AppdataModal.listorder.length,
          itemBuilder: (context, index) {
            return Container(
              height: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                        color: AppColor.color3,
                        blurStyle: BlurStyle.outer)
                  ]),

              margin: const EdgeInsets.all(15),
              // padding: EdgeInsets.all(4),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                              // decoration:
                              // BoxDecoration(),
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                  AppdataModal.listorder[index]['cardpic'])),
                          const SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Expanded(
                                    child: Text(
                                      AppdataModal.listorder[index]['cardname'],
                                      style: GoogleFonts.quicksand(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$ ${AppdataModal.listorder[index]['price']}",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Order Id  :  ${index + 1}",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
