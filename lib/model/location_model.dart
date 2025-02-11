class ShippingPrice {
   String? id;
   String? governorate;
   int? price;

  ShippingPrice({
   required  this.governorate,
    required this.price,
    required  this.id,
});
  ShippingPrice.fromJson(Map<String,dynamic>?json){
    id=json?["id"];
    governorate=json?["governorate"];
    price=json?["price"];
  }

  Map<String,dynamic> toMap(){
    return {
      "id":id,
      "price":price,
      "governorate":governorate,
    };
  }
}