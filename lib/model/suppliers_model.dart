import 'package:cloud_firestore/cloud_firestore.dart';

class SuppliersModel {
  String? id;
  String? name;
  Timestamp? dateTime;
  int? salary;
  int? code;



  SuppliersModel({
    this.id,
    this.name,
    this.salary,
    this.code,
    this.dateTime,
  });

  SuppliersModel.fromJson(Map<String, dynamic>?json){
    id = json?["id"];
    name = json?["name"];
    salary = json?["salary"];
    code = json?["code"];
    dateTime = json?["dateTime"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "salary": salary,
      "code": code,
      "dateTime": dateTime,
    };
  }
}
