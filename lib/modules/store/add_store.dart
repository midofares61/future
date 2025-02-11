import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/gift_model.dart';
import '../../model/matress_model.dart';
import '../../shared/constant/constant.dart';
class AddStore extends StatefulWidget {
  const AddStore({super.key});

  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  var nameController = TextEditingController();

  var nameEditController = TextEditingController();
  var countEditController = TextEditingController();
  var notesController = TextEditingController();
  var linkController = TextEditingController();
  var priceController = TextEditingController();

  var nameGiftController = TextEditingController();

  var sizeController = TextEditingController();

  var heightController = TextEditingController();

  var countController = TextEditingController();

  var countStoreController = TextEditingController();

  var countGiftController = TextEditingController();

  var countGiftStoreController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var formEditKey = GlobalKey<FormState>();

  MattressModel? mattressValue;

  String? choose="اضافة منتج";

  List<String> listChoose=[
    "اضافة منتج",
    if(usermodel!.addStore!)
      "اضافة للمخزن"
  ];

  GiftModel? giftvalue;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {
          if (state is SocialUpdateUserSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "تم اضافة المنتج بنجاح",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 1000),
            ));
            setState(() {
              nameController.text = "";
              notesController.text = "";
              countController.text = "";
              linkController.text = "";
            });
            Navigator.pop(context);

          }
        },
    builder: (context, state) {
    AppCubit cubit = AppCubit.get(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("اضافة منتج"),
      ),
      body: ConditionalBuilder(
          condition: state is! CreateGiftErrorState || state is! OnLoadingAddGiftState,
          builder: (context)=>Center(
            child: Container(
              width: 600,
              padding: EdgeInsets.all(15),
              child: Padding(
                padding: const  EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("اختار نوع الاضاقة",style: TextStyle(
                            color: secondeColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            width:
                            double.infinity,
                            padding: const EdgeInsets
                                .symmetric(
                                horizontal:
                                15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Colors
                                        .grey),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    5)),
                            child: DropdownButton<
                                String>(
                              hint:const Text(
                                  "اختار نوع الاضاقة"),
                              isExpanded: true,
                              underline:
                              Container(),
                              value:
                              choose,
                              style: TextStyle(
                                  color:
                                  defaultColor,
                                  fontSize: 18),
                              onChanged:
                                  (String?
                              value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  choose =
                                  value!;
                                });
                              },
                              items: listChoose.map<
                                  DropdownMenuItem<
                                      String>>(
                                      (String
                                  model) {
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
                    choose=="اضافة منتج"?
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: (){
                              cubit.picProductImageFromGallery();
                            },
                            child: ConditionalBuilder(
                              condition: cubit.webImage==null,
                              builder: (context)=>Container(
                                color: Colors.grey[200],
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  width: 300,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Text("اضغط هنا لاستيراد الصورة ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              fallback: (context)=>Container(
                                color: Colors.grey[200],
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  width: 300,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Image.memory(
                                      cubit.webImage!,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "يجب ادخال اسم المنتج لاكمال العمليه";
                              }
                              return null;
                            },

                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "اسم المنتج"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: countController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "يجب ادخال الكميه لاكمال العمليه";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "الكميه"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: priceController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "يجب ادخال السعر لاكمال العمليه";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "السعر"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: notesController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "يجب ادخال تفاصيل المنتج لاكمال العمليه";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "تفاصيل المنتج"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: linkController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "لينك الميديا"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.postRequestWithFile(
                                    price:priceController.text,
                                  name: nameController.text,
                                  count: int.parse(
                                      countController.text),
                                  notes: notesController.text,
                                  link: linkController.text,
                                  file: cubit.webImage!
                                );

                              }
                            },
                            child: Container(

                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                              decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Text("اضافة منتج",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            ),
                          )
                        ],
                      ),
                    ):
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize:
                        MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width:
                            double.infinity,
                            padding: const EdgeInsets
                                .symmetric(
                                horizontal:
                                15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Colors
                                        .grey),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    5)),
                            child: DropdownButton<
                                GiftModel>(
                              hint:const Text(
                                  "اختار المنتج"),
                              isExpanded: true,
                              underline:
                              Container(),
                              value:
                              giftvalue,
                              style: TextStyle(
                                  color:
                                  defaultColor,
                                  fontSize: 18),
                              onChanged:
                                  (GiftModel?
                              value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  giftvalue =
                                  value!;
                                });
                              },
                              items: cubit.gift!.map<
                                  DropdownMenuItem<
                                      GiftModel>>(
                                      (GiftModel
                                  model) {
                                    return DropdownMenuItem<
                                        GiftModel>(
                                      value: model,
                                      child: Text(model.name!),
                                    );
                                  }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller:
                            countStoreController,
                            validator: (value) {
                              if (value!
                                  .isEmpty) {
                                return "يجب ادخال الكميه لاكمال العمليه";
                              }
                              return null;
                            },
                            decoration:
                            const InputDecoration(
                                border:
                                OutlineInputBorder(),
                                hintText:
                                "الكميه"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.updateGift(
                                  count: int.parse(
                                      countStoreController.text), id: giftvalue!.id!,
                                );
                                giftvalue=null;
                                countStoreController.text = "";
                              }
                            },
                            child: Container(

                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                              decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child:const Text("اضافة للمخزن",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
      ),
    );});
  }
}
