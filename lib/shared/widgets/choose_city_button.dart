

import 'package:flutter/material.dart';

import '../constant/constant.dart';

Widget chooseCityButton({
 required String chooseCity,
 required String text,
})=>Container(
  padding:const EdgeInsets.symmetric(
      horizontal: 15, vertical: 10),
  decoration: BoxDecoration(
      color: chooseCity==text?defaultColor:Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8)),
  child: Text(
    text,
    style: TextStyle(
        color: chooseCity==text?Colors.white:defaultColor,
        fontSize: 18,
        fontWeight: FontWeight.w500),
  ),
);

Widget chooseMandobeButton({
  required String chooseCity,
  required String text,
})=>Container(
  padding:const EdgeInsets.symmetric(
      horizontal: 15, vertical: 5),
  decoration: BoxDecoration(
      color: chooseCity==text?defaultColor:Colors.grey.shade100,
      borderRadius: BorderRadius.circular(20)),
  child: Text(
    text,
    style: TextStyle(
        color: chooseCity==text?Colors.white:defaultColor,
        fontSize: 16,
        fontWeight: FontWeight.w500),
  ),
);