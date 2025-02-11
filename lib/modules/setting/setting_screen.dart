import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/modules/setting/add_user.dart';
import 'package:future/shared/widgets/text_widget.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/gift_model.dart';
import '../../model/mandobe_model.dart';
import '../../model/user_model.dart';
import '../../shared/componnents/componnents.dart';
import '../../shared/constant/constant.dart';
import '../../shared/widgets/alert_widget.dart';
import '../../shared/widgets/search_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var notesController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var formEditKey = GlobalKey<FormState>();

  bool addOrder = true;
  bool editOrder = true;
  bool removeOrder = true;
  bool showMandobe = true;
  bool addMandobe = false;
  bool editMandobe = false;
  bool removeMandobe = false;
  bool showCode = true;
  bool addCode = false;
  bool editCode = false;
  bool removeCode = false;
  bool showStore = true;
  bool addStore = false;
  bool editStore = false;
  bool changeStatus = false;
  bool addComment = false;

  String choose = "خدمة عملاء";
  String? codeValue;

  List<String> listChooseUser = [
    "ادمن",
    "خدمة عملاء",
    "مسوق الكتروني",
    "شركة شحن"
  ];
  List<String> listChooseUserUpdate = [
    "ادمن",
    "خدمة عملاء",
    "مسوق الكتروني",
    "شركة شحن"
  ];

  GiftModel? giftvalue;
  Widget buildCheckBoxAcceess({
    required String titel,
    required bool value,
    required Function(bool?) event,
  }) =>
      Row(
        children: [
          Checkbox(value: value, onChanged: event),
          const SizedBox(
            width: 10,
          ),
          Text(
            titel,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      );
  void changeCheckBox(String value) {
    if (value == "ادمن") {
      setState(() {
        addOrder = true;
        editOrder = true;
        removeOrder = true;
        showMandobe = true;
        addMandobe = true;
        editMandobe = true;
        removeMandobe = true;
        showCode = true;
        addCode = true;
        editCode = true;
        removeCode = true;
        showStore = true;
        addStore = true;
        editStore = true;
        changeStatus = true;
        addComment = true;
      });
    } else if (value == "خدمة عملاء") {
      setState(() {
        addOrder = true;
        editOrder = true;
        removeOrder = true;
        showMandobe = true;
        addMandobe = false;
        editMandobe = false;
        removeMandobe = false;
        showCode = true;
        addCode = false;
        editCode = false;
        removeCode = false;
        showStore = true;
        addStore = false;
        editStore = false;
        changeStatus = true;
        addComment = true;
      });
    } else if (value == "مسوق الكتروني") {
      setState(() {
        addOrder = true;
        editOrder = false;
        removeOrder = false;
        showMandobe = false;
        addMandobe = false;
        editMandobe = false;
        removeMandobe = false;
        showCode = false;
        addCode = false;
        editCode = false;
        removeCode = false;
        showStore = false;
        addStore = false;
        editStore = false;
        changeStatus = false;
        addComment = true;
      });
    } else {
      setState(() {
        addOrder = true;
        editOrder = false;
        removeOrder = false;
        showMandobe = false;
        addMandobe = false;
        editMandobe = false;
        removeMandobe = false;
        showCode = false;
        addCode = false;
        editCode = false;
        removeCode = false;
        showStore = false;
        addStore = false;
        editStore = false;
        changeStatus = true;
        addComment = true;
      });
    }
  }

  var searchController = TextEditingController();
  List<UserModel> searchOrder = [];
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getUsers();
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          double screenWidth = MediaQuery.of(context).size.width;
          return Scaffold(
            backgroundColor: Colors.white,
            body: ConditionalBuilder(
                condition: state is! OnLoadingCreateUserState ||
                    cubit.users.isNotEmpty,
                builder: (context) => Container(
                      color: const Color.fromRGBO(232, 243, 255, 1),
                      padding: const EdgeInsets.all(15),
                      child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey, width: 1))),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Color.fromRGBO(
                                                      155, 145, 255, 1),
                                                  width: 2))),
                                      child: const Text(
                                        "المستخدمين",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                155, 145, 255, 1)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: search(
                                          searchController: searchController,
                                          onChange: (search) {
                                            setState(() {
                                              searchOrder = [];
                                              searchOrder = cubit.users
                                                  .where((element) =>
                                                      element.name!.contains(
                                                          searchController
                                                              .text) ||
                                                      element.email!.contains(
                                                          searchController
                                                              .text))
                                                  .toList();
                                            });
                                          },
                                          hint: "ابحث بالاسم ورقم الهاتف ...."),
                                    ),
                                    if (screenWidth > 600)
                                      const SizedBox(
                                        width: 20,
                                      ),
                                    if (usermodel!.type=="ادمن")
                                        InkWell(
                                          onTap: () {
                                            navigateTo(context: context, widget: const AddUser());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "اضافة مستخدم",
                                                  style: TextStyle(
                                                      color: defaultColor,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey.shade200,
                                                      width: 1))),
                                          child: Row(
                                            children: [
                                              text("الاسم", 1, secondeColor,
                                                  TextAlign.start),
                                              text("النوع", 1, secondeColor,
                                                  TextAlign.start),
                                              text(
                                                  "اسم المستخدم",
                                                  1,
                                                  secondeColor,
                                                  TextAlign.start),
                                              text("اخري", 1, secondeColor,
                                                  TextAlign.center),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ConditionalBuilder(
                                            condition: cubit.users.isNotEmpty,
                                            builder:
                                                (context) => ConditionalBuilder(
                                                      condition:
                                                          searchController
                                                              .text.isNotEmpty,
                                                      builder: (context) =>
                                                          Expanded(
                                                              child: ListView
                                                                  .separated(
                                                                      itemBuilder:
                                                                          (context, index) =>
                                                                              Container(
                                                                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                                                                child: Row(
                                                                                  children: [
                                                                                    text("${searchOrder[index].name}", 1, secondeColor, TextAlign.start),
                                                                                    text("${searchOrder[index].type}", 1, secondeColor, TextAlign.start),
                                                                                    text("${searchOrder[index].email}", 1, secondeColor, TextAlign.start),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: IconButton(
                                                                                          onPressed: () {},
                                                                                          icon: const Icon(
                                                                                            Icons.delete_forever_rounded,
                                                                                            color: Colors.red,
                                                                                          )),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                      separatorBuilder:
                                                                          (context, index) =>
                                                                              const SizedBox(
                                                                                height: 0,
                                                                              ),
                                                                      itemCount:
                                                                          searchOrder
                                                                              .length)),
                                                      fallback: (context) =>
                                                          Expanded(
                                                              child: ListView
                                                                  .separated(
                                                                      itemBuilder:
                                                                          (context, index) =>
                                                                              Container(
                                                                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                                                                child: Row(
                                                                                  children: [
                                                                                    text("${cubit.users[index].name}", 1, secondeColor, TextAlign.start),
                                                                                    text("${cubit.users[index].type}", 1, secondeColor, TextAlign.start),
                                                                                    text("${cubit.users[index].email}", 1, secondeColor, TextAlign.start),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: IconButton(
                                                                                                onPressed: () {
                                                                                                  setState(() {
                                                                                                    nameController.text = cubit.users[index].name!;
                                                                                                    emailController.text = cubit.users[index].email!;
                                                                                                    phoneController.text = cubit.users[index].phone!;
                                                                                                    passwordController.text = cubit.users[index].password!;
                                                                                                    notesController.text = cubit.users[index].notes!;
                                                                                                    addOrder = cubit.users[index].addOrder!;
                                                                                                    editOrder = cubit.users[index].editOrder!;
                                                                                                    removeOrder = cubit.users[index].removeOrder!;
                                                                                                    showMandobe = cubit.users[index].showMandobe!;
                                                                                                    addMandobe = cubit.users[index].addMandobe!;
                                                                                                    editMandobe = cubit.users[index].editMandobe!;
                                                                                                    removeMandobe = cubit.users[index].removeMandobe!;
                                                                                                    showCode = cubit.users[index].showCode!;
                                                                                                    addCode = cubit.users[index].addCode!;
                                                                                                    editCode = cubit.users[index].editCode!;
                                                                                                    removeCode = cubit.users[index].removeCode!;
                                                                                                    showStore = cubit.users[index].showStore!;
                                                                                                    addStore = cubit.users[index].addStore!;
                                                                                                    editStore = cubit.users[index].editStore!;
                                                                                                    choose = cubit.users[index].type!;
                                                                                                    changeStatus=cubit.users[index].changeStatus!;
                                                                                                    addComment=cubit.users[index].addComment!;
                                                                                                    codeValue=cubit.users[index].name!;
                                                                                                  });
                                                                                                  showDialog(
                                                                                                      context: context,
                                                                                                      builder: (context) => alert(
                                                                                                          cubit: cubit,
                                                                                                          context: context,
                                                                                                          formKey: formKey,
                                                                                                          onTap: () {
                                                                                                            if (formKey.currentState!.validate()) {
                                                                                                              cubit.userUpdate(
                                                                                                                  name: codeValue!,
                                                                                                                  id: cubit.users[index].uId!,
                                                                                                                  notes: notesController.text,
                                                                                                                  email: emailController.text,
                                                                                                                  phone: phoneController.text,
                                                                                                                  password: passwordController.text,
                                                                                                                  type: choose,
                                                                                                                  addOrder: addOrder,
                                                                                                                  editOrder: editOrder,
                                                                                                                  removeOrder: removeOrder,
                                                                                                                  showCode: showCode,
                                                                                                                  addCode: addCode,
                                                                                                                  editCode: editCode,
                                                                                                                  removeCode: removeCode,
                                                                                                                  showMandobe: showMandobe,
                                                                                                                  addMandobe: addMandobe,
                                                                                                                  editMandobe: editMandobe,
                                                                                                                  removeMandobe: removeMandobe,
                                                                                                                  showStore: showStore,
                                                                                                                  addStore: addStore,
                                                                                                                  editStore: editStore,
                                                                                                                  changeStatus: changeStatus,
                                                                                                                  addComment: addComment,
                                                                                                              );
                                                                                                              nameController.text = "";
                                                                                                              emailController.text = "";
                                                                                                              passwordController.text = "";
                                                                                                            }
                                                                                                          },
                                                                                                          btn: "تعديل مستخدم",
                                                                                                          content: Padding(
                                                                                                            padding: const EdgeInsets.all(10.0),
                                                                                                            child: Directionality(
                                                                                                              textDirection: TextDirection.rtl,
                                                                                                              child: SingleChildScrollView(
                                                                                                                child: Container(
                                                                                                                  width: 500,
                                                                                                                  child: Column(
                                                                                                                    children: [
                                                                                                                      Row(
                                                                                                                        children: [
                                                                                                                          //  if (cubit.users[index].type != "مسوق الكتروني") const Text("تعديل نوع المستخدم", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                                                                                                          //   const SizedBox(
                                                                                                                          //     width: 15,
                                                                                                                          //   ),
                                                                                                                          Expanded(
                                                                                                                            child: Container(
                                                                                                                              width: double.infinity,
                                                                                                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                                                                              decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(75)),
                                                                                                                              child: DropdownButton<String>(
                                                                                                                                hint: const Text("اختار نوع الاضاقة"),
                                                                                                                                isExpanded: true,
                                                                                                                                underline: Container(),
                                                                                                                                value: choose,
                                                                                                                                style: TextStyle(color: defaultColor, fontSize: 18),
                                                                                                                                onChanged: (String? value) {
                                                                                                                                  // This is called when the user selects an item.
                                                                                                                                  setState(() {
                                                                                                                                    choose = value!;
                                                                                                                                    changeCheckBox(value);
                                                                                                                                  });
                                                                                                                                },
                                                                                                                                items: listChooseUserUpdate.map<DropdownMenuItem<String>>((String model) {
                                                                                                                                  return DropdownMenuItem<String>(
                                                                                                                                    value: model,
                                                                                                                                    child: Text(model),
                                                                                                                                  );
                                                                                                                                }).toList(),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                      const SizedBox(
                                                                                                                        height: 15,
                                                                                                                      ),
                                                                                                                      choose == "ادمن" || choose == "خدمة عملاء"
                                                                                                                          ? Form(
                                                                                                                              key: formKey,
                                                                                                                              child: Column(
                                                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                spacing: 15,
                                                                                                                                children: [
                                                                                                                                  TextFormField(
                                                                                                                                    controller: nameController,
                                                                                                                                    validator: (value) {
                                                                                                                                      if (value!.isEmpty) {
                                                                                                                                        return "يجب ادخال اسم المستخدم لاكمال العمليه";
                                                                                                                                      }
                                                                                                                                      return null;
                                                                                                                                    },
                                                                                                                                    decoration: const InputDecoration(
                                                                                                                                        border: OutlineInputBorder(),
                                                                                                                                        label: Text("اسم المستخدم"),
                                                                                                                                        hintText: "اسم المستخدم"
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                  TextFormField(
                                                                                                                                    controller: emailController,
                                                                                                                                      readOnly:true,
                                                                                                                                    validator: (value) {
                                                                                                                                      if (value!.isEmpty) {
                                                                                                                                        return "يجب ادخال الايميل لاكمال العمليه";
                                                                                                                                      }
                                                                                                                                      return null;
                                                                                                                                    },
                                                                                                                                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "الايميل",label: Text("الايميل"),),
                                                                                                                                  ), TextFormField(
                                                                                                                                    controller: phoneController,
                                                                                                                                    validator: (value) {
                                                                                                                                      if (value!.isEmpty) {
                                                                                                                                        return "يجب ادخال رقم الهاتف لاكمال العمليه";
                                                                                                                                      }
                                                                                                                                      return null;
                                                                                                                                    },
                                                                                                                                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "رقم الهاتف",label: Text("رقم الهاتف")),
                                                                                                                                  ),TextFormField(
                                                                                                                                    controller: notesController,
                                                                                                                                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "ملاحظة",label: Text("ملاحظة")),
                                                                                                                                  ),
                                                                                                                                  TextFormField(
                                                                                                                                    readOnly:true,
                                                                                                                                    controller: passwordController,
                                                                                                                                    validator: (value) {
                                                                                                                                      if (value!.isEmpty) {
                                                                                                                                        return "يجب ادخال الباسورد لاكمال العمليه";
                                                                                                                                      }
                                                                                                                                      return null;
                                                                                                                                    },
                                                                                                                                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "الباسورد",label: Text("الباسورد")),
                                                                                                                                  ),
                                                                                                                                  const Row(
                                                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                    children: [
                                                                                                                                      Text(
                                                                                                                                        "صلاحيات المستخدم",
                                                                                                                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                                                                                      ),
                                                                                                                                    ],
                                                                                                                                  ),
                                                                                                                                  Column(
                                                                                                                                    spacing: 15,
                                                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                    children: [
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'اضافة فاتورة',
                                                                                                                                          value: addOrder,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              addOrder = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'تعديل فاتورة',
                                                                                                                                          value: editOrder,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              editOrder = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'حذف فاتورة',
                                                                                                                                          value: removeOrder,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              removeOrder = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'عرض المناديب',
                                                                                                                                          value: showMandobe,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              showMandobe = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'اضافة مندوب',
                                                                                                                                          value: addMandobe,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              addMandobe = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'تعديل مندوب',
                                                                                                                                          value: editMandobe,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              editMandobe = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'حذف مندوب',
                                                                                                                                          value: removeMandobe,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              removeMandobe = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'عرض المسوقين',
                                                                                                                                          value: showCode,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              showCode = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'اضافة مسوق',
                                                                                                                                          value: addCode,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              addCode = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'تعديل مسوق',
                                                                                                                                          value: editCode,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              editCode = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'حذف مسوق',
                                                                                                                                          value: removeCode,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              removeCode = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'عرض المخزن',
                                                                                                                                          value: showStore,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              showStore = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'اضافة للمخزن',
                                                                                                                                          value: addStore,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              addStore = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'تعديل المخزن',
                                                                                                                                          value: editStore,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              editStore = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel:
                                                                                                                                          'تعديل الحالة',
                                                                                                                                          value:
                                                                                                                                          changeStatus,
                                                                                                                                          event:
                                                                                                                                              (value) {
                                                                                                                                            setState(
                                                                                                                                                    () {
                                                                                                                                                  changeStatus =
                                                                                                                                                  value!;
                                                                                                                                                });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel:
                                                                                                                                          'اضافة كومنت',
                                                                                                                                          value:
                                                                                                                                          addComment,
                                                                                                                                          event:
                                                                                                                                              (value) {
                                                                                                                                            setState(
                                                                                                                                                    () {
                                                                                                                                                  addComment =
                                                                                                                                                  value!;
                                                                                                                                                });
                                                                                                                                          }),
                                                                                                                                    ],
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                            )
                                                                                                                          : Form(
                                                                                                                              key: formKey,
                                                                                                                              child: Column(
                                                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                spacing: 15,
                                                                                                                                children: [
                                                                                                                                  // Container(
                                                                                                                                  //   width: double.infinity,
                                                                                                                                  //   decoration: BoxDecoration(
                                                                                                                                  //     border: Border.all(width: 1, color: Colors.grey),
                                                                                                                                  //     borderRadius: BorderRadius.circular(5),
                                                                                                                                  //   ),
                                                                                                                                  //   child: DropdownButton<String>(
                                                                                                                                  //     padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                                                                  //     hint: const Text("اختار المسوق"),
                                                                                                                                  //     isExpanded: true,
                                                                                                                                  //     underline: Container(),
                                                                                                                                  //     value: codeValue,
                                                                                                                                  //     style: TextStyle(color: defaultColor, fontSize: 18),
                                                                                                                                  //     onChanged: (String? value) {
                                                                                                                                  //       setState(() {
                                                                                                                                  //         codeValue = value;
                                                                                                                                  //       });
                                                                                                                                  //     },
                                                                                                                                  //     items: cubit.code!.map<DropdownMenuItem<String>>((UserModel model) {
                                                                                                                                  //       return DropdownMenuItem<String>(
                                                                                                                                  //         value: model.name!,
                                                                                                                                  //         child: Text(model.name!),
                                                                                                                                  //       );
                                                                                                                                  //     }).toList(),
                                                                                                                                  //   ),
                                                                                                                                  // ),
                                                                                                                                  TextFormField(
                                                                                                                                    controller: nameController,
                                                                                                                                    validator: (value) {
                                                                                                                                      if (value!.isEmpty) {
                                                                                                                                        return "يجب ادخال اسم المستخدم لاكمال العمليه";
                                                                                                                                      }
                                                                                                                                      return null;
                                                                                                                                    },
                                                                                                                                    decoration: const InputDecoration(
                                                                                                                                        border: OutlineInputBorder(),
                                                                                                                                        label: Text("اسم المستخدم"),
                                                                                                                                        hintText: "اسم المستخدم"
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                  TextFormField(
                                                                                                                                    readOnly:true,
                                                                                                                                    controller: emailController,
                                                                                                                                    validator: (value) {
                                                                                                                                      if (value!.isEmpty) {
                                                                                                                                        return "يجب ادخال الايميل لاكمال العمليه";
                                                                                                                                      }
                                                                                                                                      return null;
                                                                                                                                    },
                                                                                                                                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "الايميل",label: Text("الايميل")),
                                                                                                                                  ), TextFormField(
                                                                                                                                    controller: phoneController,
                                                                                                                                    validator: (value) {
                                                                                                                                      if (value!.isEmpty) {
                                                                                                                                        return "يجب ادخال رقم الهاتف لاكمال العمليه";
                                                                                                                                      }
                                                                                                                                      return null;
                                                                                                                                    },
                                                                                                                                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "رقم الهاتف",label: Text("رقم الهاتف")),
                                                                                                                                  ),
                                                                                                                                  TextFormField(
                                                                                                                                    controller: notesController,
                                                                                                                                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "ملاحظة",label: Text("ملاحظة")),
                                                                                                                                  ),
                                                                                                                                  TextFormField(
                                                                                                                                    readOnly:true,
                                                                                                                                    controller: passwordController,
                                                                                                                                    validator: (value) {
                                                                                                                                      if (value!.isEmpty) {
                                                                                                                                        return "يجب ادخال الباسورد لاكمال العمليه";
                                                                                                                                      }
                                                                                                                                      return null;
                                                                                                                                    },
                                                                                                                                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "الباسورد",label: Text("الباسورد")),
                                                                                                                                  ),
                                                                                                                                  const Row(
                                                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                    children: [
                                                                                                                                      Text(
                                                                                                                                        "صلاحيات المستخدم",
                                                                                                                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                                                                                      ),
                                                                                                                                    ],
                                                                                                                                  ),
                                                                                                                                  Column(
                                                                                                                                    spacing: 15,
                                                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                    children: [
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'اضافة فاتورة',
                                                                                                                                          value: addOrder,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              addOrder = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'تعديل فاتورة',
                                                                                                                                          value: editOrder,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              editOrder = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'حذف فاتورة',
                                                                                                                                          value: removeOrder,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              removeOrder = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'عرض المناديب',
                                                                                                                                          value: showMandobe,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              showMandobe = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'اضافة مندوب',
                                                                                                                                          value: addMandobe,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              addMandobe = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'تعديل مندوب',
                                                                                                                                          value: editMandobe,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              editMandobe = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'حذف مندوب',
                                                                                                                                          value: removeMandobe,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              removeMandobe = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'عرض المسوقين',
                                                                                                                                          value: showCode,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              showCode = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'اضافة مسوق',
                                                                                                                                          value: addCode,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              addCode = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'تعديل مسوق',
                                                                                                                                          value: editCode,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              editCode = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'حذف مسوق',
                                                                                                                                          value: removeCode,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              removeCode = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'عرض المخزن',
                                                                                                                                          value: showStore,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              showStore = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'اضافة للمخزن',
                                                                                                                                          value: addStore,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              addStore = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel: 'تعديل المخزن',
                                                                                                                                          value: editStore,
                                                                                                                                          event: (value) {
                                                                                                                                            setState(() {
                                                                                                                                              editStore = value!;
                                                                                                                                            });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel:
                                                                                                                                          'تعديل الحالة',
                                                                                                                                          value:
                                                                                                                                          changeStatus,
                                                                                                                                          event:
                                                                                                                                              (value) {
                                                                                                                                            setState(
                                                                                                                                                    () {
                                                                                                                                                  changeStatus =
                                                                                                                                                  value!;
                                                                                                                                                });
                                                                                                                                          }),
                                                                                                                                      buildCheckBoxAcceess(
                                                                                                                                          titel:
                                                                                                                                          'اضافة كومنت',
                                                                                                                                          value:
                                                                                                                                          addComment,
                                                                                                                                          event:
                                                                                                                                              (value) {
                                                                                                                                            setState(
                                                                                                                                                    () {
                                                                                                                                                  addComment =
                                                                                                                                                  value!;
                                                                                                                                                });
                                                                                                                                          }),
                                                                                                                                    ],
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          )));
                                                                                                },
                                                                                                icon: const Icon(
                                                                                                  Icons.edit_outlined,
                                                                                                  color: Colors.grey,
                                                                                                )),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: IconButton(
                                                                                                onPressed: () {
                                                                                                  dialog(context, onTap: () {
                                                                                                    cubit.deleteUser(uid: cubit.users[index].uId!, email: cubit.users[index].email!, password: "123456");
                                                                                                    Navigator.pop(context);
                                                                                                  }, onCancelTap: () {
                                                                                                    Navigator.pop(context);
                                                                                                  }, icon: Icons.delete_forever_rounded, onPressedTitle: "نعم", subTitle: "هل تريد حذف هذا المستخدم", bigTitle: "", iconColor: Colors.red);
                                                                                                },
                                                                                                icon: const Icon(
                                                                                                  Icons.delete_forever_rounded,
                                                                                                  color: Colors.red,
                                                                                                )),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                      separatorBuilder:
                                                                          (context, index) =>
                                                                              const SizedBox(
                                                                                height: 0,
                                                                              ),
                                                                      itemCount: cubit
                                                                          .users
                                                                          .length)),
                                                    ),
                                            fallback: (context) =>
                                                const Expanded(
                                                    child: Center(
                                                  child: Text(
                                                    "لا يوجد اي مستخدمين",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ))),
                                      ],
                                    )),
                              )
                            ],
                          )),
                    ),
                fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    )),
          );
        });
  }
}
