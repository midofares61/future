import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formateTime(Timestamp  date) {
  Timestamp timestamp = date;
  DateTime dateTime = timestamp.toDate();
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  return formattedDate;
}