import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/cubit/cubit.dart';
import 'package:future/model/user_model.dart';
import 'package:future/shared/widgets/text_widget.dart';
import '../../cubit/stats.dart';
import '../../model/mandobe_model.dart';
import '../../model/order_model.dart';
import '../../modules/edit_order_mobile/edit_order_mobile.dart';
import '../../modules/order_mandobe/order_mandobe_screen.dart';
import '../../modules/orders/order_details_screen.dart';
import '../componnents/componnents.dart';
import '../constant/constant.dart';

class OrderWidget extends StatefulWidget {
  OrderWidget(
      {super.key,
      required this.order,
      required this.index,
      required this.check});
  OrderModel order;
  int index;
  bool check;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  var searchController = TextEditingController();
  var notesController = TextEditingController();
  List<OrderModel> searchOrder = [];
  List<String> list = ["4", "5"];
  List<String> listStatus = ["مع شركة الشحن", "تم تسليم العميل", "مرتجع", "في المكتب"];
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
          AppCubit cubit = AppCubit.get(context);
          double screenWidth = MediaQuery.of(context).size.width;
          return InkWell(
            onTap: () {
              // if (screenWidth < 600)
              // navigateTo(context: context, widget: OrderDetailsScreen(order: widget.order,));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 10, vertical: screenWidth > 600 ? 2 : 5),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade200, width: 1))),
              child: Row(
                children: [
                  if(screenWidth>600)
                  if (widget.check)
                    Checkbox(
                        value: cubit.selectedOrder.contains(widget.order),
                        onChanged: (val) {
                          if (val == true) {
                            cubit.addSelectedOrder(order: widget.order);
                          } else {
                            cubit.removeSelectedOrder(id: widget.order.id!);
                          }
                        }),
                  if (widget.check) const SizedBox(width: 5),
                  Text("${widget.index + 1}- ",
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(width: 5),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: text(
                        screenWidth > 600
                            ? widget.order.dateTime!.split(' ')[0]
                            : widget.order.dateTime!
                                    .split(' ')[0]
                                    .split("-")[1] +
                                "-" +
                                widget.order.dateTime!
                                    .split(' ')[0]
                                    .split("-")[2],
                        screenWidth > 600 ? 5 : 4,
                        Colors.grey,TextAlign.center),
                  ),
                  text(widget.order.name!, 5, Colors.grey,TextAlign.center),
                  text(widget.order.orderCode ?? "", 4, Colors.grey,TextAlign.center),
                  text(widget.order.city!, 4, Colors.grey,TextAlign.center),
                  text(widget.order.address!, 5, Colors.grey,TextAlign.center),
                  Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (usermodel!.editOrder!) {
                                setState(() {
                                  mandobeValue = widget.order.mandobeName == ""
                                      ? null
                                      : widget.order.mandobeName;
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                        builder: (context, setState) =>
                                            AlertDialog(
                                              title: const Text("تعديل شركة الشحن",
                                                  textAlign: TextAlign.center),
                                              content: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Form(
                                                  key: mandobeFormKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 15),
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
                                                          hint: const Text(
                                                              "اختار شركة الشحن"),
                                                          isExpanded: true,
                                                          underline:
                                                              Container(),
                                                          value: mandobeValue,
                                                          style: TextStyle(
                                                              color:
                                                                  defaultColor,
                                                              fontSize: 18),
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              mandobeValue =
                                                                  value!;
                                                            });
                                                          },
                                                          items: cubit.mandobe!.map<
                                                                  DropdownMenuItem<
                                                                      String>>(
                                                              (UserModel
                                                                  model) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  model.name!,
                                                              child: Text(
                                                                  model.name!),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actionsAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      if (mandobeFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        cubit
                                                            .removeMandobeOrder(
                                                          mandobe: "",
                                                          id: widget.order.id!,
                                                        );
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text(
                                                        "حذف شركة الشحن")),
                                                TextButton(
                                                    onPressed: () {
                                                      if (mandobeFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        cubit.updateMandobeOrder(
                                                            mandobe:
                                                                mandobeValue!,
                                                            id: widget
                                                                .order.id!,
                                                            lastMandobe: widget
                                                                .order
                                                                .mandobeName!,
                                                            lastStatus: widget
                                                                .order.status!,
                                                            list: widget.order
                                                                .details!);
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text("تعديل"))
                                              ],
                                            )));
                              }
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                widget.order.mandobeName == ""
                                    ? "اختار شركة الشحن"
                                    : widget.order.mandobeName!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    width: screenWidth > 600 ? 20 : 10,
                  ),
                  Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: () {
                            setState(() {
                              notesController.text = widget.order.notes ?? "";
                            });
                            showDialog(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                    builder: (context, setState) => AlertDialog(
                                          title: const Text("ملاحظات",
                                              textAlign: TextAlign.center),
                                          content: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Form(
                                              key: notesFormKey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  usermodel!.addComment!?
                                                  TextFormField(
                                                    controller: notesController,
                                                    autofocus: true,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "يجب ادخال الملاحظة لاكمال المهمه";
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      isDense: true,
                                                      labelText: 'ملاحظات',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ):Text(widget.order.notes?? "لا يوجد ملاحظات",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  if(usermodel!.addComment!){
                                                    if (notesFormKey.currentState!
                                                        .validate()) {
                                                      cubit.updateNotesOrder(
                                                        notes:
                                                        notesController.text,
                                                        id: widget.order.id!,
                                                      );
                                                      Navigator.pop(context);
                                                    }
                                                  }else{
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child:  Text(usermodel!.addComment!?"تعديل":"حسنا"))
                                          ],
                                        )));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              color: widget.order.notes == null
                                  ? Colors.grey.withOpacity(0.2)
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            widget.order.notes ?? "لا يوجد ملاحظات",
                            style: TextStyle(
                                color: widget.order.notes == null
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: screenWidth > 600 ? 20 : 10,
                  ),
                  text(widget.order.total!, screenWidth > 600 ? 4 : 3,
                      Colors.grey,TextAlign.center),
                  text(widget.order.code, screenWidth > 600 ? 4 : 3,
                      Colors.grey,TextAlign.center),
                  Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (usermodel!.changeStatus!) {
                                setState(() {
                                  statusValue = widget.order.status!;
                                });
                              }
                              if (usermodel!.changeStatus!) {
                                showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                        builder: (context, setState) =>
                                            AlertDialog(
                                              title: const Text("الحالة",
                                                  textAlign: TextAlign.center),
                                              content: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Form(
                                                  key: formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 15),
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
                                                          hint: const Text(
                                                              "اختار الحالة"),
                                                          isExpanded: true,
                                                          underline:
                                                              Container(),
                                                          value: statusValue,
                                                          style: TextStyle(
                                                              color:
                                                                  defaultColor,
                                                              fontSize: 18),
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              statusValue =
                                                                  value!;
                                                            });
                                                          },
                                                          items: listStatus.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              model) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: model,
                                                              child:
                                                                  Text(model),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        cubit.updateStatus(
                                                            status:
                                                                statusValue!,
                                                            id: widget
                                                                .order.id!,
                                                            list: widget
                                                                .order.details!,
                                                            lastStatus: widget
                                                                .order.status!);
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text("تعديل"))
                                              ],
                                            )));
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  color: widget.order.status == "مع شركة الشحن"
                                      ? Colors.deepOrangeAccent.withOpacity(0.1)
                                      : widget.order.status == "تم تسليم العميل"
                                          ? Colors.green
                                          : widget.order.status == "مرتجع"
                                              ? Colors.red
                                              : defaultColor.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                widget.order.status!,
                                style: TextStyle(
                                    color: widget.order.status == "مع شركة الشحن"
                                        ? Colors.deepOrangeAccent
                                        : Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                navigateTo(
                                    context: context,
                                    widget: Printer(order: widget.order));
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
                                child: const Icon(Icons.visibility_outlined,
                                    size: 25),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          if (usermodel!.editOrder!)
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  navigateTo(
                                      context: context,
                                      widget: EditScreenMobile(
                                              order: widget.order));
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
                          if (usermodel!.editOrder!) const SizedBox(width: 10),
                          if (usermodel!.removeOrder!)
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
                                      cubit.deleteOrder(id: widget.order.id!);
                                      Navigator.pop(context);
                                    }, onCancelTap: () {
                                      Navigator.pop(context);
                                    },
                                        icon: Icons.delete_forever_rounded,
                                        onPressedTitle: "نعم",
                                        subTitle: "هل تريد حذف هذه الفاتورة",
                                        bigTitle: "",
                                        iconColor: Colors.red);
                                  },
                                  child: const Icon(Icons.delete_forever_rounded, size: 25,color: Colors.red,),
                                ),
                              ),
                            ),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }
}
