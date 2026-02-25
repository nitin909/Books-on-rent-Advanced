import 'dart:developer';
//import 'package:books_on_rent/appdata_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrren_cart/appdata_modal.dart';
import 'package:scrren_cart/shopingba.dart';
import 'checkout_screen.dart';
//import 'shopping_bag.dart';

class Detailpage extends StatefulWidget {
  final Map listbook;
  final int index;
  const Detailpage({required this.listbook, required this.index, super.key});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  int con = 0;
  int con1 = 0;

  // Map? listbook;
  // int? index;
  @override
  void initState() {
    super.initState();
    // listbook = widget.listbook;
    // index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    // print(listbook);
    // print(listbook!['books'][index]['cardpic']);
    // log("DETAILS Page: ${widget.listbook}");
    // log("price : ${widget.listbook['books'][widget.index]}");
    // log("Price: ${widget.listbook['books']?[widget.index]?['price'] ?? widget.listbook['price'] ?? 0}");
    // log("Book count: $con");
    // log("Days count: ${widget.listbook != AppdataModal.listEducation}");
    // log("Books: ${widget.listbook['books']}");
    // log("${widget.listbook['cardname']}");
    // log("Price at Index: ${(widget.listbook['books']?[widget.index]?['price']).runtimeType}");
    // log('LIST BOOK : ${widget.listbook['books'][widget.index] }');
    // log("PRICE : ${((widget.listbook['books'][widget.index] == AppdataModal.listBCom[widget.index] || widget.listbook['books'][widget.index] == AppdataModal.listBSC[widget.index] || widget.listbook['books'][widget.index] == AppdataModal.listEngineering[widget.index] || widget.listbook['books'][widget.index] == AppdataModal.listLAW[widget.index] || widget.listbook['books'][widget.index] == AppdataModal.listMBBS[widget.index] || widget.listbook['books'][widget.index] == AppdataModal.listMCom[widget.index]) && (widget.listbook == AppdataModal.listEducation[widget.index]))}");

    // print("${widget.listbook['books'][widget.index]['price']}");

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        offset: Offset(0, 4),
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.circular(15), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 5, // Spread radius
                            blurRadius: 10, // Blur radius
                            offset: Offset(4, 4), // Shadow position (x, y)
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: 350,
                        width: 500,
                        child: Image.asset(
                          widget.listbook['cardpic'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Expanded(
                        child: Text(widget.listbook['cardname'],
                            style: GoogleFonts.quicksand(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Expanded(
                        child: Text(
                            "₹ ${widget.listbook['price'].toString()}/Day",
                            style: GoogleFonts.quicksand(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Book-Count",
                            style: GoogleFonts.quicksand(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        Row(
                          children: [
                            _buildCounterButton(Icons.remove, () {
                              setState(() {
                                if (con > 0) con--;
                              });
                            }),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("$con",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black)),
                            ),
                            _buildCounterButton(Icons.add, () {
                              setState(() {
                                con++;
                              });
                            }),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Days",
                            style: GoogleFonts.quicksand(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        Row(
                          children: [
                            _buildCounterButton(Icons.remove, () {
                              setState(() {
                                if (con1 > 0) con1--;
                              });
                            }),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("$con1",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black)),
                            ),
                            _buildCounterButton(Icons.add, () {
                              setState(() {
                                con1++;
                              });
                            }),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Total: ₹ ${widget.listbook['price'] * con * con1}",
                      style: GoogleFonts.quicksand(
                          fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildActionButton("Add To Cart", () {
                widget.listbook['count'] = con;
                widget.listbook['days'] = con1;
                AppdataModal.listcart.add(widget.listbook);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ShoppingBag();
                }));
              }),
              _buildActionButton("Checkout", () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CheckoutScreen(amount: widget.listbook['price']);
                }));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue),
        ),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 48,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.quicksand(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
