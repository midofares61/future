import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/model/gift_model.dart';
import 'package:future/modules/store/add_store.dart';
import 'package:future/shared/constant/constant.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/matress_model.dart';
import '../../shared/componnents/componnents.dart';
import 'add_location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var nameController = TextEditingController();

  var nameEditController = TextEditingController();
  var countEditController = TextEditingController();

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

  String? choose="اضافة منطقة";

  List<String> listChoose=[
    "اضافة منطقة",
    if(usermodel!.addStore!)
      "اضافة للمخزن"
  ];

  GiftModel? giftvalue;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          double screenWidth = MediaQuery.of(context).size.width;
          return Scaffold(
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                color:const Color.fromRGBO(232, 243, 255, 1),
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                            children: [
                              Text(
                                "المناطق",
                                style: TextStyle(
                                    color: secondeColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: const  EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade100,
                                            width: 1))),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                        child: Text(
                                          "مسلسل",
                                          style: TextStyle(
                                              color: secondeColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Text("العنوان",
                                            style: TextStyle(
                                                color: secondeColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600))),
                                    Expanded(
                                        child: Text(
                                          "السعر",
                                          style: TextStyle(
                                              color: secondeColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        )),
                                    Expanded(
                                        child: Text(
                                          "",
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
                                  child: ConditionalBuilder(
                                    condition: cubit.shippingPrice!=null,
                                    builder: (context) => ConditionalBuilder(
                                        condition: cubit.shippingPrice!.isNotEmpty,
                                        builder: (context)=>ListView.separated(
                                          itemBuilder: (context, index) => Container(
                                            padding: const  EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.grey.shade100,
                                                        width: 1))),
                                            child: Row(
                                              spacing: 10,
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                      "${index+1}",
                                                      style: TextStyle(
                                                          color: defaultColor,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: SelectableText(cubit.shippingPrice![index].governorate!,
                                                        style:const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600))),
                                                Expanded(
                                                    child: Text(
                                                      "${cubit.shippingPrice![index].price ?? ""}",
                                                      style:const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w600),
                                                      textAlign: TextAlign.center,
                                                    )),
                                                Expanded(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        if(usermodel!.editStore!)
                                                          InkWell(
                                                            onTap: (){
                                                              setState(() {
                                                                nameEditController.text=cubit.shippingPrice![index].governorate!;
                                                                countEditController.text="${cubit.shippingPrice![index].price!}";
                                                              });
                                                              showDialog(context: context, builder: (context)=>AlertDialog(
                                                                title:const Text("تعديل منطقة",textAlign: TextAlign.center,),
                                                                content: Directionality(
                                                                  textDirection: TextDirection.rtl,
                                                                  child: Form(
                                                                    key: formEditKey,
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: [
                                                                        TextFormField(
                                                                          controller: nameEditController,
                                                                          validator: (value){
                                                                            if(value!.isEmpty){
                                                                              return "يجب ادخال اسم المنطقة لاكمال العمليه";
                                                                            }
                                                                            return null;
                                                                          },
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(),
                                                                              hintText: "اسم المنطقة"
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 20,),
                                                                        TextFormField(
                                                                          controller: countEditController,
                                                                          validator: (value){
                                                                            if(value!.isEmpty){
                                                                              return "يجب ادخال السعر لاكمال العمليه";
                                                                            }
                                                                            return null;
                                                                          },
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(),
                                                                              hintText: "السعر"
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  TextButton(onPressed: (){
                                                                    if(formEditKey.currentState!.validate()){
                                                                      cubit.updateShippingPrice(governorate: nameEditController.text,id: cubit.shippingPrice![index].id!, price: int.parse(countEditController.text));
                                                                      nameEditController.text="";
                                                                      countEditController.text="";
                                                                      Navigator.pop(context);
                                                                    }
                                                                  }, child: const Text("تعديل"))
                                                                ],
                                                              ));
                                                            },
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(
                                                                  horizontal: 5, vertical: 5),
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  boxShadow:const [
                                                                    BoxShadow(
                                                                        color: Colors.grey,
                                                                        offset: Offset(0, 0),
                                                                        blurRadius: 2
                                                                    )
                                                                  ],
                                                                  borderRadius: BorderRadius.circular(5)),
                                                              child:const Icon(Icons.mode_edit_outlined,size: 15,),
                                                            ),
                                                          ),

                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                          separatorBuilder: (context, index) => const SizedBox(
                                            height: 0,
                                          ),
                                          itemCount: cubit.shippingPrice!.length,
                                        ),
                                        fallback: (context)=>Expanded(child: Center(child: Text("لم يتم اضافة اي مناطق",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight:
                                              FontWeight.bold),),))
                                    ),
                                    fallback: (context) =>
                                    const Center(child: CircularProgressIndicator()),
                                  )),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: Visibility(
              visible: usermodel!.addOrder!,
              child: FloatingActionButton(
                onPressed: () {
                  navigateTo(
                      context: context,
                      widget: const AddLocation());
                },
                child: Icon(Icons.add),
              ),
            ),
          );
        });
  }
}
