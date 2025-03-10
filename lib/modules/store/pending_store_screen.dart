import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/model/gift_model.dart';
import 'package:future/modules/store/add_store.dart';
import 'package:future/shared/constant/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/matress_model.dart';
import '../../shared/componnents/componnents.dart';
import '../../shared/widgets/alert_widget.dart';
import '../../shared/widgets/search_widget.dart';

class PendingStoreScreen extends StatefulWidget {
  const PendingStoreScreen({super.key});

  @override
  State<PendingStoreScreen> createState() => _PendingStoreScreenState();
}

class _PendingStoreScreenState extends State<PendingStoreScreen> {
  var nameController = TextEditingController();
  String? webImage;
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

  List<GiftModel> searchOrder = [];
  var searchController = TextEditingController();

  MattressModel? mattressValue;

  String? choose = "اضافة صنف";

  List<String> listChoose = [
    "اضافة صنف",
    if (usermodel!.addStore!) "اضافة للمخزن"
  ];

  GiftModel? giftvalue;
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 800;
    int crossAxisCount = MediaQuery.of(context).size.width ~/ 250;
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {
          if (state is DeleteGiftSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "تم حذف المنتج بنجاح",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 1000),
            ));
          }else  if (state is UpdateGiftSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "تم تعديل المنتج بنجاح",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 1000),
            ));
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          double screenWidth = MediaQuery.of(context).size.width;
          return Scaffold(
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                color: const Color.fromRGBO(232, 243, 255, 1),
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 5)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
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
                                          color:
                                          Color.fromRGBO(155, 145, 255, 1),
                                          width: 2))),
                              child: const Text(
                                "المنتجات",
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: search(
                                  searchController: searchController,
                                  onChange: (search) {
                                    setState(() {
                                      searchOrder = [];
                                      searchOrder = cubit.pendingGift!
                                          .where((element) => element.name!
                                          .contains(searchController.text))
                                          .toList();
                                    });
                                  },
                                  hint: "ابحث بالاسم ..."),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (usermodel!.addStore! && usermodel!.type=="تاجر")
                              InkWell(
                                onTap: () {
                                  navigateTo(
                                      context: context,
                                      widget: const AddStore());
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "اضافة منتج",
                                    style: TextStyle(
                                        color: defaultColor,
                                        fontSize: screenWidth > 600 ? 18 : 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                          child: ConditionalBuilder(
                            condition: cubit.pendingGift != null,
                            builder: (context) => ConditionalBuilder(
                                condition: cubit.pendingGift!.isNotEmpty,
                                builder: (context) => usermodel!.type=="ادمن"||usermodel!.type=="خدمة عملاء"? GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        childAspectRatio:
                                        isMobile ? 1 / 0.9 : 1),
                                    itemCount: cubit.pendingGift!.length,
                                    itemBuilder: (context, index) => Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0, 0),
                                              blurRadius: 5)
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          // الجزء الخاص بالصورة والأيقونة
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              child: Stack(
                                                alignment: AlignmentDirectional
                                                    .topStart,
                                                children: [
                                                  Image.network(
                                                    cubit.pendingGift![index].image!,
                                                    width: double.infinity,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: defaultColor,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(50)),
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    child: Text(
                                                      cubit.pendingGift![index].code!
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    "الاسم : ${cubit.pendingGift![index].name!}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    "الكميه : ${cubit.pendingGift![index].count!}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.green,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                  "السعر : ${cubit.pendingGift![index].price!}"),
                                              Text(
                                                  "الملاحظات  : ${cubit.pendingGift![index].notes!}"),
                                              Text(
                                                  "اسم التاجر  : ${cubit.pendingGift![index].nameAdd!}"),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            spacing: 10,
                                            children: [

                                              Expanded(child: Row(
                                                spacing: 10,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) => alert(
                                                                cubit: cubit,
                                                                context: context,
                                                                formKey: formKey,
                                                                onTap: () {
                                                                  if (formKey.currentState!.validate()) {
                                                                    cubit.addGiftPending(
                                                                        price:cubit.pendingGift![index].price!,
                                                                        name: cubit.pendingGift![index].name!,
                                                                        count: cubit.pendingGift![index].count!,
                                                                        notes: cubit.pendingGift![index].notes!,
                                                                        link: cubit.pendingGift![index].link!,
                                                                        image: cubit.pendingGift![index].image!,
                                                                        id: cubit.pendingGift![index].id!,
                                                                        uid: cubit.pendingGift![index].uid!,
                                                                        nameAdd: cubit.pendingGift![index].nameAdd!,
                                                                        code: cubit.pendingGift![index].code!, type: usermodel!.type!, price2:priceController.text
                                                                    );
                                                                  }
                                                                },
                                                                btn: "اضافة منتج",
                                                                content:  Padding(
                                                                  padding: const  EdgeInsets.symmetric(horizontal: 30.0),
                                                                  child: Form(
                                                                    key: formKey,
                                                                    child: SizedBox(
                                                                      width: 200,
                                                                      child: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        spacing: 10,
                                                                        children: [
                                                                          Text("تكلفة الادارة",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )));
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5, vertical: 5),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                  color: Colors.grey,
                                                                  offset: Offset(0, 0),
                                                                  blurRadius: 2)
                                                            ],
                                                            borderRadius: BorderRadius.circular(5)),
                                                        child: Center(child: const Text("اضافة",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 5, vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                color: Colors.grey,
                                                                offset: Offset(0, 0),
                                                                blurRadius: 2)
                                                          ],
                                                          borderRadius: BorderRadius.circular(5)),
                                                      child: InkWell(
                                                        onTap: () {
                                                          dialog(context, onTap: () {
                                                            cubit.deleteGiftPending(id: cubit.pendingGift![index].id!);
                                                            Navigator.pop(context);
                                                          }, onCancelTap: () {
                                                            Navigator.pop(context);
                                                          },
                                                              icon: Icons.delete_forever_rounded,
                                                              onPressedTitle: "نعم",
                                                              subTitle: "هل تريد حذف هذه المنتج",
                                                              bigTitle: "",
                                                              iconColor: Colors.red);
                                                        },
                                                        child: Center(child: const  Text("حذف",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold))),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                            ],
                                          )
                                        ],
                                      ),
                                    )):GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        childAspectRatio:
                                        isMobile ? 1 / 0.9 : 1),
                                    itemCount: cubit.pendingGift!.length,
                                    itemBuilder: (context, index) => Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0, 0),
                                              blurRadius: 5)
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          // الجزء الخاص بالصورة والأيقونة
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              child: Stack(
                                                alignment: AlignmentDirectional
                                                    .topStart,
                                                children: [
                                                  Image.network(
                                                    cubit.pendingGift![index].image!,
                                                    width: double.infinity,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: defaultColor,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(50)),
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    child: Text(
                                                      cubit.pendingGift![index].code!
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    "الاسم : ${cubit.pendingGift![index].name!}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    "الكميه : ${cubit.pendingGift![index].count!}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.green,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                  "السعر : ${cubit.pendingGift![index].price!}"),
                                              Text(
                                                  "الملاحظات  : ${cubit.pendingGift![index].notes!}"),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            spacing: 10,
                                            children: [
                                              if(cubit.pendingGift![index].link!.isNotEmpty)
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      if(cubit.pendingGift![index].link!.isNotEmpty){
                                                        final Uri link = Uri.parse(cubit.pendingGift![index].link!);
                                                        _launchUrl(link);
                                                      }

                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 5, vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                color: Colors.grey,
                                                                offset: Offset(0, 0),
                                                                blurRadius: 2)
                                                          ],
                                                          borderRadius: BorderRadius.circular(5)),
                                                      child: Center(child: Text("لينك الميديا",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                                    ),
                                                  ),
                                                ),
                                              Expanded(child: Row(
                                                spacing: 10,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          webImage=cubit.pendingGift![index].image!;
                                                          nameController.text = cubit.pendingGift![index].name!;
                                                          priceController.text = cubit.pendingGift![index].price!;
                                                          linkController.text = cubit.pendingGift![index].link!;
                                                          notesController.text = cubit.pendingGift![index].notes!;
                                                          countController.text = cubit.pendingGift![index].count!.toString();
                                                        });
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) => alert(
                                                                cubit: cubit,
                                                                context: context,
                                                                formKey: formKey,
                                                                onTap: () {
                                                                  if (formKey.currentState!.validate()) {
                                                                    cubit.updateStore(
                                                                        price:priceController.text,
                                                                        name: nameController.text,
                                                                        count: int.parse(
                                                                            countController.text),
                                                                        notes: notesController.text,
                                                                        link: linkController.text,
                                                                        file: webImage!,
                                                                        id: cubit.pendingGift![index].id!,
                                                                        uid: cubit.pendingGift![index].uid!,
                                                                        nameAdd: cubit.pendingGift![index].nameAdd!,
                                                                        code: cubit.pendingGift![index].code!, price2: cubit.pendingGift![index].price2!
                                                                    );

                                                                  }
                                                                },
                                                                btn: "تعديل منتج",
                                                                content:  Padding(
                                                                  padding: const  EdgeInsets.symmetric(horizontal: 30.0),
                                                                  child: Form(
                                                                    key: formKey,
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        const SizedBox(
                                                                          height: 15,
                                                                        ),
                                                                        Container(
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
                                                                              child: Image.network(
                                                                                webImage!,
                                                                                width: 150,
                                                                                height: 150,
                                                                                fit: BoxFit.cover,
                                                                              ),),
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
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )));
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 5, vertical: 5),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                  color: Colors.grey,
                                                                  offset: Offset(0, 0),
                                                                  blurRadius: 2)
                                                            ],
                                                            borderRadius: BorderRadius.circular(5)),
                                                        child: const Icon(Icons.mode_edit_outlined,
                                                            size: 25),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 5, vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                color: Colors.grey,
                                                                offset: Offset(0, 0),
                                                                blurRadius: 2)
                                                          ],
                                                          borderRadius: BorderRadius.circular(5)),
                                                      child: InkWell(
                                                        onTap: () {
                                                          dialog(context, onTap: () {
                                                            cubit.deleteGift(id: cubit.pendingGift![index].id!);
                                                            Navigator.pop(context);
                                                          }, onCancelTap: () {
                                                            Navigator.pop(context);
                                                          },
                                                              icon: Icons.delete_forever_rounded,
                                                              onPressedTitle: "نعم",
                                                              subTitle: "هل تريد حذف هذه المنتج",
                                                              bigTitle: "",
                                                              iconColor: Colors.red);
                                                        },
                                                        child: const Icon(Icons.delete_forever_rounded, size: 25,color: Colors.red,),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                                fallback: (context) => Center(
                                  child: Text(
                                    "لم يتم اضافة اي منتج",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                            fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
