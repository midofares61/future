import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../model/order_model.dart';
import '../../shared/widgets/widget.dart';

class Printer extends StatelessWidget {
  const Printer({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    // عند بناء الشاشة، قم بطباعة الفاتورة مباشرة
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _printDirectly(order);
    // });

    return Scaffold(
      appBar: AppBar(title:const Text("Fatora")),
      // body: Center(child: Text("Printing...")),
      body: PdfPreview(
        maxPageWidth: 900,
        canChangeOrientation: false,
        canChangePageFormat: false ,
        initialPageFormat: PdfPageFormat.a5.landscape,
        previewPageMargin:const EdgeInsets.all(30),
        build: (format) => _generatePdf(order),
      ),
    );
  }


  Future<Uint8List> _generatePdf(OrderModel order) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    final fontData = await rootBundle.load('asset/font/Cairo-Medium.ttf');
    final font = pw.Font.ttf(fontData);
    pdf.addPage(
      pw.Page(
        margin:const pw.EdgeInsets.all(15),
        pageFormat: PdfPageFormat.a5,
        build: (context) {
          return buildPrintDoc(order, font);
        },
      ),
    );

    return pdf.save();
  }
}
