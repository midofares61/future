import 'package:future/model/gift_model.dart';
import 'package:future/model/matress_model.dart';
import 'package:future/model/order_details_model.dart';

class OrderModel {
  String? id;
  String? orderCode;
  String? name;
  String? phone;
  String? phoneTow;
  String? address;
  String? city;
  String? dateTime;
  String? mandobeName;
  String? code;
  String? total;
  String? status;
  String? notes;
  bool? sells;
  bool? mandobe;
  List<OrderDetailsModel>? details;
  String? nameAdd;
  String? nameEdit;

  OrderModel({
    this.id,
    this.orderCode,
    this.phone,
    this.phoneTow,
    this.name,
    this.dateTime,
    this.address,
    this.city,
    this.mandobeName,
    this.code,
    this.total,
    this.status,
    this.notes,
    this.details,
    this.sells,
    this.mandobe,
    this.nameAdd,
    this.nameEdit,
  });

  OrderModel.fromJson(Map<String, dynamic>? json) {
    id = json?["id"]??"";
    orderCode = json?["orderCode"]??"";
    name = json?["name"]??"";
    phone = json?["phone"]??"";
    phoneTow = json?["phoneTow"]??"";
    address = json?["address"]??"";
    city = json?["city"]??"";
    dateTime = json?["dateTime"]??"";
    mandobeName = json?["mandobeName"]??"";
    code = json?["code"]??"";
    total = json?["total"]??"";
    status = json?["status"]??"";
    notes = json?["notes"];
    sells = json?["sells"];
    mandobe = json?["mandobe"];
    nameAdd = json?["nameAdd"]??"";
    nameEdit = json?["nameEdit"]??"";
    details = (json?["details"] as List<dynamic>?)
        ?.map((e) => OrderDetailsModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "orderCode": orderCode,
      "name": name,
      "phone": phone,
      "phoneTow": phoneTow,
      "dateTime": dateTime,
      "address": address,
      "city": city,
      "mandobeName": mandobeName,
      "code": code,
      "total": total,
      "status": status,
      "notes": notes,
      "mandobe": mandobe,
      "sells": sells,
      "nameAdd": nameAdd,
      "nameEdit": nameEdit,
      "details": details?.map((details) => details.toMap()).toList(),
    };
  }


  // Map<String, dynamic> toMap() {
  //   return {
  //     "id": id,
  //     "name": name,
  //     "phone": phone,
  //     "dateTime": dateTime,
  //     "address": address,
  //     "mandobeName": mandobeName,
  //     "code": code,
  //     "total": total,
  //     "details": details,
  //     "listMattress": mattress,
  //     "listGift": gift,
  //   };
  // }
}
