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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Order",
          style: GoogleFonts.quicksand(
              fontSize: 20, fontWeight: FontWeight.w700),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Mynavbar()),
              );
            },
            child: const Icon(Icons.home, size: 30),
          )
        ],
      ),

      body: ListView.builder(
        itemCount: AppdataModal.listorder.length,

        itemBuilder: (context, index) {

          final book = AppdataModal.listorder[index];

          return Container(
            height: 170,
            margin: const EdgeInsets.all(15),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                  color: AppColor.color3,
                  blurStyle: BlurStyle.outer,
                )
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.all(12),

              child: Row(
                children: [

                  /// BOOK IMAGE CONTAINER
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    /// CLOUDINARY IMAGE (CURRENT)
                    child: Image.network(
                      book['cardpic'],
                      fit: BoxFit.cover,

                      /// Loading indicator
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },

                      /// If image fails
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 40);
                      },
                    ),

                    /*
                    -----------------------------------------------
                    OLD LOCAL ASSET VERSION (COMMENTED)
                    If you ever want to switch back to local images
                    just remove the network image above and use this
                    -----------------------------------------------

                    child: Image.asset(
                      AppdataModal.listorder[index]['cardpic'],
                      fit: BoxFit.cover,
                    ),

                    */
                  ),

                  const SizedBox(width: 20),

                  /// BOOK DETAILS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        /// BOOK NAME
                        Text(
                          book['cardname'],
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 6),

                        /// PRICE
                        Text(
                          "₹ ${book['price']}",
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 6),

                        /// ORDER ID
                        Text(
                          "Order Id : ${index + 1}",
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}