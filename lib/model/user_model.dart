class UserModel {
  String? name;
  String? password;
  String? type;
  String? notes;
  String? email;
  String? phone;
  String? uId;
  int? totalBalance;
  bool? addOrder;
  bool? editOrder;
  bool? removeOrder;
  bool? showMandobe;
  bool? addMandobe;
  bool? editMandobe;
  bool? removeMandobe;
  bool? showCode;
  bool? addCode;
  bool? editCode;
  bool? removeCode;
  bool? showStore;
  bool? addStore;
  bool? editStore;
  bool? changeStatus;
  bool? addComment;

  UserModel({
    this.uId,
    this.password,
    this.type,
    this.notes,
    this.name,
    this.email,
    this.addOrder,
    this.editOrder,
    this.removeOrder,
    this.showMandobe,
    this.addMandobe,
    this.editMandobe,
    this.removeMandobe,
    this.showCode,
    this.addCode,
    this.editCode,
    this.removeCode,
    this.showStore,
    this.addStore,
    this.editStore,
    this.changeStatus,
    this.addComment,
    this.phone,
    this.totalBalance,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json?["name"];
    password = json?["password"];
    uId = json?["uId"];
    type = json?["type"];
    notes = json?["notes"];
    email = json?["email"];
    addOrder = json?["addOrder"];
    editOrder = json?["editOrder"];
    removeOrder = json?["removeOrder"];
    showMandobe = json?["showMandobe"];
    addMandobe = json?["addMandobe"];
    editMandobe = json?["editMandobe"];
    removeMandobe = json?["removeMandobe"];
    showCode = json?["showCode"];
    addCode = json?["addCode"];
    editCode = json?["editCode"];
    removeCode = json?["removeCode"];
    showStore = json?["showStore"];
    addStore = json?["addStore"];
    editStore = json?["editStore"];
    changeStatus = json?["changeStatus"];
    addComment = json?["addComment"];
    phone = json?["phone"];
    totalBalance = json?["total_balance"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "password": password,
      "type": type,
      "notes": notes,
      "uId": uId,
      "email": email,
      "addOrder": addOrder,
      "editOrder": editOrder,
      "removeOrder": removeOrder,
      "showMandobe": showMandobe,
      "addMandobe": addMandobe,
      "editMandobe": editMandobe,
      "removeMandobe": removeMandobe,
      "showCode": showCode,
      "addCode": addCode,
      "editCode": editCode,
      "removeCode": removeCode,
      "showStore": showStore,
      "addStore": addStore,
      "editStore": editStore,
      "changeStatus": changeStatus,
      "addComment": addComment,
      "phone": phone,
      "total_balance": totalBalance,
    };
  }
}
