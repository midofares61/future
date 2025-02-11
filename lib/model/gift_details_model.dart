class GiftDetailsModel{
  int? count;
  String? dateTime;


  GiftDetailsModel(
      {
        this.count,
        this.dateTime,
      }
      );

  GiftDetailsModel.fromJson(Map<String,dynamic>?json){
    count=json?["count"];
    dateTime=json?["dateTime"];
  }

  Map<String,dynamic> toMap(){
    return {
      "count":count,
      "dateTime":dateTime,
    };
  }
}