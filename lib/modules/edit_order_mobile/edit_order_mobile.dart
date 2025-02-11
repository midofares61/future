import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
import '../../model/matress_model.dart';
import '../../model/order_details_model.dart';
import '../../model/order_model.dart';
import '../../shared/componnents/componnents.dart';
import '../../shared/constant/constant.dart';

class EditScreenMobile extends StatefulWidget {
   EditScreenMobile({super.key,required this.order});
  OrderModel order;
  @override
  State<EditScreenMobile> createState() => _EditScreenMobileState();
}

class _EditScreenMobileState extends State<EditScreenMobile> {
  @override
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  final FocusNode _thirdFocusNode = FocusNode();
  final FocusNode _forthFocusNode = FocusNode();
  final FocusNode _codeFocusNode = FocusNode();
  final FocusNode _codeProductNode = FocusNode();
  final FocusNode _quantityFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _detailsFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _mandobeFocusNode = FocusNode();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var phoneControllerTow=TextEditingController();
  var mandobeNameController=TextEditingController();
  var addressController=TextEditingController();
  var totalController=TextEditingController();
  var codeController=TextEditingController();
  var codeProductController=TextEditingController();
  var quantityController=TextEditingController();
  var priceController=TextEditingController();
  var detailsController=TextEditingController();
  DateTime date = DateTime.now();
  var formKeys = GlobalKey<FormState>();
  late ShippingPrice locationValue;
  var formKey = GlobalKey<FormState>();

  var countStoreController=TextEditingController();
  String? cityValue;
  int cityPrice=0;
  String? codeValue;
  String? mandobeValue;
  MattressModel? mattressValue;
  GiftModel? giftValue;
  int total=0;
  void sumTotal(){
    setState(() {
    total = giftList.fold(0, (sum, order) => sum + order.total!)+cityPrice;
    });
  }
  void changeLocation(String value,int price) {
    setState(() {
      cityValue = value;
      cityPrice = price;
      sumTotal();
    });
  }
  void removeFromList({
    required int index,
    required List list,
  }){
    setState(() {
      list.removeAt(index);
      sumTotal();
    });
  }
  List<MattressModel> mattressList=[];
  List<OrderDetailsModel> giftList=[];
  FocusNode _focusNode = FocusNode();

