import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  Widget dialogContent;
  double? radius;
  double? padTop;
  double? padReight;
  double? padLeft;
  double? padButtom;

  DialogWidget({super.key,
    required this.dialogContent,
    this.radius,
    this.padTop,
    this.padReight,
    this.padLeft,
    this.padButtom,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentTextStyle:const TextStyle(),
      contentPadding: EdgeInsets.only(
        right: padReight != null ? padReight! : 20,
        left: padLeft != null ? padLeft! : 20,
        top: padTop != null ? padTop! : 20,
        bottom: padButtom != null ? padButtom! : 20,
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      scrollable: true,
      elevation: 0.0,
      content: (kIsWeb) ? dialogContent : dialogContent,
    );
  }
}

// class MandobeDetailsWidget extends StatefulWidget {
//   String? name;
//   int? day;
//
//   MandobeDetailsWidget({
//     required this.name,
//     required this.day,
//   });
//
//   @override
//   State<MandobeDetailsWidget> createState() => _MandobeDetailsWidgetState();
// }
//
// class _MandobeDetailsWidgetState extends State<MandobeDetailsWidget> {
//   List<OrderModel>? searchOrder;
//   final FocusNode _firstFocusNode = FocusNode();
//   final FocusNode _secondFocusNode = FocusNode();
//   final FocusNode _thirdFocusNode = FocusNode();
//   final FocusNode _forthFocusNode = FocusNode();
//   final FocusNode _fiveFocusNode = FocusNode();
//
//   var gazController = TextEditingController();
//   var kartahController = TextEditingController();
//   var otherController = TextEditingController();
//   var deliverController = TextEditingController();
//   var deliverAddController = TextEditingController();
//   List<OrderModel>? filteredOrders;
//   void getfilteredOrders() {
//     filteredOrders = AppCubit.get(context).filteredMandobeOrders!.where((order) {
//       DateTime orderDate = DateTime.parse(order.dateTime!);
//       return orderDate.day == widget.day ;
//       // &&order.status == statusValue
//     }).toList();
//   }
//   String? statusValue;
//   var formKey=GlobalKey<FormState>();
//   // List<String> listStatus=["pending","accept","refuse","delay"];
//   @override
//   void initState() {
//     super.initState();
//     getfilteredOrders();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStats>(
//         listener: (context, state) {},
//     builder: (context, state) {
//     AppCubit cubit = AppCubit.get(context);
//     return  Container(
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.grey, blurRadius: 1, offset: Offset(0, 2))
//                 ]),
//             child: Row(
//               children: [
//                 Expanded(
//                     child: Text(
//                   "اجمالي المبلغ لهذا اليوم = ${cubit.filteredMandobeOrders!.fold(0, (sum, order) => sum + int.parse(order.total!))}",
//                   style: TextStyle(
//                       color: defaultColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                 )),
//                 Expanded(
//                     child: Center(
//                         child: InkWell(
//                             onTap: () {
//                               navigateTo(context: context, widget: NoticeMandobeScreen(order: cubit.filteredMandobeOrders!,));
//                             },
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                     color: defaultColor,
//                                     borderRadius: BorderRadius.circular(20)),
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 5),
//                                 child: Text(
//                                   cubit.statusValueMandobe=="refuse"? "اذن مرتجع":"اذن الصرف",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                                 ))))),
//                 Expanded(
//                     child: Text(
//                   "يوم ${widget.day}",
//                   style: TextStyle(
//                       color: defaultColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.end,
//                 )),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ConditionalBuilder(
//               condition: cubit.orders.isNotEmpty,
//               builder: (context) => ConditionalBuilder(
//                     condition: cubit.filteredMandobeOrders!.isNotEmpty,
//                     builder: (context) => Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10.0),
//                       child: ListView.separated(
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) => Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 2),
//                                 decoration: BoxDecoration(
//                                     border: Border(
//                                         bottom: BorderSide(
//                                             color: Colors.grey.shade200,
//                                             width: 1))),
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       "${index + 1}- ",
//                                       style: TextStyle(color: Colors.grey),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           cubit.filteredMandobeOrders![index]
//                                               .details![0]
//                                               .name!,
//                                           style: TextStyle(
//                                               color: Colors.grey,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         )),
//                                     Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           cubit.filteredMandobeOrders![index]
//                                               .dateTime!
//                                               .split(' ')[0]!,
//                                           style: TextStyle(
//                                               color: Colors.grey,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600),
//                                         )),
//                                     Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           cubit.filteredMandobeOrders![index].name!,
//                                           style: TextStyle(
//                                               color: Colors.grey,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600),
//                                         )),
//                                     Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           cubit.filteredMandobeOrders![index].address!,
//                                           style: TextStyle(
//                                               color: Colors.grey,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600),
//                                         )),
//                                     Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           cubit.filteredMandobeOrders![index].mandobeName!,
//                                           style: TextStyle(
//                                               color: Colors.grey,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600),
//                                         )),
//                                     Expanded(
//                                         child: Text(
//                                       cubit.filteredMandobeOrders![index].total!,
//                                       style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600),
//                                     )),
//                                     Expanded(
//                                         child: Text(
//                                       cubit.filteredMandobeOrders![index].code!,
//                                       style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600),
//                                     )),
//                                     Expanded(
//                                         flex: 2,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             InkWell(
//                                               onTap: (){
//                                                 setState(() {
//                                                   statusValue = cubit.filteredMandobeOrders![index].status;
//                                                 });
//                                                 showDialog(context: context, builder: (context)=>StatefulBuilder(builder:(context,setState)=> AlertDialog(
//                                                   title: Text("الحالة",textAlign: TextAlign.center,),
//                                                   content: Directionality(
//                                                     textDirection: TextDirection.rtl,
//                                                     child: Form(
//                                                       key: formKey,
//                                                       child: Column(
//                                                         mainAxisSize: MainAxisSize.min,
//                                                         children: [
//                                                           Container(
//                                                             width: double.infinity,
//                                                             padding: EdgeInsets.symmetric(horizontal: 15),
//                                                             decoration: BoxDecoration(
//                                                                 border:
//                                                                 Border.all(width: 1, color: Colors.grey),
//                                                                 borderRadius: BorderRadius.circular(5)),
//                                                             child: DropdownButton<String>(
//                                                               hint: Text("اختار الحالة"),
//                                                               isExpanded: true,
//                                                               underline: Container(),
//                                                               value: statusValue,
//                                                               style: TextStyle(
//                                                                   color: defaultColor, fontSize: 18),
//                                                               onChanged: (String? value) {
//                                                                 // This is called when the user selects an item.
//                                                                 setState(() {
//                                                                   statusValue = value!;
//                                                                 });
//                                                               },
//                                                               items: cubit.listStatus.map<DropdownMenuItem<String>>(
//                                                                       (String model) {
//                                                                     return DropdownMenuItem<String>(
//                                                                       value: model,
//                                                                       child: Text(model),
//                                                                     );
//                                                                   }).toList(),
//                                                             ),
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   actions: [
//                                                     TextButton(onPressed: (){
//                                                       if(formKey.currentState!.validate()){
//                                                         cubit.updateStatusMandobe(status: statusValue!, id: cubit.filteredMandobeOrders![index].id!, list: cubit.filteredMandobeOrders![index].details!, name: widget.name!, lastStatus: cubit.filteredMandobeOrders![index].status!);
//                                                         // FirebaseFirestore.instance
//                                                         //     .collection("orders").doc(searchController.text.isEmpty?cubit.cubit.filteredMandobeOrders![index].id:searchOrder[index].id).update({"status":"$statusValue"});
//                                                         Navigator.pop(context);
//                                                       }
//                                                     }, child: Text("تعديل"))
//                                                   ],
//                                                 )));
//                                               },
//                                               child: Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 15, vertical: 5),
//                                                 decoration: BoxDecoration(
//                                                     color: cubit.filteredMandobeOrders![index]
//                                                                 .status ==
//                                                             "pending"
//                                                         ? Colors.deepOrangeAccent
//                                                             .withOpacity(0.1)
//                                                         : cubit.filteredMandobeOrders![index]
//                                                                     .status ==
//                                                                 "accept"
//                                                             ? Colors.green
//                                                             : cubit.filteredMandobeOrders![
//                                                                             index]
//                                                                         .status ==
//                                                                     "refuse"
//                                                                 ? Colors.red
//                                                                 : defaultColor
//                                                                     .withOpacity(
//                                                                         0.8),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10)),
//                                                 child: Text(
//                                                   cubit.filteredMandobeOrders![index].status!,
//                                                   style: TextStyle(
//                                                       color: cubit.filteredMandobeOrders![
//                                                                       index]
//                                                                   .status ==
//                                                               "pending"
//                                                           ? Colors
//                                                               .deepOrangeAccent
//                                                           : Colors.white,
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         )),
//                                     Expanded(
//                                         flex: 2,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             InkWell(
//                                               onTap: () {
//                                                 navigateTo(
//                                                     context: context,
//                                                     widget: Printer(
//                                                       order: cubit.filteredMandobeOrders![
//                                                           index],
//                                                     ));
//                                               },
//                                               child: Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 5, vertical: 5),
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     boxShadow: [
//                                                       BoxShadow(
//                                                           color: Colors.grey,
//                                                           offset: Offset(0, 0),
//                                                           blurRadius: 2)
//                                                     ],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5)),
//                                                 child: Icon(
//                                                   Icons.visibility_outlined,
//                                                   size: 20,
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: 15,
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 navigateTo(
//                                                     context: context,
//                                                     widget: EditOrderScreen(
//                                                       order: cubit.filteredMandobeOrders![
//                                                           index],
//                                                     ));
//                                               },
//                                               child: Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 5, vertical: 5),
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     boxShadow: [
//                                                       BoxShadow(
//                                                           color: Colors.grey,
//                                                           offset: Offset(0, 0),
//                                                           blurRadius: 2)
//                                                     ],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5)),
//                                                 child: Icon(
//                                                   Icons.mode_edit_outlined,
//                                                   size: 20,
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: 10,
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 navigateTo(
//                                                     context: context,
//                                                     widget: Printer(
//                                                       order: cubit.filteredMandobeOrders![
//                                                           index],
//                                                     ));
//                                               },
//                                               child: Icon(
//                                                 Icons.more_vert,
//                                                 size: 20,
//                                               ),
//                                             ),
//                                           ],
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                           separatorBuilder: (context, index) => SizedBox(
//                                 height: 2,
//                               ),
//                           itemCount: cubit.filteredMandobeOrders!.where((order){
//                             DateTime orderDate =
//                             DateTime.parse(order.dateTime!);
//                             return orderDate.day ==
//                                 widget.day;
//                           }).length),
//                     ),
//                     fallback: (context) => Center(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 28.0),
//                         child: Text(
//                           "No Order In This Day",
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//               fallback: (context) => Center(child: CircularProgressIndicator()))
//         ],
//       ),
//     );});
//   }
// }
