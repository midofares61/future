class MattressModel{
  String? id;
  String? name;
  String? size;
  String? height;
  int? count;


  MattressModel(
      {
        this.id,
        this.size,
        this.name,
        this.height,
        this.count,
      }
      );

  MattressModel.fromJson(Map<String,dynamic>?json){
    id=json?["id"];
    name=json?["name"];
    size=json?["size"];
    height=json?["height"];
    count=json?["count"];
  }

  Map<String,dynamic> toMap(){
    return {
      "id":id,
      "name":name,
      "size":size,
      "height":height,
      "count":count,
    };
  }
}



