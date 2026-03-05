import 'package:flutter/material.dart';
import 'package:scrren_cart/ss.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgScaleController;
  late AnimationController _textController;
  late AnimationController _pulseController;

  late Animation<double> _bgScale;
  late Animation<double> _booksOpacity;
  late Animation<Offset>  _booksSlide;
  late Animation<double> _onRentOpacity;
  late Animation<Offset>  _onRentSlide;
  late Animation<double> _spinnerOpacity;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();

    // Ken Burns slow zoom
    _bgScaleController = AnimationController(
      vsync: this, duration: const Duration(seconds: 6),
    )..forward();
    _bgScale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _bgScaleController, curve: Curves.easeInOut),
    );

    // Staggered entrance — total 1600ms
    _textController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1600),
    );

    // "Books" — drops in from top (0–45%)
    _booksOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController,
          curve: const Interval(0.0, 0.45, curve: Curves.easeOut)),
    );
    _booksSlide = Tween<Offset>(
      begin: const Offset(0, -0.8), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack)));

    // "On Rent" — rises from bottom (30–75%)
    _onRentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController,
          curve: const Interval(0.3, 0.75, curve: Curves.easeOut)),
    );
    _onRentSlide = Tween<Offset>(
      begin: const Offset(0, 0.8), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController,
        curve: const Interval(0.3, 0.75, curve: Curves.easeOutBack)));

    // Spinner — fades in last, after both words settle (70–100%)
    _spinnerOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController,
          curve: const Interval(0.7, 1.0, curve: Curves.easeIn)),
    );

    // Pulse loop on spinner
    _pulseController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 850),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) _textController.forward();
    });

    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => HomePage1(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _bgScaleController.dispose();
    _textController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060A18),
      body: Stack(
        fit: StackFit.expand,
        children: [

          // Ken Burns zoom background
          AnimatedBuilder(
            animation: _bgScale,
            builder: (_, __) => Transform.scale(
              scale: _bgScale.value,
              child: Image.asset('assets/bookLogo.png', fit: BoxFit.cover),
            ),
          ),

          // Subtle dark overlay so text pops
          Container(color: Colors.black.withOpacity(0.15)),

          // ORDER: Books → On Rent → Spinner (below)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // 1️⃣ "Books" — slides down from top
              SlideTransition(
                position: _booksSlide,
                child: FadeTransition(
                  opacity: _booksOpacity,
                  child: Text(
                    'Books',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.7),
                          offset: const Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 2️⃣ "On Rent" — slides up from bottom
              SlideTransition(
                position: _onRentSlide,
                child: FadeTransition(
                  opacity: _onRentOpacity,
                  child: Text(
                    'On Rent',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.7),
                          offset: const Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // 3️⃣ Spinner — fades + pulses BELOW both words
              ScaleTransition(
                scale: _pulse,
                child: FadeTransition(
                  opacity: _spinnerOpacity,
                  child: const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('This is the home screen')),
    );
  }
}