class OrderDetailsModel {
  String? id;
  String? name;
  String? details;
  int? count;
  int? price;
  int? oldPrice;
  int? tagerPrice;
  int? total;
  int? code;
  String? uid;
  String? edit;
  String? nameAdd;
  String? link;


  OrderDetailsModel({
    this.id,
    this.count,
    this.name,
    this.details,
    this.price,
    this.total,
    this.code,
    this.link,
    this.uid,
    this.edit,
    this.nameAdd,
    this.oldPrice,
    this.tagerPrice,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic>?json){
    id = json?["id"];
    name = json?["name"];
    count = json?["count"];
    code = json?["code"];
    details = json?["details"];
    total = json?["total"];
    price = json?["price"];
    link = json?["link"];
    uid = json?["uid"];
    edit = json?["edit"];
    nameAdd = json?["nameAdd"];
    oldPrice = json?["oldPrice"];
    tagerPrice = json?["tagerPrice"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "count": count,
      "code": code,
      "price": price,
      "total": total,
      "details": details,
      "link": link,
      "uid": uid,
      "edit": edit,
      "nameAdd": nameAdd,
      "oldPrice": oldPrice,
      "tagerPrice": tagerPrice,
    };
  }

  // تجاوز عملية المقارنة لمقارنة المنتجات بناءً على الاسم أو الكود
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is OrderDetailsModel &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              code == other.code;

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}


