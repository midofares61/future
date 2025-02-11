import 'dart:typed_data';
import 'dart:html' as html; // هذا الملف سيُستخدم فقط على الويب

void downloadExcel(Uint8List uint8List, String fileName) {
  final blob = html.Blob([uint8List]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", fileName)
    ..click();
  html.Url.revokeObjectUrl(url);
}
