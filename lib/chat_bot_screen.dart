import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;

  List<Map<String, dynamic>> messages = [];
  bool isTyping = false;

  bool isDarkMode = false;

  List<String> quickSuggestions = [
    "How to rent?",
    "Return policy",
    "Rental price",
    "Book categories",
    "Late fine"
  ];

  @override
  void initState() {
    super.initState();
    loadChat();
  }

  // ---------------- SAVE CHAT ----------------
  Future<void> saveChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("chat_messages", jsonEncode(messages));
  }

  // ---------------- LOAD CHAT ----------------
  Future<void> loadChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? saved = prefs.getString("chat_messages");

    if (saved != null) {
      setState(() {
        messages = List<Map<String, dynamic>>.from(jsonDecode(saved));
      });
    } else {
      // Default welcome message
      setState(() {
        messages.add({
          "text": "Hi 👋 I'm your Books on Rent assistant.\nAsk me anything!",
          "isUser": false,
          "time": DateTime.now().toString(),
          "status": "seen", // seen / delivered
        });
      });
    }
  }

  // ---------------- CLEAR CHAT ----------------
  Future<void> clearChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("chat_messages");

    setState(() {
      messages.clear();
      messages.add({
        "text": "Hi 👋 I'm your Books on Rent assistant.\nAsk me anything!",
        "isUser": false,
        "time": DateTime.now().toString(),
        "status": "seen",
      });
    });

    saveChat();
  }

  // ---------------- SEND MESSAGE ----------------
  void sendMessage([String? suggestion]) {
    String userMsg = suggestion ?? _controller.text.trim();
    if (userMsg.isEmpty) return;

    setState(() {
      messages.add({
        "text": userMsg,
        "isUser": true,
        "time": DateTime.now().toString(),
        "status": "delivered", // delivered first
      });
    });

    _controller.clear();
    scrollToBottom();
    saveChat();

    // Mark user msg as seen after delay (realistic)
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        messages[messages.length - 1]["status"] = "seen";
      });
      saveChat();
    });

    botReply(userMsg);
  }

  // ---------------- BOT REPLY ----------------
  void botReply(String userMsg) async {
    setState(() {
      isTyping = true;
    });

    scrollToBottom();

    await Future.delayed(const Duration(seconds: 2));

    String reply = getBotReply(userMsg);

    setState(() {
      isTyping = false;
      messages.add({
        "text": reply,
        "isUser": false,
        "time": DateTime.now().toString(),
        "status": "seen",
      });
    });

    saveChat();
    scrollToBottom();
  }

  // ---------------- CHATBOT LOGIC ----------------
  String getBotReply(String msg) {
    msg = msg.toLowerCase();

    if (msg.contains("rent") || msg.contains("borrow")) {
      return "To rent a book 📚:\n\n1. Open category\n2. Select book\n3. Click Rent button\n4. Choose rental duration";
    } else if (msg.contains("price") ||
        msg.contains("cost") ||
        msg.contains("fees")) {
      return "Rental price depends on category and duration.\n\nExample:\nEngineering book → ₹30/day\nChildren book → ₹15/day";
    } else if (msg.contains("return")) {
      return "To return a book:\n\nGo to My Rentals → Select book → Click Return.";
    } else if (msg.contains("late") || msg.contains("fine")) {
      return "Late fine is calculated per day.\nExample: ₹5 per late day.\n\nTry to return books on time 🙂";
    } else if (msg.contains("categories")) {
      return "Available categories 📚:\n\n✅ Engineering\n✅ Law\n✅ MBBS\n✅ Business & Finance\n✅ Children Books\n✅ Poetry";
    } else if (msg.contains("hello") || msg.contains("hi")) {
      return "Hello 👋 How can I help you today?";
    } else if (msg.contains("contact")) {
      return "You can contact support:\n📧 support@booksonrent.com\n📞 +91 98765 43210";
    } else {
      return "Sorry 😅 I didn’t understand.\n\nTry asking about:\nRent, Return, Price, Fine, Categories.";
    }
  }

  // ---------------- SCROLL ----------------
  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ---------------- TIME FORMAT ----------------
  String formatTime(String timeString) {
    DateTime time = DateTime.parse(timeString);

    int hour = time.hour;
    int minute = time.minute;

    String ampm = hour >= 12 ? "PM" : "AM";
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;

    String min = minute < 10 ? "0$minute" : "$minute";

    return "$hour:$min $ampm";
  }

  // ---------------- VOICE INPUT ----------------
  Future<void> listenVoice() async {
    bool available = await _speech.initialize();

    if (!available) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Speech recognition not available")),
      );
      return;
    }

    if (!isListening) {
      setState(() {
        isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
          });
        },
      );
    } else {
      setState(() {
        isListening = false;
      });
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFF4F6FA);
    Color inputBg = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    Color fieldBg = isDarkMode ? const Color(0xFF2A2A2A) : const Color(0xFFF2F2F2);
    Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Books Assistant",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: clearChat,
          ),
        ],
      ),
      body: Column(
        children: [
          // Suggestions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: quickSuggestions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ActionChip(
                    backgroundColor: Colors.deepPurple.shade100,
                    label: Text(
                      quickSuggestions[index],
                      style: const TextStyle(color: Colors.deepPurple),
                    ),
                    onPressed: () {
                      sendMessage(quickSuggestions[index]);
                    },
                  ),
                );
              },
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length + (isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (isTyping && index == messages.length) {
                  return const Align(
                    alignment: Alignment.centerLeft,
                    child: TypingBubble(),
                  );
                }

                bool isUser = messages[index]["isUser"];
                String text = messages[index]["text"];
                String time = messages[index]["time"];
                String status = messages[index]["status"];

                return AnimatedMessageBubble(
                  text: text,
                  isUser: isUser,
                  time: formatTime(time),
                  status: status,
                  isDarkMode: isDarkMode,
                );
              },
            ),
          ),

          // Input Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: inputBg,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white54 : Colors.black45,
                      ),
                      filled: true,
                      fillColor: fieldBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Voice Button
                CircleAvatar(
                  radius: 22,
                  backgroundColor: isListening ? Colors.red : Colors.grey,
                  child: IconButton(
                    icon: Icon(
                      isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                    ),
                    onPressed: listenVoice,
                  ),
                ),

                const SizedBox(width: 8),

                // Send Button
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.deepPurple,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      sendMessage();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- ANIMATED CHAT BUBBLE ----------------

