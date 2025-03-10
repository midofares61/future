import 'dart:typed_data';
import 'dart:html' as html; // هذا الملف سيُستخدم فقط على الويب

void downloadPdf(Uint8List uint8List, String fileName) {
  final blob = html.Blob([uint8List], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "orders_${DateTime.now().millisecondsSinceEpoch}.pdf")
    ..click();
  html.Url.revokeObjectUrl(url);
}