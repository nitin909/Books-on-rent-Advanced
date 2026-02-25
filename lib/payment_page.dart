import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:scrren_cart/success_page.dart';

class PaymentPage extends StatefulWidget {
  final num amount; //  dynamic amount passed from checkout

  const PaymentPage({super.key, required this.amount});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  String status = "Idle";
  bool loading = false;

  final String razorpayKey = "rzp_test_RdXggD5QuLA4Jj"; //  test key
  final String companyName = "Books on Rent";

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternal);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handleSuccess(PaymentSuccessResponse response) {
    setState(() {
      loading = false;
      status = " Payment Successful!\nPayment ID: ${response.paymentId}";
    });

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessPage()),
      );
    });
  }

  void _handleError(PaymentFailureResponse response) {
    setState(() {
      loading = false;
      status =
          " Payment Failed\nCode: ${response.code}\nMessage: ${response.message}";
    });
  }

  void _handleExternal(ExternalWalletResponse response) {
    setState(() {
      loading = false;
      status = "Wallet selected: ${response.walletName}";
    });
  }

  void startPayment() {
    setState(() {
      loading = true;
      status = "Opening Razorpay...";
    });

    //  Convert rupees → paise (Razorpay expects amount in paise)
    int finalAmount = (widget.amount * 100).toInt();

    var options = {
      'key': razorpayKey,
      'amount': finalAmount,
      'name': companyName,
      'description': 'Book rent payment',
      'prefill': {'contact': '9999999999', 'email': 'tssm@gmail.com'},
      'theme': {'color': '#373D88'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() {
        loading = false;
        status = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/p1.jpg',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.4),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          SafeArea(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.black26,
                      offset: Offset(0, 6),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.book, size: 60, color: Color.fromARGB(255, 95, 217, 233)),
                    const SizedBox(height: 12),
                    const Text(
                      "Books on Rent Payment",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Pay ₹${widget.amount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: loading ? null : startPayment,
                      icon: const Icon(Icons.payment),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Text(
                          loading ? "Processing..." : "Pay Now",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 193, 246, 147),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
const SizedBox(height: 16),

if (status != "Idle") //  only show after payment starts
  Text(
    status,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 13,
      color: status.contains("Failed") ? Colors.red : Colors.black87,
      fontWeight:
          status.contains("Success") ? FontWeight.bold : FontWeight.normal,
    ),
  ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
