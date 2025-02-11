import 'package:flutter/material.dart';
import 'package:future/shared/widgets/text_widget.dart';
import '../constant/constant.dart';

Widget OrderTitle(double screenWidth)=>Expanded(
  child: Row(
    children: [
      // text(" ", 1, secondeColor,TextAlign.center),
      text("التاريخ",screenWidth > 600? 5:4, secondeColor,TextAlign.center),
      text("الاسم", 5, secondeColor,TextAlign.center),
      text("الكود", 4, secondeColor,TextAlign.center),
      text("المدينة", 4, secondeColor,TextAlign.center),
      text("العنوان", 5, secondeColor,TextAlign.center),
      text("شركة الشحن", 5, secondeColor,TextAlign.center),
      text("ملاحظة", 5, secondeColor,TextAlign.center),
      const SizedBox(
        width: 20,),
      text("الاجمالي", 4, secondeColor,TextAlign.center),
      text("المسوق", 4, secondeColor,TextAlign.center),
      text("الحالة", 4, secondeColor,TextAlign.center),
      const SizedBox(
        width: 10,
      ),
      text("اخري", 6, secondeColor,TextAlign.center),
    ],
  ),
);