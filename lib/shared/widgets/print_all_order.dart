import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../model/order_model.dart';

Future<void> printSelectedOrders(List<OrderModel> selectedOrders) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
  final fontData = await rootBundle.load('asset/font/Cairo-Medium.ttf');
  final font = pw.Font.ttf(fontData);
  for (var order in selectedOrders) {
    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(15),
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(children: [
              pw.Expanded(
                  child: pw.Container(
                    padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColor(0.1, 0.1, 0.1, 1), width: 1),
                        borderRadius: pw.BorderRadius.circular(5)),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "شركة المراتب",
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold, font: font),
                        ),
                        pw.Text(
                          "للمنتجات العصرية",
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold, font: font),
                        ),
                        pw.SizedBox(
                          height: 10,
                        ),
                        pw.Directionality(
                          textDirection: pw.TextDirection.rtl,
                          child: pw.Table(
                              border: pw.TableBorder.all(color: PdfColor(0.1, 0.1, 0.1, 1)),
                              children: [
                                pw.TableRow(children: [
                                  pw.Expanded(
                                      flex: 4,
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("${order.name}",
                                            style: pw.TextStyle(font: font)),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("اسم العميل",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("${order.code}",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("كود رقم",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                ]),
                                pw.TableRow(children: [
                                  pw.Expanded(
                                      flex: 4,
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("${order.address}",
                                            style: pw.TextStyle(font: font)),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("العنوان",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("${order.dateTime!.split(' ')[0]}",
                                              style: pw.TextStyle(font: font, fontSize: 11),
                                              textAlign: pw.TextAlign.center))),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("تاريخ التحرير",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                ]),
                              ]),
                        ),
                        pw.Directionality(
                          textDirection: pw.TextDirection.rtl,
                          child: pw.Table(
                              border: pw.TableBorder.all(color: PdfColor(0.1, 0.1, 0.1, 1)),
                              children: [
                                pw.TableRow(children: [
                                  pw.Expanded(
                                      flex: 3,
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("${order.phoneTow}",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("رقم اخر",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("${order.phone}",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("رقم الهاتف",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                ]),
                              ]),
                        ),
                        pw.Directionality(
                          textDirection: pw.TextDirection.rtl,
                          child: pw.Table(
                              border: pw.TableBorder.all(color: PdfColor(0.1, 0.1, 0.1, 1)),
                              children: [
                                pw.TableRow(children: [
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("ملاحظات",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("السعر",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      flex: 3,
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("اسم المنتج",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("الكميه",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                ]),
                                ...List.generate(
                                    order.details!.length,
                                        (index) => pw.TableRow(children: [
                                      pw.Expanded(
                                          flex: 2,
                                          child: pw.Padding(
                                            padding:
                                            pw.EdgeInsets.symmetric(horizontal: 10),
                                            child: pw.Text(
                                                "${order.details![index].details}",
                                                style: pw.TextStyle(font: font),
                                                textAlign: pw.TextAlign.center),
                                          )),
                                      pw.Expanded(
                                          child: pw.Padding(
                                            padding:
                                            pw.EdgeInsets.symmetric(horizontal: 10),
                                            child: pw.Text("0",
                                                style: pw.TextStyle(font: font),
                                                textAlign: pw.TextAlign.center),
                                          )),
                                      pw.Expanded(
                                          flex: 3,
                                          child: pw.Padding(
                                              padding: pw.EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: pw.Text(
                                                  "${order.details![index].name}",
                                                  style: pw.TextStyle(font: font),
                                                  textAlign: pw.TextAlign.center))),
                                      pw.Expanded(
                                          child: pw.Padding(
                                              padding: pw.EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: pw.Text(
                                                  "${order.details![index].count}",
                                                  style: pw.TextStyle(font: font),
                                                  textAlign: pw.TextAlign.center))),
                                    ])),
                              ]),
                        ),
                        pw.Directionality(
                          textDirection: pw.TextDirection.rtl,
                          child: pw.Table(
                              border: pw.TableBorder.symmetric(
                                  outside:
                                  pw.BorderSide(color: PdfColor(0.1, 0.1, 0.1, 1))),
                              children: [
                                pw.TableRow(children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                    child: pw.Text("اجمالي الفاتورة   /     ${order.total}",
                                        style: pw.TextStyle(font: font),
                                        textAlign: pw.TextAlign.left),
                                  ),
                                  pw.Spacer(),
                                  pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                      child: pw.Text(
                                        "اسم المندوب    /     ${order.mandobeName == null ? "" : order.mandobeName}",
                                        style: pw.TextStyle(font: font),
                                      )),
                                ]),
                              ]),
                        ),
                      ],
                    ),
                  )),
              pw.SizedBox(height: 40),
              pw.Expanded(
                  child: pw.Container(
                    padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColor(0.1, 0.1, 0.1, 1), width: 1),
                        borderRadius: pw.BorderRadius.circular(5)),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "شركة المراتب",
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold, font: font),
                        ),
                        pw.Text(
                          "للمنتجات العصرية",
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold, font: font),
                        ),
                        pw.SizedBox(
                          height: 10,
                        ),
                        pw.Directionality(
                          textDirection: pw.TextDirection.rtl,
                          child: pw.Table(
                              border: pw.TableBorder.all(color: PdfColor(0.1, 0.1, 0.1, 1)),
                              children: [
                                pw.TableRow(children: [
                                  pw.Expanded(
                                      flex: 4,
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("${order.name}",
                                            style: pw.TextStyle(font: font)),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("اسم العميل",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("${order.code}",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("كود رقم",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                ]),
                                pw.TableRow(children: [
                                  pw.Expanded(
                                      flex: 4,
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("${order.address}",
                                            style: pw.TextStyle(font: font)),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("العنوان",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("${order.dateTime!.split(' ')[0]}",
                                              style: pw.TextStyle(font: font, fontSize: 11),
                                              textAlign: pw.TextAlign.center))),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("تاريخ التحرير",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                ]),
                              ]),
                        ),
                        pw.Directionality(
                          textDirection: pw.TextDirection.rtl,
                          child: pw.Table(
                              border: pw.TableBorder.all(color: PdfColor(0.1, 0.1, 0.1, 1)),
                              children: [
                                pw.TableRow(children: [
                                  pw.Expanded(
                                      flex: 3,
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("${order.phoneTow}",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("رقم اخر",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("${order.phone}",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("رقم الهاتف",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                ]),
                              ]),
                        ),
                        pw.Directionality(
                          textDirection: pw.TextDirection.rtl,
                          child: pw.Table(
                              border: pw.TableBorder.all(color: PdfColor(0.1, 0.1, 0.1, 1)),
                              children: [
                                pw.TableRow(children: [
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("ملاحظات",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                        child: pw.Text("السعر",
                                            style: pw.TextStyle(font: font),
                                            textAlign: pw.TextAlign.center),
                                      )),
                                  pw.Expanded(
                                      flex: 3,
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("اسم المنتج",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                  pw.Expanded(
                                      child: pw.Padding(
                                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                          child: pw.Text("الكميه",
                                              style: pw.TextStyle(font: font),
                                              textAlign: pw.TextAlign.center))),
                                ]),
                                ...List.generate(
                                    order.details!.length,
                                        (index) => pw.TableRow(children: [
                                      pw.Expanded(
                                          flex: 2,
                                          child: pw.Padding(
                                            padding:
                                            pw.EdgeInsets.symmetric(horizontal: 10),
                                            child: pw.Text(
                                                "${order.details![index].details}",
                                                style: pw.TextStyle(font: font),
                                                textAlign: pw.TextAlign.center),
                                          )),
                                      pw.Expanded(
                                          child: pw.Padding(
                                            padding:
                                            pw.EdgeInsets.symmetric(horizontal: 10),
                                            child: pw.Text("0",
                                                style: pw.TextStyle(font: font),
                                                textAlign: pw.TextAlign.center),
                                          )),
                                      pw.Expanded(
                                          flex: 3,
                                          child: pw.Padding(
                                              padding: pw.EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: pw.Text(
                                                  "${order.details![index].name}",
                                                  style: pw.TextStyle(font: font),
                                                  textAlign: pw.TextAlign.center))),
                                      pw.Expanded(
                                          child: pw.Padding(
                                              padding: pw.EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: pw.Text(
                                                  "${order.details![index].count}",
                                                  style: pw.TextStyle(font: font),
                                                  textAlign: pw.TextAlign.center))),
                                    ])),
                              ]),
                        ),
                        pw.Directionality(
                          textDirection: pw.TextDirection.rtl,
                          child: pw.Table(
                              border: pw.TableBorder.symmetric(
                                  outside:
                                  pw.BorderSide(color: PdfColor(0.1, 0.1, 0.1, 1))),
                              children: [
                                pw.TableRow(children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                    child: pw.Text("اجمالي الفاتورة   /     ${order.total}",
                                        style: pw.TextStyle(font: font),
                                        textAlign: pw.TextAlign.left),
                                  ),
                                  pw.Spacer(),
                                  pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 10),
                                      child: pw.Text(
                                        "اسم المندوب    /     ${order.mandobeName == null ? "" : order.mandobeName}",
                                        style: pw.TextStyle(font: font),
                                      )),
                                ]),
                              ]),
                        ),
                      ],
                    ),
                  ))
            ])),
      ),
    );
  }

  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}
