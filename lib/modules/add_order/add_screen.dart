import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/model/user_model.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/gift_model.dart';
import '../../model/location_model.dart';
import '../../model/order_details_model.dart';
import '../../shared/componnents/componnents.dart';
import '../../shared/constant/constant.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  final FocusNode _thirdFocusNode = FocusNode();
  final FocusNode _forthFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _codeFocusNode = FocusNode();
  final FocusNode _mandobeFocusNode = FocusNode();
  final FocusNode _codeProductNode = FocusNode();
  final FocusNode _quantityFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _detailsFocusNode = FocusNode();

  DateTime date = DateTime.now();
  var formKeys = GlobalKey<FormState>();
  late ShippingPrice locationValue;
  var formKey = GlobalKey<FormState>();

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // التأكد من أن الـ FocusNode مضبوط على التركيز
    _focusNode.requestFocus();
  }


  @override
  Widget build(BuildContext context) {
    int midPoint = (AppCubit.get(context).gift!.length / 2).ceil();

    List<GiftModel> firstColumn = AppCubit.get(context).gift!.sublist(0, midPoint);
    List<GiftModel> secondColumn = AppCubit.get(context).gift!.sublist(midPoint);
    AppCubit.get(context).gift!.sort((a, b) => a.code!.compareTo(b.code!));
    return BlocConsumer<AppCubit, AppStats>(listener: (context, state) {
      if (state is CreateOrderSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم تسجيل الاوردر بنجاح",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,duration: Duration(milliseconds: 1000),));
      }
    }, builder: (context, state) {
      AppCubit cubit = AppCubit.get(context);
      double screenWidth = MediaQuery.of(context).size.width;
      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title:const Text("اضافة اوردر"),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ConditionalBuilder(
            condition: state is! OnLoadingAddOrderState && state is!  OnLoadingGetGiftState && state is!  OnLoadingGetOrderState,
            builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Form(
                        key: formKeys,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: cubit.nameController,
                                    focusNode: _firstFocusNode,
                                    autofocus: true,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_secondFocusNode);
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "يجب ادخال الاسم لاكمال المهمه";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      labelText: 'الاسم',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: cubit.addressController,
                                    focusNode: _secondFocusNode,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_thirdFocusNode);
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "يجب ادخال العنوان لاكمال المهمه";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      labelText: 'العنوان',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: cubit.phoneController,
                                    focusNode: _thirdFocusNode,
                                    maxLength: 11,
                                    buildCounter: (BuildContext context,
                                        {int? currentLength,
                                        bool? isFocused,
                                        int? maxLength}) {
                                      return null; // إرجاع null لإخفاء العداد
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_forthFocusNode);
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "يجب ادخال رقم الهاتف لاكمال المهمه";
                                      }
                                      if (!value.startsWith("01")) {
                                        return "يجب ادخال رقم صحيح";
                                      }
                                      if (value.length < 11) {
                                        return " هذا الرقم اقل من 11 رقم يجب ادخال رقم صحيح";
                                      }
                                      return null;
                                    },
                                    decoration:const InputDecoration(
                                      isDense: true,
                                      labelText: 'رقم الهاتف',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: cubit.phoneControllerTow,
                                    maxLength: 11,
                                    buildCounter: (BuildContext context,
                                        {int? currentLength,
                                        bool? isFocused,
                                        int? maxLength}) {
                                      return null; // إرجاع null لإخفاء العداد
                                    },
                                    focusNode: _forthFocusNode,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_cityFocusNode);
                                    },

                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return "يجب ادخال رقم الهاتف لاكمال المهمه";
                                    //   }
                                    //   if(!value.startsWith("01")){
                                    //     return "يجب ادخال رقم صحيح";
                                    //   }
                                    //   if(value.length<11){
                                    //     return " هذا الرقم اقل من 11 رقم يجب ادخال رقم صحيح";
                                    //   }
                                    //   return null;
                                    // },
                                    decoration:const InputDecoration(
                                      isDense: true,
                                      labelText: 'رقم أخر',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                // Expanded(
                                //   child: Container(
                                //     width: double.infinity,
                                //     decoration: BoxDecoration(
                                //       border: Border.all(
                                //           width: 1, color: Colors.grey),
                                //       borderRadius: BorderRadius.circular(5),
                                //     ),
                                //     child: DropdownButton<String>(
                                //       elevation: 0,
                                //       padding: EdgeInsets.symmetric(horizontal: 10),
                                //       focusNode: _mandobeFocusNode,
                                //       hint: Text("اختار المندوب"),
                                //       isExpanded: true,
                                //       underline: Container(),
                                //       value: cubit.mandobeValue,
                                //       style: TextStyle(
                                //           color: defaultColor, fontSize: 18),
                                //       onChanged: (String? value) {
                                //         setState(() {
                                //           cubit.mandobeValue = value;
                                //           FocusScope.of(context)
                                //               .requestFocus(_codeFocusNode);
                                //         });
                                //       },
                                //       items: cubit.mandobe!
                                //           .map<DropdownMenuItem<String>>(
                                //               (MandobeModel model) {
                                //         return DropdownMenuItem<String>(
                                //           value: model.name!,
                                //           child: Text(model.name!),
                                //         );
                                //       }).toList(),
                                //     ),
                                //   ),
                                // ),
                              Expanded(
                                child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButton<String>(
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  focusNode: _cityFocusNode,
                                  hint:const Text("اختار المدينة"),
                                  isExpanded: true,
                                  underline: Container(),
                                  value: cubit.cityValue,
                                  style: TextStyle(
                                      color: defaultColor, fontSize: 18),
                                  onChanged: (String? value) {
                                    setState(() {
                                      cubit.cityValue = value;
                                      FocusScope.of(context)
                                          .requestFocus(usermodel!.type == "مسوق الكتروني"?_codeProductNode:_codeFocusNode);
                                    });
                                  },
                                  items: cubit.shippingPrice!
                                      .map<DropdownMenuItem<String>>(
                                          (ShippingPrice model) {
                                        return DropdownMenuItem<String>(
                                          value: model.governorate,
                                          child: Text(model.governorate!),
                                        );
                                      }).toList(),
                                ),
                                                            ),
                              ),
                                if(usermodel!.type != "مسوق الكتروني")
                                const SizedBox(width: 10),
                                if(usermodel!.type != "مسوق الكتروني")
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: DropdownButton<String>(
                                      focusNode: _codeFocusNode,
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      hint: Text("اختار المسوق"),
                                      isExpanded: true,
                                      underline: Container(),
                                      value: cubit.codeValue,
                                      style: TextStyle(
                                          color: defaultColor, fontSize: 18),
                                      onChanged: (String? value) {
                                        setState(() {
                                          cubit.codeValue = value;
                                          FocusScope.of(context)
                                              .requestFocus(_mandobeFocusNode);
                                        });
                                      },
                                      items: cubit.code!.map<DropdownMenuItem<String>>(
                                              (UserModel model) {
                                            return DropdownMenuItem<String>(
                                              value: model.name!,
                                              child: Text(model.name!),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButton<String>(
                                focusNode: _mandobeFocusNode,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                hint: Text("اختار شركة الشحن"),
                                isExpanded: true,
                                underline: Container(),
                                value: cubit.mandobeValue,
                                style: TextStyle(
                                    color: defaultColor, fontSize: 18),
                                onChanged: (String? value) {
                                  setState(() {
                                    cubit.mandobeValue = value;
                                    FocusScope.of(context)
                                        .requestFocus(_codeProductNode);
                                  });
                                },
                                items: cubit.mandobe!.map<DropdownMenuItem<String>>(
                                        (UserModel model) {
                                      return DropdownMenuItem<String>(
                                        value: model.name!,
                                        child: Text(model.name!),
                                      );
                                    }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: formKey,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: cubit.quantityController,
                                      focusNode: _quantityFocusNode,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .digitsOnly,
                                      ],
                                      textInputAction: TextInputAction.next,
                                      textAlign: TextAlign.center,
                                      onFieldSubmitted: (_) {
                                        if (cubit.quantityController.text
                                            .isEmpty) {
                                          cubit.quantityController.text = "1";
                                          FocusScope.of(context)
                                              .requestFocus(_codeProductNode);
                                        } else {
                                          FocusScope.of(context)
                                              .requestFocus(_codeProductNode);
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "يجب ادخال العنوان لاكمال المهمه";
                                        }
                                        return null;
                                      },
                                      decoration:const InputDecoration(
                                        hintText: "الكمية",
                                        isDense: true,
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: cubit.codeProductController,
                                      focusNode: _codeProductNode,
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .digitsOnly,
                                      ],
                                      textAlign: TextAlign.center,
                                      onFieldSubmitted: (_) {
                                        if (cubit.codeProductController.text
                                            .isEmpty) {
                                          cubit.codeProductController.text =
                                              "1";
                                          FocusScope.of(context).requestFocus(
                                              _priceFocusNode);
                                          int code = int.parse(cubit
                                              .codeProductController.text);
                                          setState(() {
                                            cubit.giftValue = cubit.gift!
                                                .firstWhere((element) =>
                                                    element.code == code);
                                          });
                                        } else {
                                          int? code = int.tryParse(cubit
                                              .codeProductController.text);
                                          if (code != null) {
                                            bool productExists = cubit.gift!
                                                .any((product) =>
                                                    product.code == code);
                                            if (productExists) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  _priceFocusNode);
                                              setState(() {
                                                cubit.giftValue = cubit.gift!
                                                    .firstWhere((element) =>
                                                        element.code == code);
                                              });
                                            } else {
                                              dialog(context, onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _codeProductNode);
                                                Navigator.pop(context);
                                              }, onCancelTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _codeProductNode);
                                                Navigator.pop(context);
                                              },
                                                  icon: Icons.error_outline,
                                                  onPressedTitle: "حسنا",
                                                  subTitle:
                                                      "هذا الكود غير صحيح",
                                                  bigTitle: "",
                                                  iconColor: Colors.red);
                                            }
                                          }
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "يجب ادخال العنوان لاكمال المهمه";
                                        }
                                        return null;
                                      },
                                      decoration:const InputDecoration(
                                        hintText: "الكود",
                                        isDense: true,
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      height: 42,
                                      decoration: BoxDecoration(
                                          color:const Color.fromRGBO(
                                              197, 223, 250, 1.0),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                          child: Text(
                                        cubit.giftValue != null
                                            ? cubit.giftValue!.name!
                                            : "الاسم",
                                        style:const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: cubit.priceController,
                                      focusNode: _priceFocusNode,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .digitsOnly,
                                      ],
                                      textInputAction: TextInputAction.next,
                                      textAlign: TextAlign.center,
                                      onFieldSubmitted: (_) {
                                        if (cubit
                                            .priceController.text.isEmpty) {
                                          cubit.priceController.text = "0";
                                          FocusScope.of(context).requestFocus(
                                              _detailsFocusNode);
                                        } else {
                                          FocusScope.of(context).requestFocus(
                                              _detailsFocusNode);
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "يجب ادخال العنوان لاكمال المهمه";
                                        }
                                        return null;
                                      },
                                      decoration:const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "السعر",
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: TextFormField(
                                      controller: cubit.detailsController,
                                      focusNode: _detailsFocusNode,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        if (cubit
                                            .detailsController.text.isEmpty) {
                                          cubit.detailsController.text = " ";
                                          if (formKey.currentState!
                                              .validate()) {
                                            OrderDetailsModel newProduct =
                                                OrderDetailsModel(
                                              name: cubit.giftValue!.name,
                                              id: cubit.giftValue!.id,
                                                  total:int.parse(
                                                      cubit.priceController.text)* int.parse(cubit
                                                      .quantityController.text),
                                              details: cubit
                                                  .detailsController.text,
                                              price: int.parse(
                                                  cubit.priceController.text),
                                              count: int.parse(cubit
                                                  .quantityController.text),
                                              code: int.parse(cubit
                                                  .codeProductController
                                                  .text),
                                            );
                                            if (!cubit.giftList
                                                .contains(newProduct)) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  _quantityFocusNode);
                                              cubit.addToList(
                                                  orderDetailsModel:
                                                      newProduct);
                                              cubit.quantityController.text =
                                                  "";
                                              cubit.codeProductController
                                                  .text = "";
                                              cubit.priceController.text = "";
                                              cubit.detailsController.text =
                                                  "";
                                              cubit.giftValue = null;
                                            } else {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      _codeProductNode);

                                            }
                                          }
                                        } else {
                                          if (formKey.currentState!
                                              .validate()) {
                                            OrderDetailsModel newProduct =
                                                OrderDetailsModel(
                                              name: cubit.giftValue!.name,
                                              id: cubit.giftValue!.id,
                                              total:int.parse(
                                                  cubit.priceController.text)* int.parse(cubit
                                                  .quantityController.text),
                                              details: cubit
                                                  .detailsController.text,
                                              price: int.parse(
                                                  cubit.priceController.text),
                                              count: int.parse(cubit
                                                  .quantityController.text),
                                              code: int.parse(cubit
                                                  .codeProductController
                                                  .text),
                                            );
                                            if (!cubit.giftList
                                                .contains(newProduct)) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  _quantityFocusNode);
                                              cubit.addToList(
                                                  orderDetailsModel:
                                                      newProduct);
                                              cubit.quantityController.text =
                                                  "";
                                              cubit.codeProductController
                                                  .text = "";
                                              cubit.priceController.text = "";
                                              cubit.detailsController.text =
                                                  "";
                                              cubit.giftValue = null;
                                            } else {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      _codeProductNode);
                                              dialog(context, onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _codeProductNode);
                                                Navigator.pop(context);
                                              }, onCancelTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _codeProductNode);
                                                Navigator.pop(context);
                                              },
                                                  icon: Icons.info_outline,
                                                  onPressedTitle: "حسنا",
                                                  subTitle:
                                                      "هذا الصنف موجود في القائمة",
                                                  bigTitle: "",
                                                  iconColor: defaultColor);
                                            }
                                          }
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "يجب ادخال العنوان لاكمال المهمه";
                                        }
                                        return null;
                                      },
                                      decoration:const InputDecoration(
                                        hintText: "ملاحظات",
                                        border: OutlineInputBorder(),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow:const [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 5),
                                    ],
                                    borderRadius: BorderRadius.circular(5)),
                                child:
                                Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 60,
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const[
                                          BoxShadow(
                                              color: Colors.grey, blurRadius: 2)
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "الكميه",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: secondeColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "الكود",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: secondeColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Text(
                                              "الاسم",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: secondeColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "السعر",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: secondeColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),Expanded(
                                            flex: 2,
                                            child: Text(
                                              "الاجمالي",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: secondeColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              "ملاحظات",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: secondeColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Expanded(
                                              child: Text(
                                            "حذف",
                                            style: TextStyle(
                                                color: secondeColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          )),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.separated(
                                        itemBuilder: (context, index) =>
                                            Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey.shade100,
                                                      width: 1))),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow:const [
                                                          BoxShadow(color: Colors.black,blurRadius: 2)
                                                        ],
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    child: Text(
                                                      "${cubit.giftList[index].count!}",
                                                      style:const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  )),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow:const [
                                                        BoxShadow(color: Colors.black,blurRadius: 2)
                                                      ],
                                                      borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    padding:const EdgeInsets.all(2),
                                                    child: Text(
                                                                                                    "${cubit.giftList[index].code!}",
                                                                                                    style:const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                                                                    textAlign: TextAlign.center,
                                                                                                  ),
                                                  )),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                  flex: 6,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow:const [
                                                          BoxShadow(color: Colors.black,blurRadius: 2)
                                                        ],
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    child: Text(
                                                      cubit.giftList[index].name!,
                                                      style:const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  )),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow:const [
                                                        BoxShadow(color: Colors.black,blurRadius: 2)
                                                      ],
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Text(
                                                    "${cubit.giftList[index].price!}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: secondeColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow:const [
                                                        BoxShadow(color: Colors.black,blurRadius: 2)
                                                      ],
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Text(
                                                    "${cubit.giftList[index].total!}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: secondeColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: const[
                                                        BoxShadow(color: Colors.black,blurRadius: 2)
                                                      ],
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Text(
                                                    cubit.giftList[index].details!,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: secondeColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: IconButton(
                                                onPressed: () {
                                                  cubit.removeFromList(
                                                      index: index,
                                                      list: cubit.giftList);
                                                },
                                                icon:const Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.red,
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(),
                                        itemCount: cubit.giftList.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10 ,
                            ),
                            Row(
                              children: [
                                const Text("الاجمالي :",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text("500",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  padding:const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: InkWell(
                                    onTap: () {
                                      if (formKeys.currentState!.validate()) {
                                        if (cubit.giftList.isNotEmpty) {
                                          dialog(context, onTap: () {
                                            cubit.addOrder(
                                                orderDetails:cubit.giftList,
                                              phoneTow:
                                                  cubit.phoneControllerTow.text,
                                              name: cubit.nameController.text,
                                              phone: cubit.phoneController.text,
                                              address:
                                                  cubit.addressController.text,
                                              mandobeName:
                                                  cubit.mandobeValue ?? "",
                                              code: usermodel!.type == "مسوق الكتروني"?usermodel!.name! :cubit.codeValue ?? "",
                                              total: cubit.totalController.text,
                                              dateTime: date.toString(),
                                              city: cubit.cityValue!
                                            );
                                            Navigator.pop(context);
                                          }, onCancelTap: () {
                                            Navigator.pop(context);
                                          },
                                              icon: Icons.save,
                                              onPressedTitle: "نعم",
                                              subTitle: "هل تريد حفظ الفاتورة",
                                              bigTitle: "حفظ الفاتورة",
                                              iconColor: defaultColor);

                                          // // Clear fields after submission
                                          // cubit.nameController.clear();
                                          // cubit.addressController.clear();
                                          // cubit.phoneController.clear();
                                          // cubit.totalController.clear();
                                          // setState(() {
                                          //   cubit.mandobeValue = null;
                                          //   cubit.codeValue = null;
                                          // });
                                        } else {
                                          dialog(context, onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(_codeProductNode);
                                            Navigator.pop(context);
                                          }, onCancelTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(_codeProductNode);
                                            Navigator.pop(context);
                                          },
                                              icon: Icons.error_outline,
                                              onPressedTitle: "حسنا",
                                              subTitle:
                                                  "يرجي ادخال بعض الاصناف لاكمال الارسال",
                                              bigTitle: "",
                                              iconColor: Colors.red);
                                        }
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "حفظ الفاتورة",
                                          style: TextStyle(
                                              color: defaultColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.save,
                                          size: 20,
                                          color: defaultColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime.now(),
                                            initialDate: DateTime.now())
                                        .then((value) {
                                      setState(() {
                                        date = value!;
                                      });
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'التاريخ',
                                        style: TextStyle(color: defaultColor),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(date.toString().split(' ')[0],
                                          style:
                                              TextStyle(color: defaultColor))
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const[
                              BoxShadow(color: Colors.grey, blurRadius: 5)
                            ],
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Container(
                              padding:const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const[
                                    BoxShadow(color: Colors.grey, blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "الكود",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: secondeColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        "الاسم",
                                        style: TextStyle(
                                            color: secondeColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                                child: Container(
                              padding:const EdgeInsets.symmetric(horizontal: 20),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: firstColumn
                                              .map((gift) => InkWell(
                                                onTap: (){
                                                 setState(() {
                                                   cubit.giftValue=gift;
                                                   cubit.codeProductController.text="${gift.code}";
                                                   FocusScope.of(context)
                                                       .requestFocus(_priceFocusNode);
                                                 });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: cubit.giftValue==gift?defaultColor:Colors.white,
                                                    borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  padding:const EdgeInsets.symmetric(vertical: 3),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                            "${gift.code}",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 15, fontWeight: FontWeight.w600, color: cubit.giftValue==gift?Colors.white:defaultColor),
                                                          )),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            "${gift.name}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w600,
                                                                color: cubit.giftValue==gift?Colors.white:defaultColor
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ))
                                              .toList(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: secondColumn
                                              .map((gift) => InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    cubit.giftValue=gift;
                                                    cubit.codeProductController.text="${gift.code}";
                                                    FocusScope.of(context)
                                                        .requestFocus(_priceFocusNode);
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: cubit.giftValue==gift?defaultColor:Colors.white,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  padding:const EdgeInsets.symmetric(vertical: 4),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                            "${gift.code}",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 15, fontWeight: FontWeight.w600,color: cubit.giftValue==gift?Colors.white:defaultColor),
                                                          )),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            "${gift.name}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w600,
                                                                color: cubit.giftValue==gift?Colors.white:defaultColor
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                                ))
                          ],
                        ),
                      )),
                ],
              ),
            ),
            fallback: (context) =>const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    });
  }
}
