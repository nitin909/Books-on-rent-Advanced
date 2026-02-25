





// Padding(
//         padding: const EdgeInsets.only(left: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               // Row of Profile Pic And Name
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(top: 8, left: 0),
//                   margin: const EdgeInsets.only(top: 50),
//                   width: 70,
//                   height: 70,
//                   clipBehavior: Clip.hardEdge,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColor.color4,
//                   ),
//                   child: Image.asset(
//                     "assets/images/profile.png",
//                   ), // Profile pic Image
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 35, left: 20),
//                   child: Text(
//                     "Hi, Name!", // Hi Name text
//                     style: GoogleFonts.quicksand(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w800,
//                         shadows: [
//                           const Shadow(
//                             offset: Offset(0, 4),
//                             blurRadius: 2.0,
//                             color: Color.fromRGBO(0, 0, 0, 0.25),
//                           ),
//                         ]),
//                   ),
//                 ),
//               ],
//             ),
//             // Slogan Text
//             Container(
//               width: (MediaQuery.of(context).size.width) * 3 / 4,
//               margin: const EdgeInsets.only(top: 10),
//               child: Text(
//                 "Discover the perfect book for every need!",
//                 style: GoogleFonts.quicksand(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             // Search Box On Home Page
//             Padding(
//               padding: const EdgeInsets.only(top: 10, right: 20),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: "Search",
//                   filled: true,
//                   hoverColor: AppColor.color4,
//                   border: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   ),
//                   prefixIcon: const Icon(Icons.search_outlined),
//                   fillColor: AppColor.color4,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       //EDUCATION AND ACADEMICS
//                       Text(
//                         "Educational & Academic >",
//                         style: GoogleFonts.quicksand(
//                             fontSize: 24,
//                             fontWeight: FontWeight.w800,
//                             color: AppColor.color1),
//                       ),
//                       SizedBox(
//                         height: 235,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.horizontal,
//                           itemCount: AppdataModal.listEducation.length,
//                           itemBuilder: (context, index) {
//                             return sectionCards(
//                                 card1Name: AppdataModal.listEducation[index]
//                                     ['cardname'],
//                                 card1Pic: AppdataModal.listEducation[index]
//                                     ['cardpic'],
//                                 index: index,
//                                 listdata: AppdataModal.listEducation);
//                           },
//                         ),
//                       ),

//                       // BUSINESS &  FINANCE
//                       Text(
//                         "Business & Finance >",
//                         style: GoogleFonts.quicksand(
//                             fontSize: 24,
//                             fontWeight: FontWeight.w800,
//                             color: AppColor.color5),
//                       ),
//                       SizedBox(
//                         height: 235,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.horizontal,
//                           itemCount: AppdataModal
//                               .listBookSections[0]['listBusiness'].length,
//                           itemBuilder: (context, index) {
//                             return sectionCards(
//                                 card1Name: AppdataModal.listBookSections[0]
//                                     ['listBusiness'][index]['cardname'],
//                                 card1Pic: AppdataModal.listBookSections[0]
//                                     ['listBusiness'][index]['cardpic'],
//                                 index: index,
//                                 listdata: AppdataModal.listBookSections[0]
//                                     ['listBusiness']);
//                           },
//                         ),
//                       ),

//                       // CHILDRENS BOOKS
//                       Text(
//                         "Children's Books >",
//                         style: GoogleFonts.quicksand(
//                             fontSize: 24,
//                             fontWeight: FontWeight.w800,
//                             color: AppColor.color6),
//                       ),
//                       SizedBox(
//                         height: 235,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.horizontal,
//                           itemCount: AppdataModal
//                               .listBookSections[0]['listChildrens'].length,
//                           itemBuilder: (context, index) {
//                             return sectionCards(
//                                 card1Name: AppdataModal.listBookSections[0]
//                                     ['listChildrens'][index]['cardname'],
//                                 card1Pic: AppdataModal.listBookSections[0]
//                                     ['listChildrens'][index]['cardpic'],
//                                 index: index,
//                                 listdata: AppdataModal.listBookSections[0]
//                                     ['listChildrens']);
//                           },
//                         ),
//                       ),

//                       // POETRY
//                       Text(
//                         "Poetry >",
//                         style: GoogleFonts.quicksand(
//                             fontSize: 24,
//                             fontWeight: FontWeight.w800,
//                             color: AppColor.color6),
//                       ),
//                       SizedBox(
//                         height: 235,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.horizontal,
//                           itemCount: AppdataModal
//                               .listBookSections[0]['listPoetry'].length,
//                           itemBuilder: (context, index) {
//                             return sectionCards(
//                                 card1Name: AppdataModal.listBookSections[0]
//                                     ['listPoetry'][index]['cardname'],
//                                 card1Pic: AppdataModal.listBookSections[0]
//                                     ['listPoetry'][index]['cardpic'],
//                                 index: index,
//                                 listdata: AppdataModal.listBookSections[0]
//                                     ['listPoetry']);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )