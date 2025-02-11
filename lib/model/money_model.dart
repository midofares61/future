class MoneyModel{
  String? id;
  String? name;
  String? money;
  String? notes;
  String? date;


  MoneyModel(
      {
        this.id,
        this.money,
        this.name,
        this.date,
        this.notes,
      }
      );

  MoneyModel.fromJson(Map<String,dynamic>?json){
    id=json?["id"];
    name=json?["name"];
    money=json?["money"];
    date=json?["date"];
    notes=json?["notes"];
  }

  Map<String,dynamic> toMap(){
    return {
      "id":id,
      "name":name,
      "money":money,
      "date":date,
      "notes":notes,
    };
  }
}