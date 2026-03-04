import 'package:scrren_cart/home1.dart';

import './appdata_modal.dart';
import './checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrren_cart/appdata_modal.dart';
import 'package:scrren_cart/checkout_screen.dart';
import 'appcolor.dart';

num getSubtotal() {
  // Calculate subtotal dynamically
  num totalamount = 0;
  for (var item in AppdataModal.listcart) {
    totalamount += item['price'] * item['days'] * item['count'];
  }
  return totalamount;
}

class ShoppingBag extends StatefulWidget {
  const ShoppingBag({super.key});

  @override
  State<ShoppingBag> createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColor.color4,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Shopping Bag",
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Mynavbar();
                  },),);
                },
                icon: Icon(Icons.home))
          ],
        ),
        body: Column(
          children: [
            // ListView of items
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: AppdataModal.listcart.length,
                itemBuilder: (context, index) {
                  return itemCard(index);
                },
              ),
            ),
            const Divider(height: 1, thickness: 2.0),
            // Bottom summary and order button
            bottomSummary(0),
          ],
        ),
      ),
    );
  }
  //// item card insert here

  Widget itemCard(int index) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColor.color4),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(0, 1),
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            margin: const EdgeInsets.all(10),
            height: 100,
            width: 100,
            child: Image.network(
              AppdataModal.listcart[index]['cardpic'],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.broken_image),
            ),
          ),
          // Details and actions
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book Name
                Row(
                  children: [
                    const Icon(Icons.book, color: Colors.black),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 220,
                      child: Expanded(
                        child: Text(
                          "Book Name: ${AppdataModal.listcart[index]['cardname']}",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColor.color2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Price
                Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.black),
                    const SizedBox(width: 5),
                    Text(
                      "Price: ₹${AppdataModal.listcart[index]['price']}/day",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    const Icon(Icons.confirmation_number, color: Colors.black),
                    const SizedBox(width: 5),
                    Text(
                      "Count: ${AppdataModal.listcart[index]['count']}",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                // Count
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.black),
                    const SizedBox(width: 5),
                    Text(
                      "total : ${AppdataModal.listcart[index]['price'] * AppdataModal.listcart[index]['days'] * AppdataModal.listcart[index]['count']} ",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),
                // Number of Days
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.black),
                    const SizedBox(width: 5),
                    Text(
                      "No. of Days: ${AppdataModal.listcart[index]['days']}",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    IconButton(
                      onPressed: () {
                        AppdataModal.listcart.removeAt(index);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete_outline, color: AppColor.color5),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Quantity and delete actions
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget quantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(232, 232, 232, 1),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black),
      ),
    );
  }

  Widget bottomSummary(int index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          summaryRow("Subtotal", "₹ ${getSubtotal()}"),
          summaryRow("Shipping", "₹ ${10}"),
          summaryRow("Grand Total", "₹ ${getSubtotal() + 10}"),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // AppdataModal.listorder.add({
              //   'name': AppdataModal.listcart[index],
              //   'price': getSubtotal() + 10
              // });

              num totalamount = getSubtotal();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CheckoutScreen(
                  amount: (totalamount + 10),
                ),
              ));
            },
            child: Center(
              child: Container(
                height: 50,
                width: 321,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.color1,
                ),
                child: Center(
                  child: Text(
                    "Pay and Place Order",
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget summaryRow(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.quicksand(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        Text(
          value.toString(),
          style: GoogleFonts.quicksand(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
