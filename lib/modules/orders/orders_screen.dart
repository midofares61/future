import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/shared/componnents/componnents.dart';
import 'package:future/shared/constant/constant.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/order_model.dart';
import '../../shared/widgets/alert_widget.dart';
import '../../shared/widgets/choose_city_button.dart';
import '../../shared/widgets/order_title_widget.dart';
import '../../shared/widgets/order_widget.dart';
import '../../shared/widgets/print_all_order.dart';
import '../../shared/widgets/search_widget.dart';
import '../add_order/add_screen.dart';
import '../add_order_mobile/add_screen_mobile.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var searchController = TextEditingController();
  var notesController = TextEditingController();
  List<OrderModel> searchOrder = [];
  List<String> list = ["4", "5"];
  List<String> listStatus = ["pending", "accept", "refuse", "delay"];
  var formKey = GlobalKey<FormState>();
  var mandobeFormKey = GlobalKey<FormState>();
  var notesFormKey = GlobalKey<FormState>();
  String? statusValue;
  String? mandobeValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {},
        builder: (context, state) {
          double screenWidth = MediaQuery.of(context).size.width;
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
                condition: cubit.orders !=null,
                builder: (context) => Container(
                      color: const Color.fromRGBO(232, 243, 255, 1),
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey, width: 1))),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Color.fromRGBO(
                                                          155, 145, 255, 1),
                                                      width: 2))),
                                          child: const Text(
                                            "الاوردرات",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    155, 145, 255, 1)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                                                  .text) ||
                                                          element.name!.contains(
                                                              searchController
                                                                  .text))
                                                      .toList();
                                                });
                                              },
                                              hint:
                                                  "ابحث بالكود , رقم الهاتف , اسم العميل..."),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                          if(usermodel!.addOrder!)
                                          InkWell(
                                            onTap: () {
                                              // if (screenWidth > 600){
                                              //   navigateTo(
                                              //       context: context,
                                              //       widget: const AddScreen());
                                              // }else{
                                                navigateTo(
                                                    context: context,
                                                    widget: const AddScreenMobile());
                                              // }

                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 13),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius: BorderRadius.circular(5)),
                                              child: Text(
                                                "اضافة اوردر",
                                                style: TextStyle(
                                                    color: defaultColor,
                                                    fontSize: screenWidth>600?18:15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if(usermodel!.type=="ادمن")
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if(usermodel!.type=="ادمن")
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                      Expanded(child: InkWell(
                                        onTap: () {
                                          cubit.exportOrdersToExcel(cubit
                                              .filteredOrders!);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 13),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius: BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            spacing: 10,
                                            children: [
                                              Transform.rotate(
                                                  angle: 3.14/-2,child: Icon(Icons.logout)),
                                              Text(
                                                "تصدير",
                                                style: TextStyle(
                                                    color: defaultColor,
                                                    fontSize: screenWidth>600?18:15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),)  ,
                                      Expanded(child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            cubit.consoleLogs=[];
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog.adaptive(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                title: Align(
                                                  alignment: AlignmentDirectional.topEnd,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: defaultColor, borderRadius: BorderRadius.circular(5)),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        icon:const Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                ),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 500,
                                                      height: 500,
                                                      child: ConditionalBuilder(
                                                          condition: cubit.consoleLogs.isEmpty,
                                                          builder: (context)=>InkWell(
                                                            onTap: (){
                                                              cubit.importOrdersFromExcel();
                                                            },
                                                            child: Center(
                                                              child: Text("اضغط هنا لاستيراد الملف ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                            ),
                                                          ),
                                                          fallback: (context)=>Container(
                                                            color: Colors.grey[200],
                                                            padding: EdgeInsets.all(10),
                                                            child: ListView.builder(
                                                              itemCount: cubit.consoleLogs.length,
                                                              itemBuilder: (context, index) {
                                                                return Align(
                                                                  alignment: Alignment.centerRight, // النص على اليمين
                                                                  child: Text(
                                                                    cubit.consoleLogs[index],
                                                                    style: TextStyle(fontSize: 14, color: Colors.black87),
                                                                    textAlign: TextAlign.right, // محاذاة النص لليمين
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 13),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius: BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            spacing: 10,
                                            children: [
                                          Transform.rotate(
                                          angle: 3.14/2,
                                          child: Icon(Icons.login)),
                                              Text(
                                                "استيراد",
                                                style: TextStyle(
                                                    color: defaultColor,
                                                    fontSize: screenWidth>600?18:15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),)  ,
                                      Expanded(child: InkWell(
                                        onTap: () {
                                          cubit.downloadSheet();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 13),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius: BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            spacing: 10,
                                            children: [
                                          Icon(Icons.download),
                                              Text(
                                                "تنزيل نموذج",
                                                style: TextStyle(
                                                    color: defaultColor,
                                                    fontSize: screenWidth>600?18:15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),)  ,
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
                                              //       value: cubit.filteredOrders!
                                              //           .every((order) => cubit
                                              //           .selectedOrder
                                              //           .contains(order)),
                                              //       onChanged: (val) {
                                              //         if (val == true) {
                                              //           cubit.addSelectedOrderAll(
                                              //               order: cubit
                                              //                   .filteredOrders!);
                                              //         } else {
                                              //           cubit.removeSelectedOrderAll(
                                              //               order: cubit
                                              //                   .filteredOrders!);
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
                                                    .filteredOrders!
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
                                                                    check: false,
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
                                                              .filteredOrders!
                                                              .isNotEmpty,
                                                          builder: (context) =>
                                                              ListView
                                                                  .separated(
                                                                shrinkWrap: true,
                                                                itemBuilder: (context, index) {
                                                                  return OrderWidget(
                                                                    order: cubit.filteredOrders![index],
                                                                    index: index,
                                                                    check: false,
                                                                  );
                                                                },
                                                                separatorBuilder: (context, index) => const SizedBox(height: 2),
                                                                itemCount: cubit.filteredOrders!.length,
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
                                                  //       value: cubit.filteredOrders!
                                                  //           .every((order) => cubit
                                                  //           .selectedOrder
                                                  //           .contains(order)),
                                                  //       onChanged: (val) {
                                                  //         if (val == true) {
                                                  //           cubit.addSelectedOrderAll(
                                                  //               order: cubit
                                                  //                   .filteredOrders!);
                                                  //         } else {
                                                  //           cubit.removeSelectedOrderAll(
                                                  //               order: cubit
                                                  //                   .filteredOrders!);
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
                                                        .filteredOrders!
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
                                                                            check: false,
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
                                                                  .filteredOrders!
                                                                  .isNotEmpty,
                                                              builder: (context) =>
                                                                  ListView
                                                                      .separated(
                                                                    shrinkWrap: true,
                                                                    itemBuilder: (context, index) {
                                                                      return OrderWidget(
                                                                        order: cubit.filteredOrders![index],
                                                                        index: index,
                                                                        check: false,
                                                                      );
                                                                    },
                                                                    separatorBuilder: (context, index) => const SizedBox(height: 2),
                                                                    itemCount: cubit.filteredOrders!.length,
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
                            //footer pagination
                              Container(
                                width: double.infinity,
                                height: 60,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Expanded(
                                      flex:2,
                                        child: _buildYearSelector(cubit,screenWidth)),
                                    Expanded(child: _buildMonthSelector(cubit,screenWidth)),
                                    Expanded(
                                      flex: 4,
                                        child: _buildStatusFilterDropdown(cubit,screenWidth)),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    )),
            // floatingActionButton: Visibility(
            //   visible: screenWidth < 600&&usermodel!.addOrder!,
            //   child: FloatingActionButton(
            //     onPressed: () {
            //       navigateTo(
            //           context: context,
            //           widget: const AddScreenMobile());
            //     },
            //     child: Icon(Icons.add),
            //   ),
            // ),
          );
        });
  }

  Widget _buildYearSelector(AppCubit cubit,double screenWidth) {
    return _buildDropdown(
      width: 80,
      value: cubit.yearValue!,
      items: cubit.uniqueYears,
      onChanged: (value) {
        cubit.yearValue = value!;
        cubit.getfilteredOrders();
      },
    );
  }

  Widget _buildMonthSelector(AppCubit cubit,double screenWidth) {
    return Container(
      width: 60,
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: Container(),
        value: cubit.monthValue!,
        style: TextStyle(color: defaultColor, fontSize: 18),
        onChanged: (value) {
          cubit.changeMonthValue(value!);
        },
        items: cubit.uniqueMonth.map<DropdownMenuItem<String>>(
              (String model) {
            return DropdownMenuItem<String>(
              value: model,
              child: Text(model),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildPrintOrdersButton(AppCubit cubit) {
    return InkWell(
      onTap: () {
        if (cubit.selectedOrder.isNotEmpty) {
          printSelectedOrders(cubit.selectedOrder).then((_) {
            cubit.removeSelectedAll();
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
          color: cubit.selectedOrder.isNotEmpty
              ? defaultColor
              : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Row(
          children: [
            Text(
              "طباعة الاوردرات",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.print, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusFilterDropdown(AppCubit cubit,double screenWidth) {
    if (cubit.showAll) {
      return const SizedBox(width: 200);
    }
    return Container(
      width:screenWidth > 600? 200:120,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
        hint: const Text("اختار الحالة"),
        isExpanded: true,
        underline: Container(),
        value: cubit.statusOrderFilter,
        style: TextStyle(color: defaultColor, fontSize: 18),
        onChanged: cubit.changeStatusOrderFilter,
        items: cubit.listStatusOrder
            .map<DropdownMenuItem<String>>(
              (String model) => DropdownMenuItem<String>(
                value: model,
                child: Text(model),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDropdown({
    required double width,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: width,
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: Container(),
        value: value,
        style: TextStyle(color: defaultColor, fontSize: 18),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>(
          (String model) {
            return DropdownMenuItem<String>(
              value: model,
              child: Text(model),
            );
          },
        ).toList(),
      ),
    );
  }
}
