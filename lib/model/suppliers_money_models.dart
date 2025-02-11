import 'package:cloud_firestore/cloud_firestore.dart';

class SuppliersModelMoney {
  String? id;
  String? name;
  int? credit ;
  int? debit ;
  String? type;
  String? notes;
  Timestamp? dateTime;



  SuppliersModelMoney({
    this.id,
    this.name,
    this.credit ,
    this.debit ,
    this.type ,
    this.notes ,
    this.dateTime ,
  });

  SuppliersModelMoney.fromJson(Map<String, dynamic>?json){
    id = json?["id"];
    name = json?["name"];
    credit  = json?["credit "];
    debit  = json?["debit "];
    type  = json?["type "];
    notes  = json?["notes "];
    dateTime  = json?["dateTime "];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "credit ": credit ,
      "debit ": debit ,
      "type ": type ,
      "notes ": notes ,
      "dateTime ": dateTime ,
    };
  }
}
