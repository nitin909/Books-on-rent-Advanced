import 'package:scrren_cart/book_detail_page.dart';
import './appcolor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BooksPage extends StatefulWidget {
  final String branch;
  final String year;
  final String publication; // ✅ Added
  final Map mapBooks;

  const BooksPage({
    required this.branch,
    required this.year,
    required this.publication, // ✅ Added
    required this.mapBooks,
    super.key,
  });

  @override
  State<BooksPage> createState() {
    return _BooksPageState();
  }
}

class _BooksPageState extends State<BooksPage> {
  String? branch;
  String? year;
  String? publication; // ✅ Added
  Map? mapBooks;

  @override
  void initState() {
    super.initState();
    branch = widget.branch;
    year = widget.year;
    publication = widget.publication; // ✅ Added
    mapBooks = widget.mapBooks;
  }

  @override
  Widget build(BuildContext context) {
    print(branch);
    print(year);
    print(publication); // ✅ Added
    print(mapBooks);
    print(mapBooks!['books'].length);

    return Scaffold(
      backgroundColor: AppColor.color4,
      appBar: AppBar(
        title: Text(
          "Books Page",
          style: GoogleFonts.quicksand(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 5),
                child: Column(
                  children: [
                    Text(
                      branch!,
                      style: GoogleFonts.quicksand(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      year!,
                      style: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text( // ✅ Publication added in UI
                      publication!,
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: mapBooks!['books'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: const Color.fromARGB(255, 53, 52, 52)),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detailpage(
                                    index: index,
                                    listbook:
                                        mapBooks!['books'][index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 7),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(
                                                255, 99, 97, 97)
                                            .withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 15,
                                    offset: const Offset(4, 4),
                                  )
                                ],
                              ),
                              child: Stack(
                                alignment:
                                    AlignmentDirectional.topEnd,
                                children: [
                                  Image.asset(
                                    mapBooks!['books'][index]
                                        ['cardpic'],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(
                                  mapBooks!['books'][index]
                                      ['cardname'],
                                  style:
                                      GoogleFonts.quicksand(
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child:
                                      SingleChildScrollView(
                                    child: SizedBox(
                                      child: Text(
                                        mapBooks!['books'][index]
                                            ['description'],
                                        style: GoogleFonts
                                            .quicksand(
                                          fontSize: 15,
                                          fontWeight:
                                              FontWeight.w500,
                                        ),
                                      ),
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
