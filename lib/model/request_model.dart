
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  String? id;
  String? uId;
  String? name;
  int? amount;
  String? status;
  String? notes;
  String? image;
  String? phone;
  String? type;
  String? role;
  String? dateTime;
  Timestamp? createdAt;

  RequestModel({
    this.id,
    this.uId,
    this.name,
    this.amount,
    this.notes,
    this.image,
    this.type,
    this.role,
    this.phone,
    this.dateTime,
    this.createdAt,
  });

  RequestModel.fromJson(Map<String, dynamic>? json) {
    id = json?["id"] ?? "";
    uId = json?["uId"] ?? "";
    name = json?["name"] ?? "";
    amount = json?["amount"] ?? "";
    status = json?["status"] ?? "";
    notes = json?["notes"] ?? "";
    image = json?["image"] ?? "";
    type = json?["type"] ?? "";
    role = json?["role"] ?? "";
    phone = json?["phone"] ?? "";
    dateTime = json?["dateTime"] ?? "";
    createdAt = json?["createdAt"] ?? "";

  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uId": uId,
      "name": name,
      "amount": amount,
      "status": status,
      "notes": notes,
      "type": type,
      "image": image,
      "role": role,
      "phone": phone,
      "dateTime": dateTime,
      "createdAt": createdAt,
    };
  }
}
