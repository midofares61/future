import 'package:cloud_firestore/cloud_firestore.dart';

import 'order_details_model.dart';

class CombinedModel {
  String? id;
  String? name;
  String? type;
  String? notes;
  Timestamp? dateTime; // استخدام DateTime لتوحيد النوع
  int? total;
  List<OrderDetailsModel>? details;
  int? credit;
  int? debit;

  CombinedModel({
    this.id,
    this.name,
    this.type,
    this.notes,
    this.dateTime,
    this.total,
    this.details,
    this.credit,
    this.debit,
  });
}
