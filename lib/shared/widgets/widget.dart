import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../model/order_model.dart';

buildPrintDoc(OrderModel order, font) => pw.Directionality(
    textDirection: pw.TextDirection.rtl,
    child: pw.Column(children: [
      pw.Expanded(
          child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: pw.BoxDecoration(
            border: pw.Border.all(
                color: const PdfColor(0.1, 0.1, 0.1, 1), width: 1),
            borderRadius: pw.BorderRadius.circular(5)),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "The Future",
              style: pw.TextStyle(
                  fontSize: 15, fontWeight: pw.FontWeight.bold, font: font),
            ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table(
                  border: pw.TableBorder.all(
                      color: const PdfColor(0.1, 0.1, 0.1, 1)),
                  children: [
                    pw.TableRow(children: [
                      pw.Expanded(
                          flex: 4,
                          child: pw.Padding(
                            padding:
                            const pw.EdgeInsets.symmetric(horizontal: 10),
                            child: pw.Text("${order.name}",
                                style: pw.TextStyle(font: font,fontSize: 8)),
                          )),
                      pw.Expanded(
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                            child: pw.Text("اسم العميل",
                                style: pw.TextStyle(font: font,fontSize: 8),
                                textAlign: pw.TextAlign.center),
                          )),
                    ]),
                  ]),
            ),
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table(
                  border: pw.TableBorder.all(
                      color: const PdfColor(0.1, 0.1, 0.1, 1)),
                  children: [
                    pw.TableRow(children: [
                      pw.Expanded(
                          flex: 2,
                          child: pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 10),
                            child: pw.Text("${order.address}",
                                style: pw.TextStyle(font: font,fontSize: 8)),
                          )),
                      pw.Expanded(
                          child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Text("العنوان",
                            style: pw.TextStyle(font: font,fontSize: 8),
                            textAlign: pw.TextAlign.center),
                      )),
                      pw.Expanded(
                          child: pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(horizontal: 10),
                              child: pw.Text(order.dateTime!.split(' ')[0],
                                  style: pw.TextStyle(font: font, fontSize: 8),
                                  textAlign: pw.TextAlign.center))),
                      pw.Expanded(
                          child: pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(horizontal: 10),
                              child: pw.Text("تاريخ الاوردر",
                                  style: pw.TextStyle(font: font,fontSize: 8),
                                  textAlign: pw.TextAlign.center))),
                    ]),
                  ]),
            ),
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table(
                  border: pw.TableBorder.all(
                      color: const PdfColor(0.1, 0.1, 0.1, 1)),
                  children: [
                    pw.TableRow(children: [
                      pw.Expanded(
                          flex: 2,
                          child: pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 10),
                            child: pw.Text("${order.phoneTow}",
                                style: pw.TextStyle(font: font, fontSize: 8),
                                textAlign: pw.TextAlign.center),
                          )),
                      pw.Expanded(
                          child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Text("رقم اخر",
                            style: pw.TextStyle(font: font, fontSize: 8),
                            textAlign: pw.TextAlign.center),
                      )),
                      pw.Expanded(
                          flex: 2,
                          child: pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(horizontal: 10),
                              child: pw.Text("${order.phone}",
                                  style: pw.TextStyle(font: font, fontSize: 8),
                                  textAlign: pw.TextAlign.center))),
                      pw.Expanded(
                          child: pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(horizontal: 10),
                              child: pw.Text("رقم الهاتف",
                                  style: pw.TextStyle(font: font, fontSize: 8),
                                  textAlign: pw.TextAlign.center))),
                    ]),
                  ]),
            ),
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table(
                  border: pw.TableBorder.all(
                      color: const PdfColor(0.1, 0.1, 0.1, 1)),
                  children: [
                    pw.TableRow(children: [
                      pw.Expanded(
                          flex: 2,
                          child: pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 10),
                            child: pw.Text("ملاحظات",
                                style: pw.TextStyle(font: font, fontSize: 8),
                                textAlign: pw.TextAlign.center),
                          )),
                      pw.Expanded(
                          child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Text("السعر",
                            style: pw.TextStyle(font: font, fontSize: 8),
                            textAlign: pw.TextAlign.center),
                      )),
                      pw.Expanded(
                          flex: 3,
                          child: pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(horizontal: 10),
                              child: pw.Text("اسم المنتج",
                                  style: pw.TextStyle(font: font, fontSize: 8),
                                  textAlign: pw.TextAlign.center))),
                      pw.Expanded(
                          child: pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(horizontal: 10),
                              child: pw.Text("الكميه",
                                  style: pw.TextStyle(font: font, fontSize: 8),
                                  textAlign: pw.TextAlign.center))),
                    ]),
                    ...List.generate(
                        order.details!.length,
                        (index) => pw.TableRow(children: [
                              pw.Expanded(
                                  flex: 2,
                                  child: pw.Padding(
                                    padding: const pw.EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: pw.Text(
                                        "${order.details![index].details}",
                                        style: pw.TextStyle(font: font, fontSize: 8),
                                        textAlign: pw.TextAlign.center),
                                  )),
                              pw.Expanded(
                                  child: pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: pw.Text("${order.details![index].price}",
                                    style: pw.TextStyle(font: font, fontSize: 8),
                                    textAlign: pw.TextAlign.center),
                              )),
                              pw.Expanded(
                                  flex: 3,
                                  child: pw.Padding(
                                      padding: const pw.EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: pw.Text(
                                          "${order.details![index].name}",
                                          style: pw.TextStyle(font: font, fontSize: 8),
                                          textAlign: pw.TextAlign.center))),
                              pw.Expanded(
                                  child: pw.Padding(
                                      padding: const pw.EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: pw.Text(
                                          "${order.details![index].count}",
                                          style: pw.TextStyle(font: font, fontSize: 8),
                                          textAlign: pw.TextAlign.center))),
                            ])),
                  ]),
            ),
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table(
                  border: pw.TableBorder.symmetric(
                      outside: const pw.BorderSide(
                          color: PdfColor(0.1, 0.1, 0.1, 1))),
                  children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Text("اجمالي الفاتورة   /     ${order.total}",
                            style: pw.TextStyle(font: font, fontSize: 8),
                            textAlign: pw.TextAlign.left),
                      ),
                      pw.Spacer(),
                      pw.Padding(
                          padding:
                              const pw.EdgeInsets.symmetric(horizontal: 10),
                          child: pw.Text(
                            "اسم المندوب    /     ${order.mandobeName ?? ""}",
                            style: pw.TextStyle(font: font, fontSize: 8),
                          )),
                    ]),
                  ]),
            ),
          ],
        ),
      )),
    ]));

