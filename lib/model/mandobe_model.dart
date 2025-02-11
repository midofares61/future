class MandobeModel{
  String? id;
  String? name;
  String? phone;
  int? count;


  MandobeModel(
      {
        this.id,
        this.phone,
        this.name,
        this.count,
      }
      );

  MandobeModel.fromJson(Map<String,dynamic>?json){
    id=json?["id"];
    name=json?["name"];
    phone=json?["phone"];
    count=json?["count"];
  }

  Map<String,dynamic> toMap(){
    return {
      "id":id,
      "name":name,
      "phone":phone,
      "count":count,
    };
  }
}