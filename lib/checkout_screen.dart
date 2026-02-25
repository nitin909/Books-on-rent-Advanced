import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrren_cart/appdata_modal.dart';
import 'package:scrren_cart/appcolor.dart';
import 'package:scrren_cart/success_page.dart';
import 'package:scrren_cart/payment_page.dart'; // Razorpay page

class CheckoutScreen extends StatefulWidget {
  final num amount;

  const CheckoutScreen({
    required this.amount,
    super.key,
  });

  @override
  State createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _onChange = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.color4,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Checkout",
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery Address",
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildAddressCard(
                    index: 1,
                    text:
                        "CRVM+92G, 31/52, Gate Number 1, Near BSCOER, Bhairavnath Nagar, Narhe, Pune, Maharashtra 411041",
                  ),
                  const SizedBox(width: 10),
                  _buildAddressCard(
                    index: 2,
                    text:
                        "85 A, Sankalp City, Ranjangaon Ganpati, Tal.- Shirur, Dist- Pune",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Amount Payable",
                    style: GoogleFonts.quicksand(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "₹ ${widget.amount}",
                    style: GoogleFonts.quicksand(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // ✅ Razorpay Payment Button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.payment, color: Colors.white),
                label: const Text(
                  'Proceed to Pay',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // 🟢 Navigate to Razorpay page with dynamic amount
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(amount: widget.amount),
                    ),
                  );

                  // 🟢 On successful payment
                  if (result == 'success') {
                    AppdataModal.listorder = AppdataModal.listcart;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuccessPage(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Address Card Builder
  Widget _buildAddressCard({required int index, required String text}) {
    return Container(
      width: 235,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),
      child: Row(
        children: [
          Radio(
            value: index,
            groupValue: _onChange,
            onChanged: (value) {
              setState(() {
                _onChange = value!;
              });
            },
            activeColor: Colors.white,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Text(
                  text,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
