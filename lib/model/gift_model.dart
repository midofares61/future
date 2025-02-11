class GiftModel {
  String? id;
  String? name;
  String? notes;
  String? link;
  String? image;
  String? price;
  int? count;
  int? code;


  GiftModel({
    this.id,
    this.count,
    this.name,
    this.code,
    this.notes,
    this.link,
    this.image,
    this.price,
  });

  GiftModel.fromJson(Map<String, dynamic>?json){
    id = json?["id"];
    name = json?["name"];
    count = json?["count"];
    code = json?["code"];
    notes = json?["notes"];
    link = json?["link"];
    image = json?["image"];
    price = json?["price"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "count": count,
      "code": code,
      "notes": notes,
      "link": link,
      "image": image,
      "price": price,
    };
  }
}


