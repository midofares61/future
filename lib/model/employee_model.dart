class EmployeeModel {
  String? id;
  String? name;
  String? jop;
  int? code;



  EmployeeModel({
    this.id,
    this.jop,
    this.name,
    this.code,
  });

  EmployeeModel.fromJson(Map<String, dynamic>?json){
    id = json?["id"];
    name = json?["name"];
    jop = json?["jop"];
    code = json?["code"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "jop": jop,
      "code": code,
    };
  }
}


