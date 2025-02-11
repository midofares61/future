class OrderDetailsModel {
  String? id;
  String? name;
  String? details;
  int? count;
  int? price;
  int? total;
  int? code;


  OrderDetailsModel({
    this.id,
    this.count,
    this.name,
    this.details,
    this.price,
    this.total,
    this.code,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic>?json){
    id = json?["id"];
    name = json?["name"];
    count = json?["count"];
    code = json?["code"];
    details = json?["details"];
    total = json?["total"];
    price = json?["price"];
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