class AnimatedMessageBubble extends StatefulWidget {
  final String text;
  final bool isUser;
  final String time;
  final String status;
  final bool isDarkMode;

  const AnimatedMessageBubble({
    super.key,
    required this.text,
    required this.isUser,
    required this.time,
    required this.status,
    required this.isDarkMode,
  });

  @override
  State<AnimatedMessageBubble> createState() => _AnimatedMessageBubbleState();
}

class _AnimatedMessageBubbleState extends State<AnimatedMessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(_controller);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData getTickIcon() {
    if (widget.status == "seen") {
      return Icons.done_all; // ✔✔
    } else {
      return Icons.done; // ✔
    }
  }

  @override
  Widget build(BuildContext context) {
    Color userBubble = Colors.deepPurple;
    Color botBubble = widget.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Row(
          mainAxisAlignment:
              widget.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isUser)
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.smart_toy, color: Colors.white, size: 18),
              ),
            if (!widget.isUser) const SizedBox(width: 8),

            Flexible(
              child: Column(
                crossAxisAlignment: widget.isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: widget.isUser ? userBubble : botBubble,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft:
                            Radius.circular(widget.isUser ? 18 : 0),
                        bottomRight:
                            Radius.circular(widget.isUser ? 0 : 18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        color: widget.isUser
                            ? Colors.white
                            : (widget.isDarkMode
                                ? Colors.white
                                : Colors.black87),
                        fontSize: 15,
                      ),
                    ),
                  ),

                  // Time + Ticks
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.time,
                        style: TextStyle(
                          fontSize: 11,
                          color: widget.isDarkMode
                              ? Colors.white54
                              : Colors.black45,
                        ),
                      ),
                      const SizedBox(width: 5),

                      if (widget.isUser)
                        Icon(
                          getTickIcon(),
                          size: 16,
                          color: widget.status == "seen"
                              ? Colors.blue
                              : Colors.grey,
                        ),
                    ],
                  ),
                ],
              ),
            ),

            if (widget.isUser) const SizedBox(width: 8),

            if (widget.isUser)
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------- TYPING ANIMATION ----------------

class TypingBubble extends StatefulWidget {
  const TypingBubble({super.key});

  @override
  State<TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<TypingBubble> {
  int dotCount = 1;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      setState(() {
        dotCount++;
        if (dotCount > 3) dotCount = 1;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dots = "." * dotCount;

    return Row(
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundColor: Color.fromARGB(255, 44, 205, 246),
          child: Icon(Icons.smart_toy, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 8),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Text(
            "Typing$dots",
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}

