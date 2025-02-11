import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/order_model.dart';


class OrderDetailsScreen extends StatelessWidget {
   OrderDetailsScreen({super.key,required this.order});
  OrderModel order;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {},
    builder: (context, state) {
    AppCubit cubit = AppCubit.get(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Table(
                    border: TableBorder.all(color: Colors.black,width: 2),
                    children: [
                      TableRow(
                        children: [
                          Text("كود الفاتورة : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.orderCode!,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ]
                      ),
                      TableRow(
                        children: [
                          Text("الاسم : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.name!,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("العنوان : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.address!,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("المدينة : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.city!,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("رقم الهاتف : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.phone!,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("رقم اخر : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.phoneTow!,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("اسم المندوب : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.mandobeName!,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("اسم السيلز : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.code!,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("حالة الاوردر : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.status!,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("اجمالي المبلغ : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.total!,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("التاريخ : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.dateTime!.split(" ")[0]!,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("ملاحظات : ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                          Text(order.notes??"لا يوجد ملاحظات",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text("تفاصيل الاوردر ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                  SizedBox(width: 10,),
                  Row(
                    children: [
                      Expanded(child: Text("العدد ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),textAlign: TextAlign.center,),),
                      Expanded(child: Text("اسم الصنف ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),textAlign: TextAlign.center,),),
                    ],
                  ),
                  SizedBox(width: 10,),
                  ListView.separated(
                    shrinkWrap: true,
                      itemBuilder: (context,index)=>Row(
                        children: [
                          Expanded(child: Text("${order.details![index].count}",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),textAlign: TextAlign.center,),),
                          Expanded(child: Text("${order.details![index].name} ",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),textAlign: TextAlign.center,),),
                        ],
                      ),
                      separatorBuilder: (context,index)=>SizedBox(height: 10,), itemCount: order.details!.length)
                ],
              ),
            )
        ),
      ),
    );});
  }
}
