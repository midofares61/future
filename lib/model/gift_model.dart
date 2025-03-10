class GiftModel {
  String? id;
  String? name;
  String? notes;
  String? link;
  String? image;
  String? price;
  String? price2;
  String? uid;
  String? edit;
  String? nameAdd;
  int? count;
  int? code;


  GiftModel({
    this.id,
    this.count,
    this.name,
    this.code,
    this.notes,
    this.image,
    this.price,
    this.price2,
    this.link,
    this.uid,
    this.edit,
    this.nameAdd,
  });

  GiftModel.fromJson(Map<String, dynamic>?json){
    id = json?["id"];
    name = json?["name"];
    count = json?["count"];
    code = json?["code"];
    notes = json?["notes"];
    image = json?["image"];
    price = json?["price"];
    price2 = json?["price2"]??"0";
    link = json?["link"];
    uid = json?["uid"];
    edit = json?["edit"];
    nameAdd = json?["nameAdd"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "count": count,
      "code": code,
      "notes": notes,
      "image": image,
      "price": price,
      "price2": price2,
      "link": link,
      "uid": uid,
      "edit": edit,
      "nameAdd": nameAdd,
    };
  }
}