buildPrintNoticeDoc(List<Map<String, dynamic>> sortedItems, font, String name) =>
    pw.Directionality(
        textDirection: pw.TextDirection.rtl,
        child: pw.Column(children: [
          pw.Expanded(
              child: pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  child: pw.Column(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                      child: pw.Row(children: [
                        pw.Text("اذن صرف", style: pw.TextStyle(font: font)),
                        pw.Spacer(),
                        pw.Text("اسم المندوب: $name",
                            style: pw.TextStyle(font: font)),
                      ]),
                    ),
                    pw.SizedBox(height: 15),
                    pw.Table(
                        border: pw.TableBorder.all(
                            color: const PdfColor(0.1, 0.1, 0.1, 1), width: 1),
                        children: [
                          pw.TableRow(children: [
                            pw.Expanded(
                              child: pw.Text("ملاحظات",
                                  style: pw.TextStyle(font: font),
                                  textAlign: pw.TextAlign.center),
                            ),
                            pw.Expanded(
                              child: pw.Text("العدد",
                                  style: pw.TextStyle(font: font),
                                  textAlign: pw.TextAlign.center),
                            ),
                            pw.Expanded(
                              child: pw.Text("اسم الصنف",
                                  style: pw.TextStyle(font: font),
                                  textAlign: pw.TextAlign.center),
                            ),
                          ]),
                        ]),
                    ...List.generate(
                        sortedItems.length,
                            (index) => pw.Table(
                            border: pw.TableBorder.all(
                                color: const PdfColor(0.1, 0.1, 0.1, 1),
                                width: 1),
                            children: [
                              pw.TableRow(children: [
                                pw.Expanded(
                                  child: pw.Text(
                                      "${sortedItems[index]["notes"]}",
                                      style: pw.TextStyle(font: font),
                                      textAlign: pw.TextAlign.center),
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                      "${sortedItems[index]["count"]}",
                                      style: pw.TextStyle(font: font),
                                      textAlign: pw.TextAlign.center),
                                ),
                                pw.Expanded(
                                  child: pw.Padding(
                                      padding:
                                      const pw.EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: pw.Text(
                                          "${sortedItems[index]["item"]}",
                                          style: pw.TextStyle(font: font),
                                          textAlign: pw.TextAlign.center)),
                                )
                              ]),
                            ])),
                    // pw.SizedBox(height: 50),
                    // pw.Text("عدد الاصناف", style: pw.TextStyle(font: font)),
                    // pw.SizedBox(height: 10),
                    // pw.Table(
                    //     border: pw.TableBorder.all(
                    //         color: const PdfColor(0.1, 0.1, 0.1, 1), width: 1),
                    //     children: [
                    //       pw.TableRow(children: [
                    //         pw.Expanded(
                    //           child: pw.Text("العدد",
                    //               style: pw.TextStyle(font: font),
                    //               textAlign: pw.TextAlign.center),
                    //         ),
                    //         pw.Expanded(
                    //           child: pw.Text("اسم الصنف",
                    //               style: pw.TextStyle(font: font),
                    //               textAlign: pw.TextAlign.center),
                    //         )
                    //       ]),
                    //     ]),
                    // ...List.generate(
                    //     sortedItemCounts.length,
                    //     (index) => pw.Table(
                    //             border: pw.TableBorder.all(
                    //                 color: const PdfColor(0.1, 0.1, 0.1, 1),
                    //                 width: 1),
                    //             children: [
                    //               pw.TableRow(children: [
                    //                 pw.Expanded(
                    //                   child: pw.Text(
                    //                       "${sortedItemCounts[index]["count"]}",
                    //                       style: pw.TextStyle(font: font),
                    //                       textAlign: pw.TextAlign.center),
                    //                 ),
                    //                 pw.Expanded(
                    //                   child: pw.Padding(
                    //                       padding:
                    //                           const pw.EdgeInsets.symmetric(
                    //                               horizontal: 5),
                    //                       child: pw.Text(
                    //                           "${sortedItemCounts[index]["item"]}",
                    //                           style: pw.TextStyle(font: font),
                    //                           textAlign: pw.TextAlign.center)),
                    //                 )
                    //               ]),
                    //             ]))
                  ]))),
        ]));
