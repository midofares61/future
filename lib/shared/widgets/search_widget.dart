import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';

Widget search({
  required TextEditingController searchController,
  required Function(String) onChange,
  required String hint,
})=>TextFormField(
  controller: searchController,
  onChanged:onChange,
  decoration: InputDecoration(
    isDense: true,
    prefixIcon: Icon(
      Icons.search,
      color: defaultColor,
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide:const BorderSide(
            color: Colors.transparent)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide:const BorderSide(
            color: Colors.transparent)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide:const BorderSide(
            color: Colors.transparent)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide:const BorderSide(
            color: Colors.transparent)),
    hintText:hint,
    filled: true,
    fillColor: Colors.grey.shade200,
  ),
);