class MoneysDetailsModel{
  String? money;
  String? date;
  String? notes;


  MoneysDetailsModel(
      {
        this.money,
        this.date,
        this.notes,
      }
      );

  MoneysDetailsModel.fromJson(Map<String,dynamic>?json){
    money=json?["money"];
    date=json?["date"];
    notes=json?["notes"];
  }

  Map<String,dynamic> toMap(){
    return {
      "money":money,
      "date":date,
      "notes":notes,
    };
  }
}