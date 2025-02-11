import 'package:flutter/material.dart';
import '../../cubit/cubit.dart';
import '../../modules/dialog_widget.dart';
import '../constant/constant.dart';

Widget defaultButton(
    {required String text, required String image, double? width,required int index,required BuildContext context,required IconData icon,required bool menu,required String labelAppBar}) =>
    InkWell(
      onTap: (){
        AppCubit.get(context).changeIndex(index,labelAppBar);
          Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(left:BorderSide(color: index==AppCubit.get(context).currentIndex?const Color.fromRGBO(13, 80, 159, 1):Colors.white,width: 3) )
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color:const Color.fromRGBO(13, 80, 159, 1),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(icon,color: Colors.white,size: 18,),
            ),
            if(menu)
              const SizedBox(width: 15,),
            if(menu)
              Text(
                text.toUpperCase(),
                style: TextStyle(color:index==AppCubit.get(context).currentIndex? Colors.black:Colors.grey, fontWeight: index==AppCubit.get(context).currentIndex?FontWeight.bold:FontWeight.w500,fontSize: index==AppCubit.get(context).currentIndex?18:16),

              ),
          ],
        ),
      ),
    );

void navigateTo({required context, required widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateToFinish({required context, required widget}) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => widget), (route) {
    return false;
  });
}

dialog(context,
    {
      required void Function()? onTap,
      required void Function()? onCancelTap,
      required IconData icon,
      required Color iconColor,
      required String bigTitle,
      required String subTitle,
      required String onPressedTitle}) {
  return showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          padButtom: 32,
          padLeft: 32,
          padReight: 32,
          padTop: 32,
          radius: 16,
          dialogContent: Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: iconColor,
                      size: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      bigTitle,
                      style:const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                subTitle,
                style:const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onCancelTap,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: defaultColor, width: 2),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)),
                        height: 50,
                        width: double.infinity,
                        child:const Center(
                          child: Text(
                            "الغاء",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        decoration: BoxDecoration(
                            color: defaultColor,
                            borderRadius: BorderRadius.circular(16)),
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            onPressedTitle,
                            style:const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      });
}