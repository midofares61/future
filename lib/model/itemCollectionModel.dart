class ItemCollectionModel{
  String? id;
  String? name;

  ItemCollectionModel({
    this.id,
    this.name,
});

  ItemCollectionModel.fromJson(Map<String,dynamic>?json){
    id=json?["id"];
    name=json?["name"];
  }
}