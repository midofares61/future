import 'package:cloud_firestore/cloud_firestore.dart';

class CommissionDetailsModel{
  double? commission;
  String? dateTime;



  CommissionDetailsModel(
      {
        this.commission,
        this.dateTime,
      }
      );

  CommissionDetailsModel.fromJson(Map<String,dynamic>?json){
    commission=json?["commission"];
    dateTime=json?["dateTime"];
  }

  Map<String,dynamic> toMap(){
    return {
      "commission":commission,
      "dateTime":dateTime,
    };
  }
}