import 'package:flutter/material.dart';

class AnimatedChatButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AnimatedChatButton({super.key, required this.onPressed});

  @override
  State<AnimatedChatButton> createState() => _AnimatedChatButtonState();
}

class _AnimatedChatButtonState extends State<AnimatedChatButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> glowAnim;

  bool isHovered = false;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    glowAnim = Tween<double>(begin: 8.0, end: 18.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double getScale() {
    if (isPressed) return 0.97;
    if (isHovered) return 1.08;
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),
        child: AnimatedBuilder(
          animation: glowAnim,
          builder: (context, child) {
            return AnimatedScale(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              scale: getScale(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),

                  // ✅ Matching blue theme
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF007BFF), // strong blue
                      Color(0xFF00B0FF), // sky blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  // ✅ Glassy border
                  border: Border.all(
                    color: Colors.white.withOpacity(isHovered ? 0.55 : 0.30),
                    width: 1.2,
                  ),

                  // ✅ Ultra premium glow + shadow
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF007BFF).withOpacity(0.55),
                      blurRadius: isHovered ? 35 : glowAnim.value,
                      spreadRadius: isHovered ? 2.5 : 1.5,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon bubble
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.22),
                      ),
                      child: const Icon(
                        Icons.headset_mic_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Text
                    const Text(
                      "Need Help?",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        letterSpacing: 0.4,
                      ),
                    ),

                    const SizedBox(width: 6),

                    // Shine Dot
                    Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}