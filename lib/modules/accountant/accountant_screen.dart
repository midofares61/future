import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/model/order_model.dart';
import 'package:future/shared/widgets/order_widget.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../shared/constant/constant.dart';
import '../../shared/widgets/search_widget.dart';
import '../../shared/widgets/text_widget.dart';
class AccountantScreen extends StatefulWidget {
  const AccountantScreen({super.key});


  @override
  State<AccountantScreen> createState() => _AccountantScreenState();
}

class _AccountantScreenState extends State<AccountantScreen> {
  var searchController = TextEditingController();
  List<OrderModel> searchOrder = [];

  var formKey = GlobalKey<FormState>();
  @override
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {

        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
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
                                "الحسابات",
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
                                    searchController:
                                    searchController,
                                    onChange: (search) {
                                      setState(() {
                                        searchOrder = [];
                                        searchOrder = cubit.orders!
                                            .where((element) =>
                                        element.mandobeName!
                                            .contains(
                                            searchController
                                                .text) ||
                                            element.address!
                                                .contains(
                                                searchController
                                                    .text) ||
                                            element.code!.contains(
                                                searchController
                                                    .text) ||
                                            element.city!.contains(
                                                searchController
                                                    .text)||
                                            element.orderCode!.contains(
                                                searchController
                                                    .text)||
                                            element.phone!.contains(
                                                searchController
                                                    .text)||
                                            element.phoneTow!.contains(
                                                searchController
                                                    .text) ||
                                            element.name!.contains(
                                                searchController
                                                    .text))
                                            .toList();
                                      });
                                    },
                                    hint:
                                    "ابحث بالكود , رقم الهاتف , اسم العميل...")),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      screenWidth > 1555 ?Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 1))),
                              child: Row(
                                children: [
                                  //   Checkbox(
                                  //       value: cubit.filteredOrdersAccountant!
                                  //           .every((order) => cubit
                                  //           .selectedOrder
                                  //           .contains(order)),
                                  //       onChanged: (val) {
                                  //         if (val == true) {
                                  //           cubit.addSelectedOrderAll(
                                  //               order: cubit
                                  //                   .filteredOrdersAccountant!);
                                  //         } else {
                                  //           cubit.removeSelectedOrderAll(
                                  //               order: cubit
                                  //                   .filteredOrdersAccountant!);
                                  //         }
                                  //       }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  OrderTitle(screenWidth)
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: ConditionalBuilder(
                                  condition: cubit.orders!=null,
                                  builder:
                                      (context) => ConditionalBuilder(
                                    condition: cubit
                                        .filteredOrdersAccountant!
                                        .isNotEmpty ||
                                        searchOrder.isNotEmpty,
                                    builder: (context) {
                                      return ConditionalBuilder(
                                          condition: searchController
                                              .text.isNotEmpty,
                                          builder:
                                              (context) =>
                                              ConditionalBuilder(
                                                  condition: searchOrder
                                                      .isNotEmpty,
                                                  builder:
                                                      (context) => ListView.separated(
                                                    shrinkWrap: true,
                                                    itemBuilder: (context, index) {
                                                      return OrderWidget(
                                                        order: searchOrder[index],
                                                        index: index,
                                                      );
                                                    },
                                                    separatorBuilder: (context, index) => const SizedBox(height: 2),
                                                    itemCount: searchOrder.length,
                                                  ),
                                                  fallback:
                                                      (context) =>
                                                  const Center(
                                                    child: Text(
                                                      "No Order In This City",
                                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                    ),
                                                  )),
                                          fallback: (context) =>ConditionalBuilder(
                                              condition: cubit
                                                  .filteredOrdersAccountant!
                                                  .isNotEmpty,
                                              builder: (context) =>
                                                  ListView
                                                      .separated(
                                                    shrinkWrap: true,
                                                    itemBuilder: (context, index) {
                                                      return OrderWidget(
                                                        order: cubit.filteredOrdersAccountant![index],
                                                        index: index,

                                                      );
                                                    },
                                                    separatorBuilder: (context, index) => const SizedBox(height: 2),
                                                    itemCount: cubit.filteredOrdersAccountant!.length,
                                                  ),
                                              fallback: (context) =>
                                              const Center(
                                                child: Text(
                                                  "No Order In This City",
                                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                ),
                                              )));
                                    },
                                    fallback: (context) =>
                                    const Center(
                                      child: Text(
                                        "لا يوجد اوردرات هذا الشهر",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  fallback: (context) => const Center(
                                      child:
                                      CircularProgressIndicator())),
                            ),
                          ],
                        ),
                      )
                          :Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 1555,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200,
                                              width: 1))),
                                  child: Row(
                                    children: [
                                      //   Checkbox(
                                      //       value: cubit.filteredOrdersAccountant!
                                      //           .every((order) => cubit
                                      //           .selectedOrder
                                      //           .contains(order)),
                                      //       onChanged: (val) {
                                      //         if (val == true) {
                                      //           cubit.addSelectedOrderAll(
                                      //               order: cubit
                                      //                   .filteredOrdersAccountant!);
                                      //         } else {
                                      //           cubit.removeSelectedOrderAll(
                                      //               order: cubit
                                      //                   .filteredOrdersAccountant!);
                                      //         }
                                      //       }),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      OrderTitle(screenWidth)
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: ConditionalBuilder(
                                      condition: cubit.orders!=null,
                                      builder:
                                          (context) => ConditionalBuilder(
                                        condition: cubit
                                            .filteredOrdersAccountant!
                                            .isNotEmpty ||
                                            searchOrder.isNotEmpty,
                                        builder: (context) {
                                          return ConditionalBuilder(
                                              condition: searchController
                                                  .text.isNotEmpty,
                                              builder:
                                                  (context) =>
                                                  ConditionalBuilder(
                                                      condition: searchOrder
                                                          .isNotEmpty,
                                                      builder:
                                                          (context) => ListView.separated(
                                                        shrinkWrap: true,
                                                        itemBuilder: (context, index) {
                                                          return OrderWidget(
                                                            order: searchOrder[index],
                                                            index: index,
                                                          );
                                                        },
                                                        separatorBuilder: (context, index) => const SizedBox(height: 2),
                                                        itemCount: searchOrder.length,
                                                      ),
                                                      fallback:
                                                          (context) =>
                                                      const Center(
                                                        child: Text(
                                                          "No Order In This City",
                                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                        ),
                                                      )),
                                              fallback: (context) =>ConditionalBuilder(
                                                  condition: cubit
                                                      .filteredOrdersAccountant!
                                                      .isNotEmpty,
                                                  builder: (context) =>
                                                      ListView
                                                          .separated(
                                                        shrinkWrap: true,
                                                        itemBuilder: (context, index) {
                                                          return OrderWidget(
                                                            order: cubit.filteredOrdersAccountant![index],
                                                            index: index,
                                                          );
                                                        },
                                                        separatorBuilder: (context, index) => const SizedBox(height: 2),
                                                        itemCount: cubit.filteredOrdersAccountant!.length,
                                                      ),
                                                  fallback: (context) =>
                                                  const Center(
                                                    child: Text(
                                                      "No Order In This City",
                                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                    ),
                                                  )));
                                        },
                                        fallback: (context) =>
                                        const Center(
                                          child: Text(
                                            "لا يوجد اوردرات هذا الشهر",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      fallback: (context) => const Center(
                                          child:
                                          CircularProgressIndicator())),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget OrderTitle(double screenWidth)=>Expanded(
    child: Row(
      children: [
        text("التاريخ",4, secondeColor,TextAlign.center),
        text("الاسم", 5, secondeColor,TextAlign.center),
        text("الكود", 4, secondeColor,TextAlign.center),
        text("المدينة", 4, secondeColor,TextAlign.center),
        text("العنوان", 5, secondeColor,TextAlign.center),
        text("الاجمالي", 4, secondeColor,TextAlign.center),
        text("المسوق", 4, secondeColor,TextAlign.center),
      ],
    ),
  );

  Widget OrderWidget({
    required OrderModel order,
    required int index,
}){
    var totalSells;
    var totalAdmin;
    var totalTager;
    for (var gift in order.details!) {
       totalTager = gift.tagerPrice! * gift.count!;
       totalSells = (gift.price! - gift.oldPrice!) * gift.count!;
       totalAdmin = (gift.oldPrice! - gift.tagerPrice!) * gift.count!;
    }
    return ExpansionTile(
      title: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                BorderSide(color: Colors.grey.shade200, width: 1))),
        child: Row(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: text(
                  order.dateTime!.split(' ')[0],
                  4,
                  Colors.grey,TextAlign.center),
            ),
            text(order.name!, 5, Colors.grey,TextAlign.center),
            text(order.orderCode ?? "", 4, Colors.grey,TextAlign.center),
            text(order.city!, 4, Colors.grey,TextAlign.center),
            text(order.address!, 5, Colors.grey,TextAlign.center),
            text(order.total!,  4 ,
                Colors.grey,TextAlign.center),
            text(order.code,  4 ,
                Colors.grey,TextAlign.center),
          ],
        ),
      ),
      children: [
        Column(
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text("اجمالي العمولات",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),),
                    Row(
                      spacing: 10,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color:const Color.fromRGBO(45, 133, 159, 1.0),
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child: Icon(Icons.attach_money,color: Colors.white,size: 18,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text("جنيه",style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w500)),
                            Text("${totalSells+totalAdmin+order.priceCity+totalTager}",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text("اجمالي عمولة الادارة",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),),
                    Row(
                      spacing: 10,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color:Colors.red,
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child: Icon(Icons.attach_money,color: Colors.white,size: 18,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text("جنيه",style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w500)),
                            Text("$totalAdmin",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text("اجمالي عمولة المسوق",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),),
                    Row(
                      spacing: 10,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color:Colors.deepPurple,
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child: Icon(Icons.attach_money,color: Colors.white,size: 18,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text("جنيه",style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w500)),
                            Text("$totalSells",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text("اجمالي عمولة شركة الشحن",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),),
                    Row(
                      spacing: 10,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color:Colors.blueAccent,
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child: Icon(Icons.attach_money,color: Colors.white,size: 18,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text("جنيه",style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w500)),
                            Text("${order.priceCity}",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text("اجمالي عمولة التاجر",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),),
                    Row(
                      spacing: 10,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color:Colors.green,
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child: Icon(Icons.attach_money,color: Colors.white,size: 18,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text("جنيه",style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w500)),
                            Text("$totalTager",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5,)
      ],
    );
  }

}
