import 'package:flutter/material.dart';
import 'package:future/model/order_model.dart';
import 'package:future/shared/componnents/componnents.dart';

import '../order_mandobe/order_mandobe_screen.dart';

class FatoraScreen extends StatefulWidget {
  FatoraScreen({super.key, required this.order});
  OrderModel order;
  @override
  State<FatoraScreen> createState() => _FatoraScreenState();
}

class _FatoraScreenState extends State<FatoraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Details"),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding:const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "شركة MTM",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "للمنتجات الحصرية",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "اسم العميل : ${widget.order.name}",
                          style:const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          "كود رقم : ${widget.order.code}",
                          style:const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "العنوان : ${widget.order.address}",
                          style:const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          "تاريخ التحرير : ${widget.order.dateTime.toString().split(" ")[0]}",
                          style:const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "رقم الهاتف : ${widget.order.phone}",
                      style:
                         const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.grey.shade300),
                        padding:
                           const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child:const  Row(
                          children: [
                            Expanded(
                                child: Text(
                              "الكميه",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )),
                            Expanded(
                                flex: 5,
                                child: Text("اسم المنتج",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                            Expanded(
                                child: Text("السعر",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                          ],
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Table(
                        children: [
                          ...List.generate(widget.order.details!.length, (index) => TableRow(
                            children: [
                              Container(
                                width: double.infinity,
                                padding:
                               const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                          "${widget.order.details![index].count}",
                                          style:
                                         const TextStyle(fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                            " ${widget.order.details![index].name}",
                                            style:const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center)),
                                    Expanded(
                                        child: Text(
                                            "${widget.order.details![index].code}",
                                            style:const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center)),
                                  ],
                                ),
                              )
                            ]
                          )),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Text(
                          "الاجمالي : ${widget.order.total}",
                          style:const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        const Text(
                          "توقيع العميل : ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 200,)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "اسم المندوب : ${widget.order.mandobeName ?? ""}",
                      style:const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40,),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10,),
                    const Row(
                      children: [
                        Text("phone: 01127502002"),
                         Spacer(),
                        Text("Powred By Mohamed Fares"),
                      ],
                    )
                  ],
                ),
              )),
              Expanded(
                  child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      navigateTo(context: context, widget: Printer(order: widget.order,));
                    },
                    child:const Text("print"),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
  // Future<Uint8List> _printDoc(OrderModel order,PdfPageFormat format)async{
  //   print("done");
  //   final doc = pw.Document();
  //   final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  //   print("done");
  //   doc.addPage(pw.Page(
  //       pageFormat: format,
  //       build: (pw.Context context) {
  //         print("done");
  //         return buildPrintDoc(order);
  //       })); // Page
  //   return pdf.save();
  // }
}

