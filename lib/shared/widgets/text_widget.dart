import 'package:flutter/cupertino.dart';

Widget text(text,flex,color,align)=> Expanded(
    flex:flex,
    child: Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: 15,
          fontWeight: FontWeight.w600),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign:align,
    ));


Widget textSuppliers(text,flex,color,screenWidth)=> Expanded(
    flex:flex,
    child: Text(
          text,
          style: TextStyle(
              color: color,
              fontSize: screenWidth>600?16:13,
              fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign:TextAlign.center,
    ));