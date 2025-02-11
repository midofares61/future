import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../model/order_model.dart';

reportBuildPrintDoc(List<OrderModel> order, font) => [
      pw.Directionality(
        textDirection: pw.TextDirection.rtl,
        child: pw.Table(
            border: pw.TableBorder.all(color: const PdfColor(0.1, 0.1, 0.1, 1)),
            children: [
              pw.TableRow(children: [
                pw.Expanded(
                    child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Text("تفاصيل الاوردر",
                      style: pw.TextStyle(font: font),
                      textAlign: pw.TextAlign.center),
                )),
                pw.Expanded(
                    child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Text("رقم الهاتف",
                            style: pw.TextStyle(font: font),
                            textAlign: pw.TextAlign.center))),
                pw.Expanded(
                    child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Text("العنوان",
                            style: pw.TextStyle(font: font),
                            textAlign: pw.TextAlign.center))),
                pw.Expanded(
                    child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Text("اسم العميل",
                            style: pw.TextStyle(font: font),
                            textAlign: pw.TextAlign.center))),
              ]),
              ...order.map((item) => pw.TableRow(children: [
                    pw.Expanded(
                        child: pw.Container(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                      child: pw.Text(
                        item.details!.map((product) {
                          return "${product.count!}-${product.name!}";
                        }).join(" + "),
                        style: pw.TextStyle(font: font, fontSize: 12),
                        textAlign: pw.TextAlign.center,
                      ),
                    )),
                    pw.Expanded(
                        child: pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                            child: pw.Text("${item.phone}",
                                style: pw.TextStyle(font: font, fontSize: 11),
                                textAlign: pw.TextAlign.center))),
                    pw.Expanded(
                        child: pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                            child: pw.Text("${item.address}",
                                style: pw.TextStyle(font: font, fontSize: 11),
                                textAlign: pw.TextAlign.center))),
                    pw.Expanded(
                        child: pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                            child: pw.Text("${item.name}",
                                style: pw.TextStyle(font: font),
                                textAlign: pw.TextAlign.center))),
                  ])),
            ]),
      )
    ];
