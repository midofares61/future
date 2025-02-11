import 'package:future/model/gift_model.dart';
import 'package:future/model/matress_model.dart';

class AllOrderModel {
  String? id;
  String? name;
  String? phone;
  String? address;
  String? dateTime;
  String? mandobeName;
  String? code;
  String? total;
  String? details;
  List<MattressModel>? mattress;
  List<GiftModel>? gift;


  AllOrderModel.fromJson(Map<String, dynamic>? json) {
    id = json?["id"];
    name = json?["name"];
    phone = json?["phone"];
    address = json?["address"];
    dateTime = json?["dateTime"];
    mandobeName = json?["mandobeName"];
    code = json?["code"];
    total = json?["total"];
    details = json?["details"];
    mattress = (json?["mattress"] as List<dynamic>?)
        ?.map((e) => MattressModel.fromJson(e))
        .toList();
    gift = (json?["listGift"] as List<dynamic>?)
        ?.map((e) => GiftModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "dateTime": dateTime,
      "address": address,
      "mandobeName": mandobeName,
      "code": code,
      "total": total,
      "details": details,
      "listMattress": mattress?.map((mattress) => mattress.toMap()).toList(),
      "listGift": gift?.map((gift) => gift.toMap()).toList(),
    };
  }

}
