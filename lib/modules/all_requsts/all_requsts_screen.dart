import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/request_model.dart';
import '../../shared/constant/constant.dart';
import '../../shared/widgets/alert_widget.dart';
class AllRequestsScreen extends StatefulWidget {
  const AllRequestsScreen({super.key});

  @override
  State<AllRequestsScreen> createState() => _AllRequestsScreenState();
}

class _AllRequestsScreenState extends State<AllRequestsScreen> {

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getAllRequest();
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          double screenWidth = MediaQuery.of(context).size.width;
          return Scaffold(
            appBar: AppBar(

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
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                BorderSide(color: Colors.grey, width: 1))),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                          Color.fromRGBO(155, 145, 255, 1),
                                          width: 2))),
                              child: const Text(
                                "كل الطلبات",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(155, 145, 255, 1)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
                                      Expanded(child: Text("ملاحظات",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
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
                                      condition: cubit.allRequests!=null,
                                      builder: (context)=> ConditionalBuilder(
                                          condition: cubit.allRequests!.isNotEmpty,
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
                                                    Expanded(child: Text("${cubit.allRequests![index].amount}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.allRequests![index].name}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.allRequests![index].status}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.allRequests![index].notes}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.allRequests![index].role}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.allRequests![index].phone}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.allRequests![index].type}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.allRequests![index].dateTime!.split(" ")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.allRequests![index].dateTime!.split(" ")[1].split(".")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                  ],
                                                ),
                                              ),
                                              separatorBuilder: (context,index)=>SizedBox(height: 10  ,),
                                              itemCount: cubit.allRequests!.length>5?5:cubit.allRequests!.length
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
                                  Expanded(child: Text("ملاحظات",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
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
                                  condition: cubit.allRequests!=null,
                                  builder: (context)=> ConditionalBuilder(
                                      condition: cubit.allRequests!.isNotEmpty,
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
                                                Expanded(child: Text("${cubit.allRequests![index].amount}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.allRequests![index].name}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.allRequests![index].status}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.allRequests![index].notes}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.allRequests![index].role}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.allRequests![index].phone}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.allRequests![index].type}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.allRequests![index].dateTime!.split(" ")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.allRequests![index].dateTime!.split(" ")[1].split(".")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                              ],
                                            ),
                                          ),
                                          separatorBuilder: (context,index)=>SizedBox(height: 10  ,),
                                          itemCount: cubit.allRequests!.length>5?5:cubit.allRequests!.length
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
