class bookmodel {
  String? bookname;
  String? description;
  String? date;
  String? image;
  bookmodel(
      {required this.bookname, required this.description, required this.date,required this.image});
  Map<String, dynamic> todomap() {
    return {"bookname": bookname, "description": description, "date": date,"image":image};
  }
}
