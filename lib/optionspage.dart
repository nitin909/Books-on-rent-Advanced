import './appcolor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bookspage.dart';

class OptionsPage extends StatefulWidget {
  final List optlist;
  final int optindex;
  const OptionsPage({required this.optlist, required this.optindex, super.key});
  @override
  State<OptionsPage> createState() {
    return _OptionsPage();
  }
}

// List<String> dropdownList1 = [
//   'Computer',
//   'IT',
//   'E&TC',
//   'Civil',
//   'AIML',
//   'Printing'
// ];
// String? dropdownValue1;
// List<String> dropdownList2 = [
//   'First Year',
//   'Second Year',
//   'Third Year',
//   'Fourth Year'
// ];
// String? dropdownValue2;
class _OptionsPage extends State<OptionsPage> {
  List<String>? dropdownList1;
  List<String>? dropdownList2;
  List<String>? dropdownList3;
  String? dropdownValue1;
  String? dropdownValue2;
  String? dropdownValue3;
  @override
  void initState() {
    super.initState();
    int optindex = widget.optindex;
    // OPTLIST = AppdataModal.listEducation
    dropdownList1 = widget.optlist[optindex]['branches'];
    dropdownList2 = widget.optlist[optindex]['years'];
    dropdownList3 = widget.optlist[optindex]['publications'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Image.asset('assets/bcimage.jpg').color,
      appBar: AppBar(
        title: Text(
          "Section Page",
          style: GoogleFonts.quicksand(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.color4,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bcimage.png'),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // DropDown Button 1
              Container(
                width: (MediaQuery.of(context).size.width * 4) / 5,
                decoration: BoxDecoration(
                    color: AppColor.color4,
                    border: Border.all(
                      width: 3.0,
                      color: const Color.fromARGB(255, 112, 110, 110),
                    )),
                child: DropdownButton<String>(
                  hint: const Text(" Select Branch"),
                  isExpanded: true,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: AppColor.color4,
                  ),
                  value: dropdownValue1,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue1 = value!;
                    });
                  },
                  items: dropdownList1!.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
              //drop3
               Container(
                width: (MediaQuery.of(context).size.width * 4) / 5,
                decoration: BoxDecoration(
                    color: AppColor.color4,
                    border: Border.all(
                      width: 3.0,
                      color: const Color.fromARGB(255, 112, 110, 110),
                    )),
                child: DropdownButton<String>(
                  hint: const Text(" Select Publication"),
                  isExpanded: true,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: AppColor.color4,
                  ),
                  value: dropdownValue3,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue3 = value!;
                    });
                  },
                  items: dropdownList3!.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                // DropDown Button 2
                width: (MediaQuery.of(context).size.width * 4) / 5,
                decoration: BoxDecoration(
                    color: AppColor.color4,
                    border: Border.all(
                      width: 3.0,
                      color: const Color.fromARGB(255, 112, 110, 110),
                    )),
                child: DropdownButton<String>(
                  hint: const Text(" Select Year"),
                  isExpanded: true,
                  elevation: 17,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: AppColor.color4,
                  ),
                  value: dropdownValue2,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue2 = value!;
                    });
                  },
                  items: dropdownList2!.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColor.color1),
                  fixedSize: WidgetStatePropertyAll(
                      Size.fromWidth(MediaQuery.of(context).size.width * 2) /
                          5),
                ),
                onPressed: () async {
                  // print(dropdownValue1);
                  // print(dropdownValue2!);
                  // print(widget.optlist[widget.optindex]);
                  (dropdownValue1 != null) && (dropdownValue2 != null) && (dropdownValue3 != null)
                      ? {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BooksPage(
                                    branch: dropdownValue1!,
                                    year: dropdownValue2!,
                                    publication:dropdownValue3!,
                                    //  optlist[widget.optindex] = listEducation[index] this is the our selected field/card data
                                    mapBooks: widget.optlist[widget.optindex])),
                          ),
                          // Used setState for the after click on back icon of BooksPage
                          // Options are not selected
                          setState(() {
                            // dropdownValue1 = null;
                            // dropdownValue2 = null;
                          }),
                        }
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Select Branch and Year first and Publication",
                              style: GoogleFonts.quicksand(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: AppColor.color2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
