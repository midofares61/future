import 'dart:io';
import 'dart:typed_data';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

void downloadPdf(Uint8List uint8List, String fileName) async{
  Directory? directory = await getExternalStorageDirectory();
  String filePath = '${directory?.path}/$fileName';

  File(filePath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(uint8List);

  OpenFile.open(filePath); // فتح الملف تلقائيًا بعد الحفظ
}