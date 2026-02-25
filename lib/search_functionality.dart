import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchExample(),
    );
  }
}

class SearchExample extends StatefulWidget {
  @override
  _SearchExampleState createState() => _SearchExampleState();
}

class _SearchExampleState extends State<SearchExample> {
  // List of all items we want to search.
  List<Map> allItems = [{
      'cardname': 'Mastering Dart Programming',
      'cardpic': "assets/images/educational/engineeringbooks/dart.png",
      'price': 5,
      'description':
          'A comprehensive guide to Dart programming, covering concepts, syntax, and real-world examples for efficient app development.'
    },
    {
      'cardname': 'Clean Code',
      'cardpic': "assets/images/educational/engineeringbooks/cleancode.png",
      'price': 5,
      'description':
          'Learn to write clean, maintainable, and efficient code for better software development practices and collaboration.'
    },
    {
      'cardname': 'Python Crash Course',
      'cardpic': "assets/images/educational/engineeringbooks/python.png",
      'price': 5,
      'description':
          'An introductory guide to Python programming, covering fundamentals, real-world projects, and hands-on coding practices.'
    },
    {
      'cardname': 'Java: The Complete Reference',
      'cardpic': "assets/images/educational/engineeringbooks/java.png",
      'price': 5,
      'description':
          'A comprehensive guide to mastering Java, including syntax, APIs, and advanced programming concepts.'
    },
    {
      'cardname': 'You Don’t Know JS',
      'cardpic': "assets/images/educational/engineeringbooks/js.png",
      'price': 5,
      'description':
          'A deep dive into JavaScript, exploring core concepts and advanced techniques for modern web development.'
    },
    {
      'cardname': 'The C Programming Language',
      'cardpic': "assets/images/educational/engineeringbooks/cprogramming.png",
      'price': 5,
      'description':
          'The definitive guide to C, co-authored by its creators, covering language basics and advanced programming techniques.'
    },
    {
      'cardname': 'Foundations of Law',
      'cardpic': "assets/images/educational/lawbooks/Foundations_of_Law.png",
      'price': 5,
      'description':
          'An essential guide to legal principles, providing clear insights into law foundations, interpretations, and applications.'
    },
    {
      'cardname': 'The Constitution Explained',
      'cardpic':
          "assets/images/educational/lawbooks/The_Constitution_Explained.png",
      'price': 5,
      'description':
          'A deep dive into the Constitution, simplifying its articles, amendments, and historical significance for all readers.'
    },
    {
      'cardname': 'Criminal Justice Basics',
      'cardpic':
          "assets/images/educational/lawbooks/Criminal_Justice_Basics.png",
      'price': 5,
      'description':
          'Explores the fundamentals of criminal justice, covering essential laws, case studies, and court procedures.'
    },
    {
      'cardname': 'Civil Law Essentials',
      'cardpic': "assets/images/educational/lawbooks/Civil_Law_Essentials.png",
      'price': 5,
      'description':
          'Breaks down civil law concepts with easy-to-follow examples, offering an invaluable resource for beginners and professionals alike.'
    },
    {
      'cardname': 'Ethics in Law',
      'cardpic': "assets/images/educational/lawbooks/Ethics_in_Law.png",
      'price': 5,
      'description':
          'Discusses the role of ethics in law, offering thought-provoking perspectives on justice and legal morality'
    },
    {
      'cardname': 'International Law Simplified',
      'cardpic':
          "assets/images/educational/lawbooks/International_Law_Simplified.png",
      'price': 5,
      'description':
          'An approachable guide to international law, explaining treaties, diplomacy, and global regulations in clear terms.'
    },
     {
      'cardname': 'Principles of Accounting',
      'cardpic':
          "assets/images/educational/bcombooks/Principles_of_Accounting.png",
      'price': 5,
      'description':
          'A foundational guide to accounting principles, including financial statements, journal entries, and ledger basics for commerce students.'
    },
    {
      'cardname': 'Business Economics Made Simple',
      'cardpic':
          "assets/images/educational/bcombooks/Business_Economics_Made_Simple.png",
      'price': 5,
      'description':
          'Covers the basics of business economics, focusing on micro and macroeconomic concepts with real-world applications.'
    },
    {
      'cardname': 'Corporate Laws and Governance',
      'cardpic':
          "assets/images/educational/bcombooks/Corporate_Laws_and_Governance.png",
      'price': 5,
      'description':
          'Comprehensive insights into corporate laws, governance policies, and legal compliance for modern business environments.'
    },
    {
      'cardname': 'Marketing Essentials',
      'cardpic': "assets/images/educational/bcombooks/Marketing_Essentials.png",
      'price': 5,
      'description':
          'An essential guide to marketing fundamentals, including strategies, consumer behavior, and digital marketing trends.'
    },
    {
      'cardname': 'Financial Management Basics',
      'cardpic':
          "assets/images/educational/bcombooks/Financial_Management_Basics.png",
      'price': 5,
      'description':
          'Introduces financial management concepts like budgeting, capital structure, and risk analysis for commerce professionals.'
    },
    {
      'cardname': 'Entrepreneurship Development',
      'cardpic':
          "assets/images/educational/bcombooks/Entrepreneurship_Development.png",
      'price': 5,
      'description':
          'Explores entrepreneurship concepts, focusing on innovation, business planning, and growth strategies for aspiring entrepreneurs.'
    },
     {
      'cardname': 'Essentials of Human Anatomy',
      'cardpic':
          "assets/images/educational/mbbsbooks/Essentials_of_Human_Anatomy.png",
      'price': 5,
      'description':
          'Comprehensive guide to human anatomy, detailing body systems with diagrams and clinical correlations for medical students.'
    },
    {
      'cardname': 'Pathology: The Basis of Disease',
      'cardpic':
          "assets/images/educational/mbbsbooks/Pathology_The_Basis_of_Disease.png",
      'price': 5,
      'description':
          'Covers the mechanisms of diseases with a focus on diagnostic techniques, pathology processes, and clinical implications.'
    },
    {
      'cardname': 'Pharmacology for Medical Students',
      'cardpic':
          "assets/images/educational/mbbsbooks/Pharmacology_for_Medical_Students.png",
      'price': 5,
      'description':
          'Detailed overview of drug mechanisms, pharmacokinetics, and clinical pharmacology tailored for MBBS learners.'
    },
    {
      'cardname': 'Clinical Medicine: Principles and Practice',
      'cardpic':
          "assets/images/educational/mbbsbooks/Clinical_Medicine_Principles_and_Practice.png",
      'price': 5,
      'description':
          'Focuses on patient diagnosis, clinical techniques, and treatment protocols, bridging theory and medical practice'
    },
    {
      'cardname': 'Biochemistry Made Simple',
      'cardpic':
          "assets/images/educational/mbbsbooks/Biochemistry_Made_Simpl.png",
      'price': 5,
      'description':
          'Simplifies complex biochemical processes, offering insights into metabolism, molecular biology, and clinical biochemistry.'
    },
    {
      'cardname': 'Microbiology and Immunology',
      'cardpic':
          "assets/images/educational/mbbsbooks/Microbiology_and_Immunology.png",
      'price': 5,
      'description':
          'Explores microbial pathogens, immunological responses, and laboratory diagnostics critical for understanding infectious diseases'
    },
    
    {
      'cardname': 'Fundamentals of Physics',
      'cardpic':
          "assets/images/educational/bscbooks/Fundamentals_of_Physics.png",
      'price': 5,
      'description':
          'Covers core physics principles, including mechanics, thermodynamics, and electromagnetism, designed for BSc students.'
    },
    {
      'cardname': 'Organic Chemistry Simplified',
      'cardpic':
          "assets/images/educational/bscbooks/Organic_Chemistry_Simplified.png",
      'price': 5,
      'description':
          'Detailed exploration of organic reactions, compounds, and synthesis methods, perfect for chemistry majors.'
    },
    {
      'cardname': 'Principles of Botany',
      'cardpic': "assets/images/educational/bscbooks/Principles_of_Botany.png",
      'price': 5,
      'description':
          'Explains plant biology, taxonomy, and physiology with vivid illustrations and practical applications for BSc students.'
    },
    {
      'cardname': 'Introduction to Zoology',
      'cardpic':
          "assets/images/educational/bscbooks/Introduction_to_Zoology.png",
      'price': 5,
      'description':
          'Comprehensive guide to animal biology, covering evolution, genetics, and physiological processes for zoology enthusiasts.'
    },
    {
      'cardname': 'Mathematics for Scientists',
      'cardpic':
          "assets/images/educational/bscbooks/Mathematics_for_Scientists.png",
      'price': 5,
      'description':
          'Integrates advanced mathematics concepts like calculus, algebra, and statistics for applications in scientific studies'
    },
    {
      'cardname': 'Environmental Science: Concepts and Challenges',
      'cardpic':
          "assets/images/educational/bscbooks/Environmental_Science_Concepts_and_Challenges.png",
      'price': 5,
      'description':
          'Discusses environmental ecosystems, sustainability, and challenges in conservation, ideal for environmental science students.'
    }, ]; //// enter llist here

  // This list will only contain the items that match the search query.
  List<Map<dynamic,dynamic>> displayedItems = [];

  // Controller to get the text input from the search field.
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedItems = allItems; // Start with showing all items.

    // Set up a listener to call `_onSearchChanged` each time the search input changes.
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    // Remove the listener when the widget is removed from the screen to avoid memory leaks.
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  // This function updates `displayedItems` based on the current search query.
  void _onSearchChanged() {
    String query =
        searchController.text.toLowerCase(); // Get the input in lowercase.

    // Update `displayedItems` by filtering items that contain the search term.
    setState(() {
      // displayedItems =
      //     allItems.where((item) => item.toLowerCase().contains(query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Example",
          style: GoogleFonts.lato(), // Use Google Fonts
        ),
      ),
      body: Column(
        children: [
          // Search input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // List of items that match the search query
          Expanded(
            child: ListView.builder(
              itemCount: displayedItems.length, // Number of items to display
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    displayedItems[index] as String,
                    style: GoogleFonts.lato(), // Use Google Fonts here
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
