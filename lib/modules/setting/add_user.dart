import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/gift_model.dart';
import '../../model/mandobe_model.dart';
import '../../shared/constant/constant.dart';
class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
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
  bool changeStatus = false;
  bool addComment = false;
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


  String choose = "خدمة عملاء";
  String? codeValue;


  List<String> listChooseUser = ["ادمن", "خدمة عملاء", "مسوق الكتروني","شركة شحن", "تاجر",];
  List<String> listChooseUserUpdate = ["ادمن", "خدمة عملاء"];

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
        showStore = true;
        addStore = true;
        editStore = true;
        changeStatus = true;
        addComment = true;
      });
    } else if (value == "مسوق الكتروني"){
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
    }else if(value=="تاجر"){
      setState(() {
        addOrder = false;
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
        showStore = true;
        addStore = true;
        editStore = true;
        changeStatus = false;
        addComment = false;
      });
    }else {
    setState(() {
    addOrder = false;
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {
          if (state is SocialUserCreateSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "تم اضافة المستخدم بنجاح",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 1000),
            ));
            setState(() {
              nameController
                  .text = "";
              notesController
                  .text = "";
              phoneController.text = "";
              emailController
                  .text = "";
              passwordController
                  .text = "";
            });
            Navigator.pop(context);

          }
          if (state is SocialRegisterErrorState) {
            if(state.error=="[firebase_auth/email-already-in-use] The email address is already in use by another account."){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "هذا المستخدم موجود من قبل قم بتغيير اسم المستخدم",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                duration: Duration(milliseconds: 1500),
              ));
              setState(() {
                emailController
                    .text = "";
              });
            }else  if(state.error=="[firebase_auth/network-request-failed] A network AuthError (such as timeout, interrupted connection or unreachable host) has occurred."){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "تحقق من الاتصال بالانترنت ثم اعد المحاولة",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                duration: Duration(milliseconds: 1500),
              ));
            }

          }
        },
    builder: (context, state) {
    AppCubit cubit = AppCubit.get(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("اضافة مستخدم"),
      ),
      body: ConditionalBuilder(
          condition: state is SocialRegisterOnLoadingState || state is OnLoadingCreateUserState,
          builder: (context)=>Center(child: CircularProgressIndicator(),),
          fallback: (context)=>Center(
          child: Container(
          width: 600,
          child:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text("اختار صلاحية المستخدم",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.w600)),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets
                                  .symmetric(
                                  horizontal: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey),
                                  borderRadius:
                                  BorderRadius.circular(
                                      5)),
                              child: DropdownButton<String>(
                                hint: const Text(
                                    "اختار نوع الاضاقة"),
                                isExpanded: true,
                                underline: Container(),
                                value: choose,
                                style: TextStyle(
                                    color: defaultColor,
                                    fontSize: 18),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    choose = value!;
                                    changeCheckBox(value);
                                  });
                                },
                                items: listChooseUser.map<
                                    DropdownMenuItem<
                                        String>>(
                                        (String model) {
                                      return DropdownMenuItem<
                                          String>(
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
                      Form(
                        key: formKey,
                        child: Column(
                          spacing: 15,
                          mainAxisSize:
                          MainAxisSize.min,
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            TextFormField(
                              controller:
                              nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "يجب ادخال اسم المستخدم لاكمال العمليه";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border:
                                  OutlineInputBorder(),
                                  hintText:
                                  "الاسم"),
                            ),
                            TextFormField(
                              controller:
                              emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "يجب ادخال اسم المستخدم لاكمال العمليه";
                                }
                                return null;
                              },
                              decoration:
                              const InputDecoration(
                                  border:
                                  OutlineInputBorder(),
                                  hintText:
                                  "اسم المستخدم"),
                            ),
                            TextFormField(
                              controller:
                              phoneController,
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return "يجب ادخال رقم الهاتف لاكمال العمليه";
                              //   }
                              //   return null;
                              // },
                              decoration:
                              const InputDecoration(
                                  border:
                                  OutlineInputBorder(),
                                  hintText:
                                  "رقم الهاتف"),
                            ),
                            TextFormField(
                              controller:
                              notesController,
                              decoration:
                              const InputDecoration(
                                  border:
                                  OutlineInputBorder(),
                                  hintText:
                                  "ملاحظة"),
                            ),
                            TextFormField(
                              controller:
                              passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "يجب ادخال الباسورد لاكمال العمليه";
                                }
                                if (value.length<6) {
                                  return "كلمة السر اقل من 6 حروف";
                                }
                                return null;
                              },
                              decoration:
                              const InputDecoration(
                                  border:
                                  OutlineInputBorder(),
                                  hintText:
                                  "الباسورد"),
                            ),
                            const Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                              children: [
                                Text(
                                  "صلاحيات المستخدم",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight
                                          .bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Column(
                                  spacing: 15,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    buildCheckBoxAcceess(
                                        titel:
                                        'اضافة فاتورة',
                                        value:
                                        addOrder,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                addOrder =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'تعديل فاتورة',
                                        value:
                                        editOrder,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                editOrder =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'حذف فاتورة',
                                        value:
                                        removeOrder,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                removeOrder =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'عرض شركة الشحن',
                                        value:
                                        showMandobe,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                showMandobe =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'اضافة شركة الشحن',
                                        value:
                                        addMandobe,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                addMandobe =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'تعديل شركة الشحن',
                                        value:
                                        editMandobe,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                editMandobe =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'حذف شركة الشحن',
                                        value:
                                        removeMandobe,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                removeMandobe =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'عرض المسوقين',
                                        value:
                                        showCode,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                showCode =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'اضافة مسوق',
                                        value:
                                        addCode,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                addCode =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'تعديل مسوق',
                                        value:
                                        editCode,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                editCode =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'حذف مسوق',
                                        value:
                                        removeCode,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                removeCode =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'عرض المخزن',
                                        value:
                                        showStore,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                showStore =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'اضافة للمخزن',
                                        value:
                                        addStore,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                addStore =
                                                value!;
                                              });
                                        }),
                                    buildCheckBoxAcceess(
                                        titel:
                                        'تعديل المخزن',
                                        value:
                                        editStore,
                                        event:
                                            (value) {
                                          setState(
                                                  () {
                                                editStore =
                                                value!;
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
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                if (formKey
                                    .currentState!
                                    .validate()) {
                                  cubit.userRegister(
                                      notes: notesController.text,
                                      name:
                                      nameController
                                          .text,
                                      email:
                                      emailController
                                          .text,
                                      password:
                                      passwordController
                                          .text,
                                      type: choose,
                                      addOrder:
                                      addOrder,
                                      editOrder:
                                      editOrder,
                                      removeOrder:
                                      removeOrder,
                                      showCode:
                                      showCode,
                                      addCode: addCode,
                                      editCode:
                                      editCode,
                                      removeCode:
                                      removeCode,
                                      showMandobe:
                                      showMandobe,
                                      addMandobe:
                                      addMandobe,
                                      editMandobe:
                                      editMandobe,
                                      removeMandobe:
                                      removeMandobe,
                                      showStore:
                                      showStore,
                                      addStore:
                                      addStore,
                                      editStore:
                                      editStore,
                                      changeStatus: changeStatus,
                                      addComment: addComment, phone: phoneController.text
                                  );
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                    vertical: 10,
                                    horizontal:
                                    15),
                                decoration: BoxDecoration(
                                    color:
                                    defaultColor,
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        5)),
                                child: Center(
                                  child: const Text(
                                    "اضافة مستخدم",
                                    style: TextStyle(
                                        color: Colors
                                            .white,
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ))),
      )
      ,

    );});
  }
}
