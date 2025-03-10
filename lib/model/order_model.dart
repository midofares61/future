import 'package:future/model/order_details_model.dart';

class OrderModel {
  String? id;
  String? orderCode;
  String? name;
  String? phone;
  String? phoneTow;
  String? address;
  String? city;
  int? priceCity;
  String? dateTime;
  String? mandobeName;
  String? uIdMandobeName;
  String? code;
  String? uIdCode;
  String? total;
  String? status;
  String? notes;
  bool? sells;
  bool? mandobe;
  List<OrderDetailsModel>? details;
  List<String>? uIdNames;
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
    this.uIdNames,
    this.uIdMandobeName,
    this.uIdCode,
    this.priceCity,
  });

  OrderModel.fromJson(Map<String, dynamic>? json) {
    id = json?["id"] ?? "";
    orderCode = json?["orderCode"] ?? "";
    name = json?["name"] ?? "";
    phone = json?["phone"] ?? "";
    phoneTow = json?["phoneTow"] ?? "";
    address = json?["address"] ?? "";
    city = json?["city"] ?? "";
    dateTime = json?["dateTime"] ?? "";
    mandobeName = json?["mandobeName"] ?? "";
    code = json?["code"] ?? "";
    total = json?["total"] ?? "";
    status = json?["status"] ?? "";
    notes = json?["notes"];
    sells = json?["sells"];
    mandobe = json?["mandobe"];
    nameAdd = json?["nameAdd"] ?? "";
    nameEdit = json?["nameEdit"] ?? "";
    uIdMandobeName = json?["uIdMandobeName"] ?? "";
    uIdCode = json?["uIdCode"] ?? "";
    priceCity = json?["priceCity"] ?? "";

    details = json?["details"] != null
        ? (json?["details"] as List<dynamic>)
        .map((e) => OrderDetailsModel.fromJson(e))
        .toList()
        : [];

    uIdNames = (json?["uIdNames"] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList() ?? [];
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
      "uIdCode": uIdCode,
      "uIdMandobeName": uIdMandobeName,
      "priceCity": priceCity,
      "details": details != null ? details!.map((e) => e.toMap()).toList() : [],
      "uIdNames": uIdNames != null ? uIdNames! : [],
    };
  }
}
