import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/shared/constant/constant.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../shared/widgets/alert_widget.dart';
class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getTransferRequest();
    return  BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {

        },
        builder: (context, state) {
          double screenWidth = MediaQuery.of(context).size.width;
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "سجل السحب",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                color: const Color.fromRGBO(232, 243, 255, 1),
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 5)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      screenWidth<1500?
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 1500,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const  EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Text("المبلغ",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                      Expanded(child: Text("اسم المستخدم",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                      Expanded(child: Text("حالة الطلب",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                      Expanded(flex:2,child: Text("ملاحظات",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                      Expanded(child: Text("الصلاحيه",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                      Expanded(child: Text("رقم الهاتف",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                      Expanded(child: Text("نوع المحفظة",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                      Expanded(child: Text("تاريخ التحويل",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                      Expanded(child: Text("وقت التحويل",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                      Expanded(child: Text(" ",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: ConditionalBuilder(
                                      condition: cubit.requests!=null,
                                      builder: (context)=> ConditionalBuilder(
                                          condition: cubit.requests!.isNotEmpty,
                                          builder: (context)=>ListView.separated(
                                              itemBuilder:  (context,index)=>Container(
                                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(width: 1,color: defaultColor)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Expanded(child: Text("${cubit.requests![index].amount}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requests![index].name}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requests![index].status}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(flex:2,child: Text("${cubit.requests![index].notes}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requests![index].role}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requests![index].phone}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requests![index].type}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requests![index].dateTime!.split(" ")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requests![index].dateTime!.split(" ")[1].split(".")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    if(cubit.requests![index].image!.isNotEmpty)
                                                    Expanded(child: IconButton(onPressed: (){
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
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
                                                                content: Image.network(cubit.requests![index].image!,width: 400,height: 400,fit: BoxFit.cover,),
                                                              )
                                                      );
                                                    }, icon: Icon(Icons.image,color: defaultColor,))),
                                                  ],
                                                ),
                                              ),
                                              separatorBuilder: (context,index)=>SizedBox(height: 10  ,),
                                              itemCount: cubit.requests!.length>5?5:cubit.requests!.length
                                          ),
                                          fallback: (context)=>Center(child: Text("لا يوحد اي معاملات حتي الان"),)
                                      ),
                                      fallback: (context)=>Center(child: CircularProgressIndicator(),)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ):
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const  EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(child: Text("المبلغ",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                  Expanded(child: Text("اسم المستخدم",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                  Expanded(child: Text("حالة الطلب",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                  Expanded(flex:2,child: Text("ملاحظات",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                  Expanded(child: Text("الصلاحيه",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                  Expanded(child: Text("رقم الهاتف",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                  Expanded(child: Text("نوع المحفظة",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                  Expanded(child: Text("تاريخ التحويل",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                  Expanded(child: Text("وقت التحويل",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ConditionalBuilder(
                                  condition: cubit.requests!=null,
                                  builder: (context)=> ConditionalBuilder(
                                      condition: cubit.requests!.isNotEmpty,
                                      builder: (context)=>ListView.separated(
                                          itemBuilder:  (context,index)=>Container(
                                            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(width: 1,color: defaultColor)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(child: Text("${cubit.requests![index].amount}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requests![index].name}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requests![index].status}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(flex:2,child: Text("${cubit.requests![index].notes}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requests![index].role}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requests![index].phone}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requests![index].type}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requests![index].dateTime!.split(" ")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requests![index].dateTime!.split(" ")[1].split(".")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                              ],
                                            ),
                                          ),
                                          separatorBuilder: (context,index)=>SizedBox(height: 10  ,),
                                          itemCount: cubit.requests!.length>5?5:cubit.requests!.length
                                      ),
                                      fallback: (context)=>Center(child: Text("لا يوحد اي معاملات حتي الان"),)
                                  ),
                                  fallback: (context)=>Center(child: CircularProgressIndicator(),)
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
