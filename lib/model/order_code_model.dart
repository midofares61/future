class OrderCodeModel{
  String? id;
    int? orderCode;


  OrderCodeModel({
    this.id,
    this.orderCode,
  });

  OrderCodeModel.fromJson(Map<String, dynamic>?json){
    id = json?["id"];
    orderCode = json?["orderCode"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "orderCode": orderCode,
    };
  }

}