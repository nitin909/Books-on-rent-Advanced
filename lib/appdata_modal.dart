class AppdataModal {
  // LIST OF BOOKS IN SECTION
  //ENGINNERING BOOKS
  bool isfav = false;



  static List listsearch = [
    {
      'cardname': 'Mastering ',
      'cardpic': "assets/images/educational/engineeringbooks/b1.jpg",
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
    },
  ];

  static List listEngineering = [
   {
  'cardname': 'Radiation and Microwave Theory',
  'cardpic': "assets/images/educational/engineeringbooks/rmt.jpg",
  'price': 5,
  'description':
      'Comprehensive study of electromagnetic wave propagation, antennas, microwave components, and transmission line theory for modern communication systems.'
},
{
  'cardname': 'Cloud Computing',
  'cardpic': "assets/images/educational/engineeringbooks/cc.jpg",
  'price': 5,
  'description':
      'Explains cloud architecture, virtualization, and service models (IaaS, PaaS, SaaS), with practical insights into AWS, Google Cloud, and Azure platforms.'
},
{
  'cardname': 'Data Mining',
  'cardpic': "assets/images/educational/engineeringbooks/dm.jpg",
  'price': 5,
  'description':
      'Covers data preprocessing, clustering, classification, and association rule mining techniques for extracting useful patterns from large datasets.'
},
{
  'cardname': 'Modernized IoT',
  'cardpic': "assets/images/educational/engineeringbooks/miot.jpg",
  'price': 5,
  'description':
      'Focuses on modern IoT architecture, sensor networks, cloud integration, and smart applications using embedded systems and real-time analytics.'
},
{
  'cardname': 'VLSI Design and Technology',
  'cardpic': "assets/images/educational/engineeringbooks/vdt.jpg",
  'price': 5,
  'description':
      'A complete overview of CMOS technology, chip design flow, fabrication processes, and optimization techniques used in advanced integrated circuits.'
},
 
  ];
  // LAW BOOKS
  static List listLAW = [
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
  ];
  // BCOM BOOKS
  static List listBCom = [
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
  ];

  // MCOM BOOKS
  static List listMCom = [
    {
      'cardname': 'Advanced Financial Accounting',
      'cardpic':
          "assets/images/educational/mcombooks/Advanced_Financial_Accounting.png",
      'price': 5,
      'description':
          'An in-depth guide to financial accounting practices, covering consolidations, IFRS, and advanced reporting techniques for professionals.'
    },
    {
      'cardname': 'International Business Management',
      'cardpic':
          "assets/images/educational/mcombooks/International_Business_Management.png",
      'price': 5,
      'description':
          'Explores global trade strategies, international markets, and cross-border management principles for commerce students and professionals.'
    },
    {
      'cardname': 'Corporate Taxation and Planning',
      'cardpic':
          "assets/images/educational/mcombooks/Corporate_Taxation_and_Planning.png",
      'price': 5,
      'description':
          'Covers corporate tax laws, tax planning strategies, and compliance for businesses, emphasizing case studies and practical applications.'
    },
    {
      'cardname': 'Strategic Management Concept',
      'cardpic':
          "assets/images/educational/mcombooks/Strategic_Management_Concept.png",
      'price': 5,
      'description':
          'Provides insights into strategic planning, decision-making frameworks, and competitive analysis for modern business leaders.'
    },
    {
      'cardname': 'Research Methodology in Commerce',
      'cardpic':
          "assets/images/educational/mcombooks/Research_Methodology_in_Commerce.png",
      'price': 5,
      'description':
          'Comprehensive coverage of research techniques, statistical analysis, and report writing tailored for MCom students.'
    },
    {
      'cardname': 'Investment Analysis and Portfolio Management',
      'cardpic':
          "assets/images/educational/mcombooks/Investment_Analysis_and_Portfolio_Management.png",
      'price': 5,
      'description':
          'Detailed insights into investment strategies, portfolio optimization, and financial risk management for advanced learners'
    },
  ];
  // MBBS BOOKS
  static List listMBBS = [
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
  ];
  // BSC BOOKS
  static List listBSC = [
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
    },
  ];

  // LIST OF SECTIONS IN EDUCATION & ACADEMICS
  static List listEducation = [
    {
      'cardname': 'Engineering',
      'cardpic': "assets/images/educational/engineering.png",
      'branches': ['Computer', 'IT', 'E&TC', 'Civil', 'AIML', 'Printing'],
      'years': ['First Year', 'Second Year', 'Third Year', 'Fourth Year'],
      'publications': ['TechMax', 'Nirali', 'McGraw Hill'],
      'books': listEngineering,
    },
    {
      'cardname': 'LAW',
      'cardpic': "assets/images/educational/lawbook.png",
      'branches': ['Law1', 'law2', 'E&TC', 'Civil', 'AIML', 'Printing'],
      'years': ['First Year', 'Second Year', 'Third Year', 'Fourth Year'],
      'publications': ['TechMax', 'Nirali', 'McGraw Hill'],
      'books': listLAW,
    },
    {
      'cardname': 'BCom',
      'cardpic': "assets/images/educational/bcom.png",
      'branches': ['Computer', 'IT', 'E&TC', 'Civil', 'AIML', 'Printing'],
      'years': ['First Year', 'Second Year', 'Third Year', 'Fourth Year'],
      'publications': ['TechMax', 'Nirali', 'McGraw Hill'],
      'books': listBCom,
    },
    {
      'cardname': 'MCom',
      'cardpic': "assets/images/educational/mcom.png",
      'branches': ['Computer', 'IT', 'E&TC', 'Civil', 'AIML', 'Printing'],
      'years': ['First Year', 'Second Year', 'Third Year', 'Fourth Year'],
      'publications': ['TechMax', 'Nirali', 'McGraw Hill'],
      'books': listMCom,
    },
    {
      'cardname': 'MBBS',
      'cardpic': "assets/images/educational/mbbs.png",
      'branches': ['Computer', 'IT', 'E&TC', 'Civil', 'AIML', 'Printing'],
      'years': ['First Year', 'Second Year', 'Third Year', 'Fourth Year'],
      'publications': ['TechMax', 'Nirali', 'McGraw Hill'],
      'books': listMBBS,
    },
    {
      'cardname': 'BSC',
      'cardpic': "assets/images/educational/bsc.png",
      'branches': ['Computer', 'IT', 'E&TC', 'Civil', 'AIML', 'Printing'],
      'years': ['First Year', 'Second Year', 'Third Year', 'Fourth Year'],
      'publications': ['TechMax', 'Nirali', 'McGraw Hill'],
      'books': listBSC,
    },
  ];

  // LIST OF BOOKS
  static List listBookSections = [
    {
      // BUSSINESS BOOKS
      'listBusiness': [
        {
          'cardname': 'Rich Dad Poor Dad',
          'cardpic': "assets/images/business/richdadpoordad.png",
          'price': 5,
        },
        {
          'cardname': 'The Lean Startup',
          'cardpic': "assets/images/business/theleanstartup.png",
          'price': 5,
        },
        {
          'cardname': 'Think and Grow Rich',
          'cardpic': "assets/images/business/thinkrichgrowrich.png",
          'price': 5,
        },
        {
          'cardname': 'The Intelligent Investor',
          'cardpic': "assets/images/business/theintelligentinvestor.png",
          'price': 5,
        },
        {
          'cardname': 'Principles: Life and Work',
          'cardpic': "assets/images/business/principles.png",
          'price': 5,
        },
        {
          'cardname': 'Atomic Habits',
          'cardpic': "assets/images/business/atomichabits.png",
          'price': 5,
        },
      ],
      // CHILDRENS BOOKS
      'listChildrens': [
        {
          'cardname': 'The Very Hungry Caterpillar',
          'cardpic': "assets/images/childrens/caterpiller.png",
          'price': 5,
        },
        {
          'cardname': 'Charloettes Web',
          'cardpic': "assets/images/childrens/charlottesweb.png",
          'price': 5,
        },
        {
          'cardname': 'Where the Wild Things Are',
          'cardpic': "assets/images/childrens/wildthings.png",
          'price': 5,
        },
        {
          'cardname': 'Harry Potter and the Sorcerer’s Stone',
          'cardpic': "assets/images/childrens/harrypoter.png",
          'price': 5,
        },
        {
          'cardname': 'Matilda',
          'cardpic': "assets/images/childrens/matilda.png",
          'price': 5,
        },
      ],
      //POETRY BOOKS
      'listPoetry': [
        {
          'cardname': 'The Road Not Taken',
          'cardpic': "assets/images/poetry/roadnottaken.png",
          'price': 5,
        },
        {
          'cardname': 'If—',
          'cardpic': "assets/images/poetry/if.png",
          'price': 5,
        },
        {
          'cardname': 'Ode to a Nightingale',
          'cardpic': "assets/images/poetry/odenightingale.png",
          'price': 5,
        },
        {
          'cardname': 'Daffodils',
          'cardpic': "assets/images/poetry/daffodils.png",
          'price': 5,
        },
        {
          'cardname': 'The Raven',
          'cardpic': "assets/images/poetry/raven.png",
          'price': 5,
        },
        {
          'cardname': 'Still I Rise',
          'cardpic': "assets/images/poetry/stillirise.png",
          'price': 5,
        },
      ],
    },
  ];

  static List listcart = [];
  static List listorder = [];
}
