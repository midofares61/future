import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/model/user_model.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/gift_model.dart';
import '../../model/location_model.dart';
import '../../model/mandobe_model.dart';
import '../../model/order_details_model.dart';
import '../../shared/componnents/componnents.dart';
import '../../shared/constant/constant.dart';

class AddScreenMobile extends StatefulWidget {
  const AddScreenMobile({super.key});

  @override
  State<AddScreenMobile> createState() => _AddScreenMobileState();
}

class _AddScreenMobileState extends State<AddScreenMobile> {
  @override
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  final FocusNode _thirdFocusNode = FocusNode();
  final FocusNode _forthFocusNode = FocusNode();
  final FocusNode _mandobeFocusNode = FocusNode();
  final FocusNode _codeFocusNode = FocusNode();
  final FocusNode _codeProductNode = FocusNode();
  final FocusNode _quantityFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _detailsFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();

  DateTime date = DateTime.now();
  var formKeys = GlobalKey<FormState>();
  late ShippingPrice locationValue;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int midPoint = (AppCubit.get(context).gift!.length / 2).ceil();

    List<GiftModel> firstColumn =
        AppCubit.get(context).gift!.sublist(0, midPoint);
    List<GiftModel> secondColumn =
        AppCubit.get(context).gift!.sublist(midPoint);
    AppCubit.get(context).gift!.sort((a, b) => a.code!.compareTo(b.code!));
    return BlocConsumer<AppCubit, AppStats>(listener: (context, state) {
      if (state is CreateOrderSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "تم تسجيل الاوردر بنجاح",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 1000),
        ));
      }
    }, builder: (context, state) {
      AppCubit cubit = AppCubit.get(context);

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text("اضافة اوردر"),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ConditionalBuilder(
            condition: state is! OnLoadingAddOrderState &&
                state is! OnLoadingGetGiftState &&
                state is! OnLoadingGetOrderState,
            builder: (context) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: SingleChildScrollView(
                child: Form(
                  key: formKeys,
                  child: Column(
                    spacing: 10,
                    children: [
                      TextFormField(
                        controller: cubit.nameController,
                        focusNode: _firstFocusNode,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_secondFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "يجب ادخال الاسم لاكمال المهمه";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'الاسم',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      TextFormField(
                        controller: cubit.addressController,
                        focusNode: _secondFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_thirdFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "يجب ادخال العنوان لاكمال المهمه";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'العنوان',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    TextFormField(
                      controller: cubit.phoneController,
                      focusNode: _thirdFocusNode,
                      maxLength: 11,
                      buildCounter: (BuildContext context, {int? currentLength, bool? isFocused, int? maxLength}) {
                        return null; // إخفاء العداد
                      },
                      inputFormatters: <TextInputFormatter>[
                        ArabicEnglishDigitsFormatter(),
                      ],
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        print("change $value");
                        // تحويل الأرقام العربية إلى إنجليزية عند التغيير
                        String convertedValue = convertArabicToEnglishNumbers(value);
                        if (convertedValue != value) {
                          cubit.phoneController.value = TextEditingValue(
                            text: convertedValue,
                            selection: TextSelection.collapsed(offset: convertedValue.length),
                          );
                        }
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_forthFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "يجب ادخال رقم الهاتف لاكمال المهمه";
                        }

                        // تحويل الأرقام العربية إلى إنجليزية قبل التحقق
                        String convertedValue = convertArabicToEnglishNumbers(value);

                        if (!convertedValue.startsWith("01")) {
                          return "يجب ادخال رقم صحيح";
                        }
                        if (convertedValue.length < 11) {
                          return "هذا الرقم أقل من 11 رقم، يجب إدخال رقم صحيح";
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: 'رقم الهاتف',
                        border: OutlineInputBorder(),
                      ),
                    ),

                      TextFormField(
                        controller: cubit.phoneControllerTow,
                        maxLength: 11,
                        keyboardType: TextInputType.phone,
                        buildCounter: (BuildContext context,
                            {int? currentLength,
                            bool? isFocused,
                            int? maxLength}) {
                          return null; // إرجاع null لإخفاء العداد
                        },
                        focusNode: _forthFocusNode,
                        inputFormatters: <TextInputFormatter>[
                          ArabicEnglishDigitsFormatter(),
                        ],
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          print("change $value");
                          // تحويل الأرقام العربية إلى إنجليزية عند التغيير
                          String convertedValue = convertArabicToEnglishNumbers(value);
                          if (convertedValue != value) {
                            cubit.phoneControllerTow.value = TextEditingValue(
                              text: convertedValue,
                              selection: TextSelection.collapsed(offset: convertedValue.length),
                            );
                          }
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_codeFocusNode);
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
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'رقم أخر',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      // Container(
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //         width: 1, color: Colors.grey),
                      //     borderRadius: BorderRadius.circular(5),
                      //   ),
                      //   child: DropdownButton<String>(
                      //     elevation: 0,
                      //     padding: const EdgeInsets.symmetric(horizontal: 10),
                      //     focusNode: _cityFocusNode,
                      //     hint:const Text("اختار المدينة"),
                      //     isExpanded: true,
                      //     underline: Container(),
                      //     value: cubit.cityValue,
                      //     style: TextStyle(
                      //         color: defaultColor, fontSize: 18),
                      //     onChanged: (String? value) {
                      //       setState(() {
                      //         ShippingPrice? selectedCity = cubit.shippingPrice!.firstWhere(
                      //               (element) => element.governorate == value,
                      //           orElse: () => ShippingPrice(governorate: "", price: 0, id: ''), // قيمة افتراضية
                      //         );
                      //         cubit.changeLocation(value!,selectedCity.price!);
                      //         FocusScope.of(context)
                      //             .requestFocus(usermodel!.type == "مسوق الكتروني"?_codeProductNode:_codeFocusNode);
                      //       });
                      //     },
                      //     items: cubit.shippingPrice!
                      //         .map<DropdownMenuItem<String>>(
                      //             (ShippingPrice model) {
                      //           return DropdownMenuItem<String>(
                      //             value: model.governorate,
                      //             child: Text(model.governorate!),
                      //           );
                      //         }).toList(),
                      //   ),
                      // ),
                      DropDownSearchField(
                        textFieldConfiguration: TextFieldConfiguration(
                            controller:cubit.locationController,
                            style: DefaultTextStyle.of(context)
                                .style
                                .copyWith(fontStyle: FontStyle.italic),
                            decoration:
                                InputDecoration(border: OutlineInputBorder())),
                        suggestionsCallback: (pattern) async {
                          return await getSuggestions(pattern, cubit);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion['governorate']),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          setState(() {
                            ShippingPrice? selectedCity =
                                cubit.shippingPrice!.firstWhere(
                              (element) =>
                                  element.governorate ==
                                  suggestion['governorate'],
                              orElse: () => ShippingPrice(
                                  governorate: "",
                                  price: 0,
                                  id: ''), // قيمة افتراضية
                            );
                            cubit.changeLocation(
                                suggestion['governorate'], selectedCity.price!);
                            FocusScope.of(context).requestFocus(
                                usermodel!.type == "مسوق الكتروني"
                                    ? _codeProductNode
                                    : _codeFocusNode);
                          });
                        },
                        displayAllSuggestionWhenTap: true,
                        isMultiSelectDropdown: false,
                      ),
                      if (usermodel!.type != "مسوق الكتروني")
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton<UserModel>(
                            focusNode: _codeFocusNode,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            hint: Text("اختار المسوق"),
                            isExpanded: true,
                            underline: Container(),
                            value: cubit.codeValue, // يجب أن يكون UserModel
                            style: TextStyle(color: defaultColor, fontSize: 18),
                            onChanged: (UserModel? value) {
                              setState(() {
                                cubit.codeValue = value; // تخزين الكائن بالكامل
                                FocusScope.of(context)
                                    .requestFocus(_mandobeFocusNode);
                              });
                            },
                            items: cubit.code!.map<DropdownMenuItem<UserModel>>(
                                (UserModel model) {
                              return DropdownMenuItem<UserModel>(
                                value: model, // تخزين الكائن بالكامل
                                child: Text(model.name!), // عرض الاسم فقط
                              );
                            }).toList(),
                          ),
                        ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<UserModel>(
                          focusNode: _mandobeFocusNode,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          hint: Text("اختار شركة الشحن"),
                          isExpanded: true,
                          underline: Container(),
                          value: cubit.mandobeValue,
                          style: TextStyle(color: defaultColor, fontSize: 18),
                          onChanged: (UserModel? value) {
                            setState(() {
                              cubit.mandobeValue = value;
                              FocusScope.of(context)
                                  .requestFocus(_codeProductNode);
                            });
                          },
                          items: cubit.mandobe!
                              .map<DropdownMenuItem<UserModel>>(
                                  (UserModel model) {
                            return DropdownMenuItem<UserModel>(
                              value: model,
                              child: Text(model.name!),
                            );
                          }).toList(),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2150),
                                  initialDate: DateTime.now())
                              .then((value) {
                            setState(() {
                              date = value!;
                            });
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'التاريخ',
                                style: TextStyle(
                                    color: defaultColor, fontSize: 18),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('${date.toString().split(' ')[0]}',
                                  style: TextStyle(
                                      color: defaultColor, fontSize: 18))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Form(
                          key: formKey,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton<GiftModel>(
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    focusNode: _codeProductNode,
                                    hint: const Text("اختار الصنف"),
                                    isExpanded: true,
                                    underline: Container(),
                                    value: cubit.giftValue,
                                    style: TextStyle(
                                        color: defaultColor, fontSize: 18),
                                    onChanged: (GiftModel? value) {
                                      setState(() {
                                        cubit.giftValue = value;
                                        FocusScope.of(context)
                                            .requestFocus(_quantityFocusNode);
                                      });
                                    },
                                    items: cubit.gift!
                                        .map<DropdownMenuItem<GiftModel>>(
                                            (GiftModel model) {
                                      return DropdownMenuItem<GiftModel>(
                                        value: model,
                                        child: Text(model.name!),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: cubit.quantityController,
                                  focusNode: _quantityFocusNode,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  textInputAction: TextInputAction.next,
                                  textAlign: TextAlign.center,
                                  onFieldSubmitted: (_) {
                                    if (cubit.quantityController.text.isEmpty) {
                                      cubit.quantityController.text = "1";
                                      FocusScope.of(context)
                                          .requestFocus(_priceFocusNode);
                                    } else {
                                      FocusScope.of(context)
                                          .requestFocus(_priceFocusNode);
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "يجب ادخال الكميه لاكمال المهمه";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "الكمية",
                                    isDense: true,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: cubit.priceController,
                                  focusNode: _priceFocusNode,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  textInputAction: TextInputAction.next,
                                  textAlign: TextAlign.center,
                                  onFieldSubmitted: (_) {
                                    if (cubit.priceController.text.isEmpty) {
                                      cubit.priceController.text =
                                          "${(int.parse(cubit.giftValue!.price!) + int.parse(cubit.giftValue!.price2!))}";
                                      FocusScope.of(context)
                                          .requestFocus(_detailsFocusNode);
                                    } else {
                                      if (int.parse(
                                              cubit.priceController.text) <
                                          (int.parse(cubit.giftValue!.price!) +
                                              int.parse(
                                                  cubit.giftValue!.price2!))) {
                                        dialog(context, onTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(_priceFocusNode);
                                          Navigator.pop(context);
                                        }, onCancelTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(_priceFocusNode);
                                          Navigator.pop(context);
                                        },
                                            icon: Icons.info_outline,
                                            onPressedTitle: "حسنا",
                                            subTitle:
                                                "هذا السعر اقل من سعر المنتج السعر هو ${(int.parse(cubit.giftValue!.price!) + int.parse(cubit.giftValue!.price2!))} ",
                                            bigTitle: "",
                                            iconColor: defaultColor);
                                      } else {
                                        FocusScope.of(context)
                                            .requestFocus(_detailsFocusNode);
                                      }
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "يجب ادخال السعر لاكمال المهمه";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "السعر",
                                    isDense: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 7,
                                child: TextFormField(
                                  controller: cubit.detailsController,
                                  focusNode: _detailsFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    if (int.parse(cubit.priceController.text) <
                                        (int.parse(cubit.giftValue!.price!) +
                                            int.parse(
                                                cubit.giftValue!.price2!))) {
                                      dialog(context, onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(_priceFocusNode);
                                        Navigator.pop(context);
                                      }, onCancelTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(_priceFocusNode);
                                        Navigator.pop(context);
                                      },
                                          icon: Icons.info_outline,
                                          onPressedTitle: "حسنا",
                                          subTitle:
                                              "هذا السعر اقل من سعر المنتج السعر هو ${(int.parse(cubit.giftValue!.price!) + int.parse(cubit.giftValue!.price2!))} ",
                                          bigTitle: "",
                                          iconColor: defaultColor);
                                    } else {
                                      if (cubit
                                          .detailsController.text.isEmpty) {
                                        cubit.detailsController.text = " ";
                                      }
                                      if (formKey.currentState!.validate()) {
                                        OrderDetailsModel newProduct = OrderDetailsModel(
                                            name: cubit.giftValue!.name,
                                            oldPrice: int.parse(
                                                    cubit.giftValue!.price!) +
                                                int.parse(
                                                    cubit.giftValue!.price2!),
                                            id: cubit.giftValue!.id,
                                            uid: cubit.giftValue!.uid,
                                            nameAdd: cubit.giftValue!.nameAdd,
                                            link: cubit.giftValue!.link,
                                            total:
                                                int.parse(cubit.priceController.text) *
                                                    int.parse(cubit
                                                        .quantityController
                                                        .text),
                                            details:
                                                cubit.detailsController.text,
                                            price: int.parse(
                                                cubit.priceController.text),
                                            count: int.parse(
                                                cubit.quantityController.text),
                                            code: cubit.giftValue!.code,
                                            tagerPrice:
                                                int.parse(cubit.giftValue!.price!));
                                        if (!cubit.giftList
                                            .contains(newProduct)) {
                                          FocusScope.of(context)
                                              .requestFocus(_codeProductNode);
                                          cubit.addToList(
                                              orderDetailsModel: newProduct);
                                          cubit.quantityController.clear();
                                          cubit.codeProductController.clear();
                                          cubit.priceController.clear();
                                          cubit.detailsController.clear();
                                          cubit.giftValue = null;
                                        } else {
                                          FocusScope.of(context)
                                              .requestFocus(_codeProductNode);
                                          dialog(
                                            context,
                                            onTap: () => Navigator.pop(context),
                                            onCancelTap: () =>
                                                Navigator.pop(context),
                                            icon: Icons.info_outline,
                                            onPressedTitle: "حسنا",
                                            subTitle:
                                                "هذا الصنف موجود في القائمة",
                                            bigTitle: "",
                                            iconColor: defaultColor,
                                          );
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
                                  decoration: InputDecoration(
                                    hintText: "ملاحظات",
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 5),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            // Header Row
                            Container(
                              height: 60,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 2)
                                ],
                              ),
                              child: Row(
                                children: [
                                  headerCell("الكود", 2),
                                  headerCell("الاسم", 5),
                                  headerCell("الكميه", 2),
                                  headerCell("السعر", 2),
                                  headerCell("الاجمالي", 2),
                                  headerCell("ملاحظات", 5),
                                  headerCell("حذف", 2),
                                ],
                              ),
                            ),
                            // Data Rows
                            ConditionalBuilder(
                                condition: cubit.giftList.isNotEmpty,
                                builder: (context) => ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: cubit.giftList.length,
                                      itemBuilder: (context, index) {
                                        return dataRow(cubit, index);
                                      },
                                    ),
                                fallback: (context) => Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "لا يوجد اي اصناف قم باضافة بعض الاصناف",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ))
                          ],
                        ),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       boxShadow: [
                      //         BoxShadow(color: Colors.grey, blurRadius: 5),
                      //       ],
                      //       borderRadius: BorderRadius.circular(5)),
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         width: double.infinity,
                      //         height: 60,
                      //         padding: const EdgeInsets.all(10.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(5),
                      //           boxShadow: [
                      //             BoxShadow(color: Colors.grey, blurRadius: 2)
                      //           ],
                      //         ),
                      //         child: Row(
                      //           children: [
                      //             Expanded(
                      //               child: Text(
                      //                 "الكود",
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                     color: secondeColor,
                      //                     fontSize: 15,
                      //                     fontWeight: FontWeight.w600),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 5,
                      //             ),
                      //             Expanded(
                      //               flex: 6,
                      //               child: Text(
                      //                 "الاسم",
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                     color: secondeColor,
                      //                     fontSize: 15,
                      //                     fontWeight: FontWeight.w600),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 5,
                      //             ),
                      //             Expanded(
                      //               flex: 2,
                      //               child: Text(
                      //                 "الكميه",
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                     color: secondeColor,
                      //                     fontSize: 15,
                      //                     fontWeight: FontWeight.w600),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 5,
                      //             ),
                      //             Expanded(
                      //               flex: 2,
                      //               child: Text(
                      //                 "السعر",
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                     color: secondeColor,
                      //                     fontSize: 15,
                      //                     fontWeight: FontWeight.w600),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 5,
                      //             ),
                      //             Expanded(
                      //               flex: 5,
                      //               child: Text(
                      //                 "ملاحظات",
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                     color: secondeColor,
                      //                     fontSize: 15,
                      //                     fontWeight: FontWeight.w600),
                      //               ),
                      //             ),
                      //             Expanded(
                      //                 child: Text(
                      //               "حذف",
                      //               style: TextStyle(
                      //                   color: secondeColor,
                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.w600),
                      //               textAlign: TextAlign.center,
                      //             )),
                      //           ],
                      //         ),
                      //       ),
                      //       ListView.separated(
                      //         physics: NeverScrollableScrollPhysics(),
                      //         shrinkWrap: true,
                      //         itemBuilder: (context, index) => Container(
                      //           padding: const EdgeInsets.symmetric(
                      //               horizontal: 10.0),
                      //           decoration: BoxDecoration(
                      //               border: Border(
                      //                   bottom: BorderSide(
                      //                       color: Colors.grey.shade100,
                      //                       width: 1))),
                      //           child: Row(
                      //             children: [
                      //               Expanded(
                      //                   child: Container(
                      //                 decoration: BoxDecoration(
                      //                     color: Colors.white,
                      //                     boxShadow: [
                      //                       BoxShadow(
                      //                           color: Colors.black,
                      //                           blurRadius: 2)
                      //                     ],
                      //                     borderRadius:
                      //                         BorderRadius.circular(5)),
                      //                 padding: EdgeInsets.all(2),
                      //                 child: Text(
                      //                   "${cubit.giftList[index].code!}",
                      //                   style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontSize: 15,
                      //                       fontWeight: FontWeight.w400),
                      //                   textAlign: TextAlign.center,
                      //                 ),
                      //               )),
                      //               SizedBox(
                      //                 width: 10,
                      //               ),
                      //               Expanded(
                      //                   flex: 6,
                      //                   child: Container(
                      //                     decoration: BoxDecoration(
                      //                         color: Colors.white,
                      //                         boxShadow: [
                      //                           BoxShadow(
                      //                               color: Colors.black,
                      //                               blurRadius: 2)
                      //                         ],
                      //                         borderRadius:
                      //                             BorderRadius.circular(5)),
                      //                     child: Text(
                      //                       cubit.giftList[index].name!,
                      //                       style: TextStyle(
                      //                           color: Colors.black,
                      //                           fontSize: 15,
                      //                           fontWeight: FontWeight.w400),
                      //                       textAlign: TextAlign.center,
                      //                     ),
                      //                   )),
                      //               SizedBox(
                      //                 width: 10,
                      //               ),
                      //               Expanded(
                      //                   flex: 2,
                      //                   child: Container(
                      //                     decoration: BoxDecoration(
                      //                         color: Colors.white,
                      //                         boxShadow: [
                      //                           BoxShadow(
                      //                               color: Colors.black,
                      //                               blurRadius: 2)
                      //                         ],
                      //                         borderRadius:
                      //                             BorderRadius.circular(5)),
                      //                     child: Text(
                      //                       "${cubit.giftList[index].count!}",
                      //                       style: TextStyle(
                      //                           color: Colors.black,
                      //                           fontSize: 15,
                      //                           fontWeight: FontWeight.w400),
                      //                       textAlign: TextAlign.center,
                      //                     ),
                      //                   )),
                      //               SizedBox(
                      //                 width: 10,
                      //               ),
                      //               Expanded(
                      //                 flex: 2,
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color: Colors.white,
                      //                       boxShadow: [
                      //                         BoxShadow(
                      //                             color: Colors.black,
                      //                             blurRadius: 2)
                      //                       ],
                      //                       borderRadius:
                      //                           BorderRadius.circular(5)),
                      //                   child: Text(
                      //                     "${cubit.giftList[index].price!}",
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                         color: secondeColor,
                      //                         fontSize: 15,
                      //                         fontWeight: FontWeight.w600),
                      //                   ),
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 width: 10,
                      //               ),
                      //               Expanded(
                      //                 flex: 5,
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       color: Colors.white,
                      //                       boxShadow: [
                      //                         BoxShadow(
                      //                             color: Colors.black,
                      //                             blurRadius: 2)
                      //                       ],
                      //                       borderRadius:
                      //                           BorderRadius.circular(5)),
                      //                   child: Text(
                      //                     "${cubit.giftList[index].details!}",
                      //                     textAlign: TextAlign.center,
                      //                     overflow: TextOverflow.ellipsis,
                      //                     maxLines: 1,
                      //                     style: TextStyle(
                      //                         color: secondeColor,
                      //                         fontSize: 15,
                      //                         fontWeight: FontWeight.w600),
                      //                   ),
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 width: 5,
                      //               ),
                      //               Expanded(
                      //                   child: IconButton(
                      //                 onPressed: () {
                      //                   cubit.removeFromList(
                      //                       index: index, list: cubit.giftList);
                      //                 },
                      //                 icon: Icon(
                      //                   Icons.delete_forever,
                      //                   color: Colors.red,
                      //                 ),
                      //               )),
                      //             ],
                      //           ),
                      //         ),
                      //         separatorBuilder: (context, index) => SizedBox(),
                      //         itemCount: cubit.giftList.length,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 9),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text("الاجمالي :    ${cubit.total}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: InkWell(
                                onTap: () {
                                  if (formKeys.currentState!.validate()) {
                                    if (cubit.giftList.isNotEmpty) {
                                      dialog(context, onTap: () {
                                        cubit.addOrder(
                                          phoneTow:
                                              cubit.phoneControllerTow.text,
                                          name: cubit.nameController.text,
                                          phone: cubit.phoneController.text,
                                          address: cubit.addressController.text,
                                          mandobeName:
                                              cubit.mandobeValue!.name ?? "",
                                          code:
                                              usermodel!.type == "مسوق الكتروني"
                                                  ? usermodel!.name!
                                                  : cubit.codeValue!.name ?? "",
                                          uIdMandobeName:
                                              cubit.mandobeValue!.uId ?? "",
                                          uIdCode:
                                              usermodel!.type == "مسوق الكتروني"
                                                  ? usermodel!.uId!
                                                  : cubit.codeValue!.uId ?? "",
                                          priceCity: cubit.cityPrice,
                                          total: "${cubit.total}",
                                          dateTime: date.toString(),
                                          city: cubit.cityValue!,
                                          orderDetails: cubit.giftList,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "حفظ الفاتورة",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.save,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    });
  }

  Widget headerCell(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: secondeColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

// Data Row Widget
  Widget dataRow(cubit, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Row(
        spacing: 5,
        children: [
          dataCell(cubit.giftList[index].code!.toString(), 2),
          dataCell(cubit.giftList[index].name!, 6),
          dataCell(cubit.giftList[index].count!.toString(), 2),
          dataCell(cubit.giftList[index].price!.toString(), 2),
          dataCell(cubit.giftList[index].total!.toString(), 2),
          dataCell(cubit.giftList[index].details!.toString(), 5,
              isEllipsis: true),
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: () {
                cubit.removeFromList(index: index, list: cubit.giftList);
              },
              icon: Icon(Icons.delete_forever, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

// Data Cell Widget
  Widget dataCell(String text, int flex, {bool isEllipsis = false}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 2)],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: isEllipsis ? TextOverflow.ellipsis : TextOverflow.visible,
          maxLines: isEllipsis ? 1 : null,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getSuggestions(
      String pattern, AppCubit cubit) async {
    return cubit.shippingPrice!
        .where((item) =>
            item.governorate!.toLowerCase().contains(pattern.toLowerCase()))
        .map((item) => {
              'governorate': item.governorate,
              'price': item.price, // يمكن إضافة المزيد من البيانات
            })
        .toList();
  }
  String convertArabicToEnglishNumbers(String input) {
    const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const englishNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    for (int i = 0; i < arabicNumbers.length; i++) {
      input = input.replaceAll(arabicNumbers[i], englishNumbers[i]);
    }
    return input;
  }


}
class ArabicEnglishDigitsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final arabicEnglishDigitsRegExp = RegExp(r'[\d٠١٢٣٤٥٦٧٨٩]');

    String filteredText = newValue.text
        .split('')
        .where((char) => arabicEnglishDigitsRegExp.hasMatch(char))
        .join();

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}