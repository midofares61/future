class MonthsModel{
  late String month;
  late String year;
  MonthsModel({
   required this.month,
    required this.year,
  });

  MonthsModel.fromJson(Map<String, dynamic>? json) {
    month = json?["month"]??"";
    year = json?["year"]??"";
  }
}