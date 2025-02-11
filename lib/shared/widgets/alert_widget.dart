import 'package:flutter/material.dart';

import '../../cubit/cubit.dart';
import '../constant/constant.dart';

Widget alertEdit({
  required AppCubit cubit,
  required BuildContext context,
  required void Function() onTap,
  required void Function() onTap2,
  required String btn,
  required String btn2,
  required Widget content,
}) =>
    AlertDialog.adaptive(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
            decoration: BoxDecoration(
                color: defaultColor, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:const Icon(
                Icons.close,
                color: Colors.white,
              ),
            )),
      ),
      content: content,
      actions: [
        InkWell(
            onTap: () {
                onTap();
                Navigator.pop(context);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  btn,
                  style:const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))),
        InkWell(
            onTap: () {
                onTap2();
                Navigator.pop(context);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5)),
                padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  btn2,
                  style:const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))),
      ],
    );

Widget alert({
  required AppCubit cubit,
  required BuildContext context,
  required void Function() onTap,
  required String btn,
  required Widget content,
  required GlobalKey<FormState> formKey,
}) =>
    AlertDialog.adaptive(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
            decoration: BoxDecoration(
                color: defaultColor, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:const Icon(
                Icons.close,
                color: Colors.white,
              ),
            )),
      ),
      content: content,
      actions: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  onTap();
                  Navigator.pop(context);
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Text(
                    btn,
                    style:const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))),
        )
      ],
    );
