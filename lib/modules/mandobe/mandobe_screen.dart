import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/model/user_model.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/mandobe_model.dart';
import '../../shared/componnents/componnents.dart';
import '../../shared/constant/constant.dart';
import '../../shared/widgets/search_widget.dart';

class MandobeScreen extends StatefulWidget {
  const MandobeScreen({super.key});

  @override
  State<MandobeScreen> createState() => _MandobeScreenState();
}

class _MandobeScreenState extends State<MandobeScreen> {
  var searchController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  List<UserModel> searchOrder = [];

  var formKey = GlobalKey<FormState>();

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
              padding:  EdgeInsets.all(screenWidth<600?10:20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1))),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromRGBO(155, 145, 255, 1),
                                        width: 2))),
                            child: const Text(
                              "شركات الشحن",
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: search(
                                  searchController: searchController,
                                  onChange: (search) {
                                    setState(() {
                                      searchOrder = [];
                                      searchOrder = cubit.mandobe!
                                          .where((element) =>
                                              element.name!.contains(
                                                  searchController.text) ||
                                              element.phone!.contains(
                                                  searchController.text))
                                          .toList();
                                    });
                                  },
                                  hint: "ابحث بالاسم , رقم الهاتف...")),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.shade200, width: 1))),
                      child: Row(
                        spacing: 10,
                        children: [
                          Text(
                            "    ",
                            style: TextStyle(
                                color: secondeColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                              flex: 4,
                              child: Text(
                                "الاسم",
                                style: TextStyle(
                                    color: secondeColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),  Expanded(
                              flex: 4,
                              child: Text(
                                "اسم المستخدم",
                                style: TextStyle(
                                    color: secondeColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text(
                                "رقم الهاتف",
                                style: TextStyle(
                                    color: secondeColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text(
                                "الرصيد",
                                style: TextStyle(
                                    color: secondeColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                          // Expanded(
                          //     flex: 3,
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
                    const SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                        condition: cubit.mandobe!=null,
                        builder: (context) => ConditionalBuilder(
                            condition: cubit.mandobe!.isNotEmpty,
                            builder: (context)=>Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) => Container(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 20, vertical: screenWidth>600?2:5),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200,
                                                width: 1))),
                                    child: InkWell(
                                      onTap: () {
                                      },
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          Text(
                                            "${index+1}- ",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                searchController
                                                    .text.isEmpty
                                                    ? cubit.mandobe![index]
                                                    .name!
                                                    : searchOrder[index]
                                                    .name!,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              )), Expanded(
                                              flex: 4,
                                              child: Text(
                                                searchController
                                                    .text.isEmpty
                                                    ? cubit.mandobe![index]
                                                    .email!
                                                    : searchOrder[index]
                                                    .email!,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                searchController
                                                    .text.isEmpty
                                                    ? cubit.mandobe![index]
                                                    .phone!
                                                    : searchOrder[index]
                                                    .phone!,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                searchController
                                                    .text.isEmpty
                                                    ? cubit.mandobe![index]
                                                    .totalBalance!.toString()
                                                    : searchOrder[index]
                                                    .totalBalance!.toString(),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              )),
                                          // Expanded(
                                          //     flex: 3 ,
                                          //     child: Row(
                                          //       mainAxisAlignment:
                                          //       MainAxisAlignment.start,
                                          //       children: [
                                          //         if(screenWidth>600)
                                          //           InkWell(
                                          //             onTap: () {
                                          //             },
                                          //             child: Container(
                                          //               padding:
                                          //               const EdgeInsets
                                          //                   .symmetric(
                                          //                   horizontal: 5,
                                          //                   vertical: 5),
                                          //               decoration: BoxDecoration(
                                          //                   color:
                                          //                   Colors.white,
                                          //                   boxShadow: const [
                                          //                     BoxShadow(
                                          //                         color: Colors
                                          //                             .grey,
                                          //                         offset:
                                          //                         Offset(
                                          //                             0,
                                          //                             0),
                                          //                         blurRadius:
                                          //                         2)
                                          //                   ],
                                          //                   borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                       5)),
                                          //               child:  Icon(
                                          //                 Icons
                                          //                     .visibility_outlined,
                                          //                 size: screenWidth>600?25:20,
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         if(screenWidth>600)
                                          //           const SizedBox(
                                          //             width: 15,
                                          //           ),
                                          //         if(usermodel!.editMandobe!)
                                          //           InkWell(
                                          //             onTap: () {
                                          //               setState(() {
                                          //                 nameController
                                          //                     .text =
                                          //                 searchController
                                          //                     .text
                                          //                     .isEmpty
                                          //                     ? cubit
                                          //                     .mandobe![
                                          //                 index]
                                          //                     .name!
                                          //                     : searchOrder[
                                          //                 index]
                                          //                     .name!;
                                          //                 phoneController
                                          //                     .text =
                                          //                 searchController
                                          //                     .text
                                          //                     .isEmpty
                                          //                     ? cubit
                                          //                     .mandobe![
                                          //                 index]
                                          //                     .phone!
                                          //                     : searchOrder[
                                          //                 index]
                                          //                     .phone!;
                                          //               });
                                          //               showDialog(
                                          //                   context: context,
                                          //                   builder:
                                          //                       (context) =>
                                          //                       AlertDialog(
                                          //                         title:
                                          //                         const Text(
                                          //                           "تعديل مندوب",
                                          //                           textAlign:
                                          //                           TextAlign.center,
                                          //                         ),
                                          //                         content:
                                          //                         Directionality(
                                          //                           textDirection:
                                          //                           TextDirection.rtl,
                                          //                           child:
                                          //                           Form(
                                          //                             key:
                                          //                             formKey,
                                          //                             child:
                                          //                             Column(
                                          //                               mainAxisSize: MainAxisSize.min,
                                          //                               children: [
                                          //                                 TextFormField(
                                          //                                   controller: nameController,
                                          //                                   validator: (value) {
                                          //                                     if (value!.isEmpty) {
                                          //                                       return "يجب ادخال اسم المندوب لاكمال العمليه";
                                          //                                     }
                                          //                                     return null;
                                          //                                   },
                                          //                                   decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "اسم المندوب"),
                                          //                                 ),
                                          //                                 const SizedBox(
                                          //                                   height: 20,
                                          //                                 ),
                                          //                                 TextFormField(
                                          //                                   controller: phoneController,
                                          //                                   validator: (value) {
                                          //                                     if (value!.isEmpty) {
                                          //                                       return "يجب ادخال رقم الهاتف لاكمال العمليه";
                                          //                                     }
                                          //                                     return null;
                                          //                                   },
                                          //                                   decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "رقم الهاتف"),
                                          //                                 )
                                          //                               ],
                                          //                             ),
                                          //                           ),
                                          //                         ),
                                          //                         actions: [
                                          //                           TextButton(
                                          //                               onPressed: () {
                                          //                                 if (formKey.currentState!.validate()) {
                                          //                                   cubit.updateMandobe(name: nameController.text, phone: phoneController.text, id: searchController.text.isEmpty ? cubit.mandobe![index].uId! : searchOrder[index].uId!, collection: 'mandobe');
                                          //                                   nameController.text = "";
                                          //                                   phoneController.text = "";
                                          //                                   Navigator.pop(context);
                                          //                                 }
                                          //                               },
                                          //                               child: const Text("تعديل"))
                                          //                         ],
                                          //                       ));
                                          //             },
                                          //             child: Container(
                                          //               padding:
                                          //               EdgeInsets
                                          //                   .symmetric(
                                          //                   horizontal: screenWidth>600?5:3,
                                          //                   vertical: screenWidth>600?5:3),
                                          //               decoration: BoxDecoration(
                                          //                   color:
                                          //                   Colors.white,
                                          //                   boxShadow: const [
                                          //                     BoxShadow(
                                          //                         color: Colors
                                          //                             .grey,
                                          //                         offset:
                                          //                         Offset(
                                          //                             0,
                                          //                             0),
                                          //                         blurRadius:
                                          //                         2)
                                          //                   ],
                                          //                   borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(
                                          //                       5)),
                                          //               child:  Icon(
                                          //                 Icons
                                          //                     .mode_edit_outlined,
                                          //                 size: screenWidth>600?25:20,
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         if(usermodel!.editMandobe!)
                                          //           const SizedBox(
                                          //             width: 15,
                                          //           ),
                                          //         if(usermodel!.removeMandobe!)
                                          //           InkWell(
                                          //             onTap: () {
                                          //               dialog(context,
                                          //                   onTap: () {
                                          //                     cubit.deleteMandobe(
                                          //                         id: searchController
                                          //                             .text
                                          //                             .isEmpty
                                          //                             ? cubit
                                          //                             .mandobe![
                                          //                         index]
                                          //                             .uId!
                                          //                             : searchOrder[
                                          //                         index]
                                          //                             .uId!,
                                          //                         collection:
                                          //                         'mandobe');
                                          //                     Navigator.pop(
                                          //                         context);
                                          //                   }, onCancelTap: () {
                                          //                     Navigator.pop(
                                          //                         context);
                                          //                   },
                                          //                   icon: Icons
                                          //                       .delete_forever_rounded,
                                          //                   onPressedTitle:
                                          //                   "نعم",
                                          //                   subTitle:
                                          //                   "هل تريد حذف هذا المندوب",
                                          //                   bigTitle: "",
                                          //                   iconColor:
                                          //                   Colors.red);
                                          //             },
                                          //             child:  Icon(
                                          //               Icons
                                          //                   .delete_forever_rounded,
                                          //               size: screenWidth>600?35:25,
                                          //               color: Colors.red,
                                          //             ),
                                          //           ),
                                          //       ],
                                          //     )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 0,
                                  ),
                                  itemCount: searchController.text.isEmpty
                                      ? cubit.mandobe!.length
                                      : searchOrder.length),
                            ),
                            fallback:  (context)=>Expanded(child: Center(child: Text("لم يتم اضافة اي شركات",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.bold),),))
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()))
                  ],
                ),
              ),
            ),
          );
        });
  }
}

