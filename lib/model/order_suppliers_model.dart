import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:future/model/order_details_model.dart';

class OrderSuppliersModel {
  String? id;
  String? name;
  Timestamp? dateTime;
  int? credit;
  String? notes;
  String? type;
  List<OrderDetailsModel>? details;

  OrderSuppliersModel({
    this.id,
    this.name,
    this.dateTime,
    this.credit,
    this.notes,
    this.type,
    this.details,
  });

  OrderSuppliersModel.fromJson(Map<String, dynamic>? json) {
    id = json?["id"];
    name = json?["name"];
    dateTime = json?["dateTime"];
    credit = json?["credit"];
    notes = json?["notes"];
    type = json?["type"];
    details = (json?["details"] as List<dynamic>?)
        ?.map((e) => OrderDetailsModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "dateTime": dateTime,
      "credit": credit,
      "notes": notes,
      "type": type,
      "details": details?.map((details) => details.toMap()).toList(),
    };
  }

}
