import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/model/user_model.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../shared/constant/constant.dart';
import '../../shared/widgets/search_widget.dart';

class MerchantsScreen extends StatefulWidget {
  const MerchantsScreen({super.key});

  @override
  State<MerchantsScreen> createState() => _MerchantsScreenState();
}

class _MerchantsScreenState extends State<MerchantsScreen> {
  var searchController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();
  List<UserModel> searchOrder=[];
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          double screenWidth = MediaQuery.of(context).size.width;
          return Scaffold(
            body: Container(
              color: const Color.fromRGBO(232, 243, 255, 1),
              padding: EdgeInsets.all(screenWidth<600?10:20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding:const EdgeInsets.symmetric(horizontal: 20),
                      decoration:const BoxDecoration(
                          border:Border(
                              bottom:
                              BorderSide(color: Colors.grey, width: 1))),
                      child: Row(
                        children: [
                          Container(
                            padding:const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration:const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromRGBO(155, 145, 255, 1),
                                        width: 2))),
                            child:const Text(
                              "التجار",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(155, 145, 255, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding:const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: search(
                                  searchController: searchController,
                                  onChange: (search) {
                                    setState(() {
                                      searchOrder = [];
                                      searchOrder = cubit.merchants!
                                          .where((element) =>
                                      element.name!
                                          .contains(
                                          searchController
                                              .text) ||
                                          element.phone!
                                              .contains(
                                              searchController
                                                  .text) )
                                          .toList();
                                    });
                                  },
                                  hint: "ابحث بالاسم..."))
                          // const SizedBox(
                          //   width: 20,
                          // ),
                          // if(usermodel!.addCode!)
                          // InkWell(
                          //   onTap: (){
                          //     showDialog(context: context, builder: (context)=>AlertDialog(
                          //       title:const Text("اضافة مسوق",textAlign: TextAlign.center,),
                          //       content: Directionality(
                          //         textDirection: TextDirection.rtl,
                          //         child: Form(
                          //           key: formKey,
                          //           child: Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               TextFormField(
                          //                 controller: nameController,
                          //                 validator: (value){
                          //                   if(value!.isEmpty){
                          //                     return "يجب ادخال اسم المندوب لاكمال العمليه";
                          //                   }
                          //                   return null;
                          //                 },
                          //                 decoration:const InputDecoration(
                          //                     border: OutlineInputBorder(),
                          //                     hintText: "رقم المسوق"
                          //                 ),
                          //               ),
                          //               const SizedBox(height: 20,),
                          //               TextFormField(
                          //                 controller: phoneController,
                          //                 validator: (value){
                          //                   if(value!.isEmpty){
                          //                     return "يجب ادخال رقم الهاتف لاكمال العمليه";
                          //                   }
                          //                   return null;
                          //                 },
                          //                 decoration:const InputDecoration(
                          //                     border: OutlineInputBorder(),
                          //                     hintText: "رقم الهاتف"
                          //                 ),
                          //               )
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //       actions: [
                          //         TextButton(onPressed: (){
                          //           if(formKey.currentState!.validate()){
                          //             cubit.addCode(name: nameController.text, phone: phoneController.text);
                          //             nameController.text="";
                          //             phoneController.text="";
                          //             Navigator.pop(context);
                          //           }
                          //         }, child:const  Text("اضافة"))
                          //       ],
                          //     ));
                          //   },
                          //   child: Container(
                          //     padding:const EdgeInsets.symmetric(
                          //         horizontal: 15, vertical: 10),
                          //     decoration: BoxDecoration(
                          //         color: Colors.grey.shade100,
                          //         borderRadius: BorderRadius.circular(5)),
                          //     child: Text(
                          //       "اضافة مسوق",
                          //       style: TextStyle(
                          //           color: defaultColor,
                          //           fontSize: screenWidth>600?18:15,
                          //           fontWeight: FontWeight.w500),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.shade200,width: 1))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex:4,
                              child: Text(
                                "الاسم",
                                style: TextStyle(
                                    color: secondeColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),Expanded(
                              flex:4,
                              child: Text(
                                "اسم المستخدم",
                                style: TextStyle(
                                    color: secondeColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                          Expanded(
                              flex:4,
                              child: Text(
                                "رقم الهاتف",
                                style: TextStyle(
                                    color: secondeColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                          Expanded(
                              flex:4,
                              child: Text(
                                "الرصيد",
                                style: TextStyle(
                                    color: secondeColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                          // Expanded(
                          //     flex:3,
                          //     child: Text(
                          //       "اخري",
                          //       style: TextStyle(
                          //           color: secondeColor,
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w600),
                          //     )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    ConditionalBuilder(
                        condition: cubit.merchants!=null,
                        builder: (context) => ConditionalBuilder(
                            condition: cubit.merchants!.isNotEmpty,
                            builder: (context)=>Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) => Container(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey.shade200,width: 1))
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        // navigateTo(context: context, widget: CodeDetailsScreen(merchants: '${cubit.merchants![index].name}', orders: cubit.orders,));
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex:4,
                                              child: Text(
                                                searchController
                                                    .text.isNotEmpty? searchOrder[index].name!:  cubit.merchants![index].name!,
                                                style:const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600),
                                              )),Expanded(
                                              flex:4,
                                              child: Text(
                                                searchController
                                                    .text.isNotEmpty? searchOrder[index].email!:  cubit.merchants![index].email!,
                                                style:const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600),
                                              )),
                                          Expanded(
                                              flex:4,
                                              child: Text(
                                                searchController
                                                    .text.isNotEmpty? searchOrder[index].phone??"":  cubit.merchants![index].phone??"",
                                                style:const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600),

                                              )),
                                          Expanded(
                                              flex:4,
                                              child: Text(
                                                searchController
                                                    .text.isNotEmpty? searchOrder[index].totalBalance.toString()??"":  cubit.merchants![index].totalBalance.toString()??"",
                                                style:const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600),

                                              )),
                                          // Expanded(
                                          //   flex:3,
                                          //   child:Row(
                                          //     mainAxisAlignment: MainAxisAlignment.start,
                                          //     children: [
                                          //       if(screenWidth>600)
                                          //         InkWell(
                                          //           onTap: (){
                                          //             // navigateTo(context: context, widget: CodeDetailsScreen(merchants: '${cubit.merchants![index].name}', orders: cubit.orders,));
                                          //           },
                                          //           child: Container(
                                          //             padding:const EdgeInsets.symmetric(
                                          //                 horizontal: 5, vertical: 5),
                                          //             decoration: BoxDecoration(
                                          //                 color: Colors.white,
                                          //                 boxShadow:const [
                                          //                   BoxShadow(
                                          //                       color: Colors.grey,
                                          //                       offset: Offset(0, 0),
                                          //                       blurRadius: 2
                                          //                   )
                                          //                 ],
                                          //                 borderRadius: BorderRadius.circular(5)),
                                          //             child:const Icon(Icons.visibility_outlined,size: 25,),
                                          //           ),
                                          //         ),
                                          //       const SizedBox(width: 15,),
                                          //       if(usermodel!.editCode!)
                                          //         InkWell(
                                          //           onTap: (){
                                          //             setState(() {
                                          //               nameController.text=searchController.text.isEmpty? cubit.merchants![index].name!:searchOrder[index].name!;
                                          //               phoneController.text=searchController.text.isEmpty? cubit.merchants![index].phone!:searchOrder[index].phone!;
                                          //             });
                                          //             showDialog(context: context, builder: (context)=>AlertDialog(
                                          //               title:const Text("تعديل مسوق",textAlign: TextAlign.center,),
                                          //               content: Directionality(
                                          //                 textDirection: TextDirection.rtl,
                                          //                 child: Form(
                                          //                   key: formKey,
                                          //                   child: Column(
                                          //                     mainAxisSize: MainAxisSize.min,
                                          //                     children: [
                                          //                       TextFormField(
                                          //                         controller: nameController,
                                          //                         validator: (value){
                                          //                           if(value!.isEmpty){
                                          //                             return "يجب ادخال المسوق لاكمال العمليه";
                                          //                           }
                                          //                           return null;
                                          //                         },
                                          //                         decoration:const InputDecoration(
                                          //                             border: OutlineInputBorder(),
                                          //                             hintText: "المسوق"
                                          //                         ),
                                          //                       ),
                                          //                       const SizedBox(height: 20,),
                                          //                       TextFormField(
                                          //                         controller: phoneController,
                                          //                         validator: (value){
                                          //                           if(value!.isEmpty){
                                          //                             return "يجب ادخال رقم الهاتف لاكمال العمليه";
                                          //                           }
                                          //                           return null;
                                          //                         },
                                          //                         decoration:const InputDecoration(
                                          //                             border: OutlineInputBorder(),
                                          //                             hintText: "رقم الهاتف"
                                          //                         ),
                                          //                       )
                                          //                     ],
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               actions: [
                                          //                 TextButton(onPressed: (){
                                          //                   if(formKey.currentState!.validate()){
                                          //                     cubit.updateMandobe(name: nameController.text, phone: phoneController.text,id: searchController.text.isEmpty? cubit.merchants![index].uId!:searchOrder[index].uId!, collection: 'merchants');
                                          //                     nameController.text="";
                                          //                     phoneController.text="";
                                          //                     Navigator.pop(context);
                                          //                   }
                                          //                 }, child:const Text("تعديل"))
                                          //               ],
                                          //             ));
                                          //           },
                                          //           child: Container(
                                          //             padding: EdgeInsets.symmetric(
                                          //                 horizontal: screenWidth>600?5:3, vertical: screenWidth>600?5:3),
                                          //             decoration: BoxDecoration(
                                          //                 color: Colors.white,
                                          //                 boxShadow:const [
                                          //                   BoxShadow(
                                          //                       color: Colors.grey,
                                          //                       offset: Offset(0, 0),
                                          //                       blurRadius: 2
                                          //                   )
                                          //                 ],
                                          //                 borderRadius: BorderRadius.circular(5)),
                                          //             child: Icon(Icons.mode_edit_outlined,size: screenWidth>600?25:20,),
                                          //           ),
                                          //         ),
                                          //       if(usermodel!.editCode!)
                                          //         const SizedBox(width: 15,),
                                          //       if(usermodel!.removeCode!)
                                          //         InkWell(
                                          //           onTap: (){
                                          //             dialog(context, onTap: () {
                                          //               cubit.deleteMandobe(id: searchController.text.isEmpty? cubit.merchants![index].uId!:searchOrder[index].uId!, collection: 'merchants');
                                          //               Navigator.pop(context);
                                          //             },
                                          //                 onCancelTap: () {
                                          //                   Navigator.pop(context);
                                          //                 },
                                          //                 icon: Icons.delete_forever_rounded,
                                          //                 onPressedTitle: "نعم",
                                          //                 subTitle: "هل تريد حذف هذا المسوق", bigTitle: "", iconColor: Colors.red);
                                          //           },
                                          //           child: Icon(Icons.delete_forever_rounded,size:screenWidth>600? 35:20,color: Colors.red,),
                                          //         ),
                                          //     ],
                                          //   )  ,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 0,
                                  ),
                                  itemCount: searchController
                                      .text.isNotEmpty? searchOrder.length:cubit.merchants!.length),
                            ),
                            fallback: (context)=>Expanded(child: Center(child: Text("لم يتم اضافة اي مسوقين",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.bold),),))
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()))
                  ],
                ),
              ),
            ),
          );});
  }
}