  void addToList({
    required  OrderDetailsModel orderDetailsModel,
  }){
    setState(() {
      giftList.add(orderDetailsModel);
    });
  }
  @override
  void initState() {
    nameController.text=widget.order.name!;
    phoneController.text=widget.order.phone!;
    addressController.text=widget.order.address!;
    total=int.parse(widget.order.total!);
    cityValue=widget.order.city!;
    codeValue=widget.order.code!;
    mandobeValue=widget.order.mandobeName!;
    giftList=widget.order.details!;
    // sumTotal();
    date=DateTime(int.parse(widget.order.dateTime!.split("-")[0]),int.parse(widget.order.dateTime!.split("-")[1]),int.parse(widget.order.dateTime!.split(" ")[0].split("-")[2]));
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStats>(listener: (context, state) {
      if (state is EditOrderSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "تم تعديل الاوردر بنجاح",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 1000),
        ));
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      AppCubit cubit = AppCubit.get(context);

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text("Edit Order"),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ConditionalBuilder(
            condition: state is! OnLoadingAddOrderState &&
                state is! OnLoadingGetGiftState &&
                state is! OnLoadingGetOrderState,
            builder: (context) =>
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKeys,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            focusNode: _firstFocusNode,
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(
                                  _secondFocusNode);
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
                          SizedBox(height: 10),
                          TextFormField(
                            controller: addressController,
                            focusNode: _secondFocusNode,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(
                                  _thirdFocusNode);
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
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: phoneController,
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
                              FocusScope.of(context).requestFocus(
                                  _forthFocusNode);
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
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'رقم الهاتف',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: phoneControllerTow,
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
                              FocusScope.of(context).requestFocus(
                                  _codeFocusNode);
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
                          SizedBox(height: 10),
                          Container(
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
                              value: cityValue,
                              style: TextStyle(
                                  color: defaultColor, fontSize: 18),
                              onChanged: (String? value) {
                                setState(() { 
                                  ShippingPrice? selectedCity = cubit.shippingPrice!.firstWhere(
                                        (element) => element.governorate == value,
                                    orElse: () => ShippingPrice(governorate: "", price: 0, id: ''), // قيمة افتراضية
                                  );
                                  changeLocation(value!,selectedCity.price!);
                                  FocusScope.of(context)
                                      .requestFocus(_codeFocusNode);
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
                              focusNode: _codeFocusNode,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              hint: Text("اختار الكود"),
                              isExpanded: true,
                              underline: Container(),
                              value: codeValue,
                              style: TextStyle(
                                  color: defaultColor, fontSize: 18),
                              onChanged: (String? value) {
                                setState(() {
                                  codeValue = value;
                                  FocusScope.of(context)
                                      .requestFocus(_codeProductNode);
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
                          SizedBox(
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
                              value: mandobeValue,
                              style: TextStyle(
                                  color: defaultColor, fontSize: 18),
                              onChanged: (String? value) {
                                setState(() {
                                  mandobeValue = value;
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
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: (){
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
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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
                                          color: defaultColor,
                                          fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        focusNode: _codeProductNode,
                                        hint:const Text("اختار الصنف"),
                                        isExpanded: true,
                                        underline: Container(),
                                        value: giftValue,
                                        style: TextStyle(
                                            color: defaultColor, fontSize: 18),
                                        onChanged: (GiftModel? value) {
                                          setState(() {
                                            giftValue = value;
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
                                      controller: quantityController,
                                      focusNode: _quantityFocusNode,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      textInputAction: TextInputAction.next,
                                      textAlign: TextAlign.center,
                                      onFieldSubmitted: (_) {
                                        if (quantityController.text
                                            .isEmpty) {
                                          quantityController.text = "1";
                                          FocusScope.of(context)
                                              .requestFocus(_priceFocusNode);
                                        } else {
                                          FocusScope.of(context)
                                              .requestFocus(_priceFocusNode);
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "يجب ادخال العنوان لاكمال المهمه";
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
                                      controller: priceController,
                                      focusNode: _priceFocusNode,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      textInputAction: TextInputAction.next,
                                      textAlign: TextAlign.center,
                                      onFieldSubmitted: (_) {
                                        if (priceController.text
                                            .isEmpty) {
                                          priceController.text = "0";
                                          FocusScope.of(context)
                                              .requestFocus(_detailsFocusNode);
                                        } else {
                                          FocusScope.of(context)
                                              .requestFocus(_detailsFocusNode);
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "يجب ادخال العنوان لاكمال المهمه";
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
                                      controller: detailsController,
                                      focusNode: _detailsFocusNode,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        if (detailsController.text
                                            .isEmpty) {
                                          detailsController.text = " ";
                                          if (formKey.currentState!
                                              .validate()) {
                                            OrderDetailsModel newProduct =
                                            OrderDetailsModel(
                                              name: giftValue!.name,
                                              id: giftValue!.id,
                                              details: detailsController
                                                  .text,
                                              price: int.parse(
                                                  priceController.text),
                                              count: int.parse(
                                                  quantityController
                                                      .text),
                                              code: giftValue!.code,
                                            );
                                            if (!giftList
                                                .contains(newProduct)) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  _codeProductNode);
                                              addToList(
                                                  orderDetailsModel: newProduct);
                                              print(
                                                  "${newProduct
                                                      .name} has been added to the list.");
                                              quantityController.text =
                                              "";
                                              codeProductController.text =
                                              "";
                                              priceController.text = "";
                                              detailsController.text = "";
                                              giftValue = null;
                                            } else {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  _codeProductNode);
                                              print(
                                                  "${newProduct
                                                      .name} is already in the list.");
                                            }
                                          }
                                        } else {
                                          if (formKey.currentState!
                                              .validate()) {
                                            OrderDetailsModel newProduct =
                                            OrderDetailsModel(
                                              name: giftValue!.name,
                                              id: giftValue!.id,
                                              details: detailsController
                                                  .text,
                                              price: int.parse(
                                                  priceController.text),
                                              count: int.parse(
                                                  quantityController
                                                      .text),
                                              code: giftValue!.code,
                                            );
                                            if (!giftList
                                                .contains(newProduct)) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  _codeProductNode);
                                              addToList(
                                                  orderDetailsModel: newProduct);
                                              quantityController.text =
                                              "";
                                              codeProductController.text =
                                              "";
                                              priceController.text = "";
                                              detailsController.text = "";
                                              giftValue = null;
                                            } else {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                  _codeProductNode);
                                              dialog(context, onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                    _codeProductNode);
                                                Navigator.pop(context);
                                              },
                                                  onCancelTap: () {
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
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 2)
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      headerCell("الكود", 2),
                                      headerCell("الاسم", 5),
                                      headerCell("الكميه", 2),
                                      headerCell("السعر", 2),
                                      headerCell("ملاحظات", 5 ),
                                      headerCell("حذف", 2),
                                    ],
                                  ),
                                ),
                                // Data Rows
                                ConditionalBuilder(condition: giftList.isNotEmpty, builder: (context)=>ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: giftList.length,
                                  itemBuilder: (context, index) {
                                    return dataRow(cubit, index);
                                  },
                                ), fallback: (context)=>Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("لا يوجد اي اصناف قم باضافة بعض الاصناف",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),))
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
                                    child: Text("الاجمالي :    $total",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,color: Colors.white)),
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
                                        if (giftList.isNotEmpty) {
                                          dialog(context, onTap: () {
                                            cubit.editOrder(
                                              phoneTow: phoneControllerTow
                                                  .text,
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              address: addressController
                                                  .text,
                                              mandobeName: widget.order.mandobeName ??
                                                  "",
                                              code: codeValue ?? "",
                                              total: total.toString(),
                                              dateTime: date.toString(), city: cityValue!, id: widget.order.id!, giftList: giftList,
                                            );
                                            Navigator.pop(context);
                                          },
                                              onCancelTap: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icons.save,
                                              onPressedTitle: "نعم",
                                              subTitle: "هل تريد تعديل الفاتورة",
                                              bigTitle: "تعديل الفاتورة",
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
                                          },
                                              onCancelTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                    _codeProductNode);
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
                                          "تعديل الفاتورة",
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
        border: Border(
            bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Row(
        children: [
          dataCell(giftList[index].code!.toString(), 2),
          SizedBox(width: 5,),
          dataCell(giftList[index].name!, 6),
          SizedBox(width: 5,),
          dataCell(giftList[index].count!.toString(), 2),
          SizedBox(width: 5,),
          dataCell(giftList[index].price!.toString(), 2),
          SizedBox(width: 5,),
          dataCell(giftList[index].details!.toString(), 5, isEllipsis: true),
          SizedBox(width: 5,),
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: () {
                removeFromList(index: index, list: giftList);
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
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 2)
          ],
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
}
