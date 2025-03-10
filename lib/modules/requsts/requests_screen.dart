import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/shared/componnents/componnents.dart';

import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/request_model.dart';
import '../../shared/constant/constant.dart';
import '../../shared/widgets/alert_widget.dart';
import '../all_requsts/all_requsts_screen.dart';
class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final notesController = TextEditingController();
  final notesRefuseController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formEditKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getTransferRequestDelay();
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {
          if(state is RequestConfirmSuccessful||state is RequestRefuseSuccessful){
            setState(() {
              notesController.text="";
              notesRefuseController.text="";
              AppCubit.get(context).webRequestImage=null;
            });
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          double screenWidth = MediaQuery.of(context).size.width;
          return Scaffold(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                "الطلبات",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(155, 145, 255, 1)),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                navigateTo(context: context, widget: AllRequestsScreen());
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration:  BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(5)
                                   ),
                                child: const Text(
                                  "كل الطلبات",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
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
                                      condition: cubit.requestsDelay!=null,
                                      builder: (context)=> ConditionalBuilder(
                                          condition: cubit.requestsDelay!.isNotEmpty,
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
                                                    Expanded(child: Text("${cubit.requestsDelay![index].amount}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requestsDelay![index].name}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requestsDelay![index].status}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requestsDelay![index].notes}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requestsDelay![index].role}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requestsDelay![index].phone}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requestsDelay![index].type}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requestsDelay![index].dateTime!.split(" ")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Text("${cubit.requestsDelay![index].dateTime!.split(" ")[1].split(".")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                    Expanded(child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        InkWell(
                                                          onTap: (){
                                                            _showWithdrawConfirmDialog(context,cubit,cubit.requestsDelay![index]);
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.green,
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                                              child: Text("قبول",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),)),
                                                        ),
                                                        InkWell(
                                                          onTap: (){
                                                            _showWithdrawDialog(context,cubit,cubit.requestsDelay![index]);
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                                              child: Text("رفض",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),)),
                                                        )
                                                      ],
                                                    )),
                                                  ],
                                                ),
                                              ),
                                              separatorBuilder: (context,index)=>SizedBox(height: 10  ,),
                                              itemCount: cubit.requestsDelay!.length>5?5:cubit.requestsDelay!.length
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
                                  condition: cubit.requestsDelay!=null,
                                  builder: (context)=> ConditionalBuilder(
                                      condition: cubit.requestsDelay!.isNotEmpty,
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
                                                Expanded(child: Text("${cubit.requestsDelay![index].amount}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requestsDelay![index].name}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requestsDelay![index].status}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requestsDelay![index].notes}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requestsDelay![index].role}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requestsDelay![index].phone}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requestsDelay![index].type}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requestsDelay![index].dateTime!.split(" ")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Text("${cubit.requestsDelay![index].dateTime!.split(" ")[1].split(".")[0]}",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
                                                Expanded(child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        _showWithdrawConfirmDialog(context,cubit,cubit.requestsDelay![index]);
                                                      },
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.green,
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                                          child: Text("قبول",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),)),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        _showWithdrawDialog(context,cubit,cubit.requestsDelay![index]);
                                                      },
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                                          child: Text("رفض",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),)),
                                                    )
                                                  ],
                                                )),
                                              ],
                                            ),
                                          ),
                                          separatorBuilder: (context,index)=>SizedBox(height: 10  ,),
                                          itemCount: cubit.requestsDelay!.length>5?5:cubit.requestsDelay!.length
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
  void _showWithdrawDialog(BuildContext context, AppCubit cubit,RequestModel model) {
    showDialog(
      context: context,
      builder: (context) =>  StatefulBuilder(
          builder: (context, setState) {
            return alert(
              cubit: cubit,
              context: context,
              formKey: formKey,
              onTap: () {
                cubit.requestRefused(model,notesRefuseController.text);
              },
              btn: "رفض تحويل",
              content: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 500,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        _buildTextField(controller: notesRefuseController, label: "الملاحظة", hintText: "الملاحظة"),
                      ],
                    ),
                  ),
                ),
              ),
            );}
      ),
    );
  }

  void _showWithdrawConfirmDialog(BuildContext context, AppCubit cubit,RequestModel model) {
    showDialog(
      context: context,
      builder: (context) =>  StatefulBuilder(
          builder: (context, setState) {
            return alert(
              cubit: cubit,
              context: context,
              formKey: formKey,
              onTap: () {
                cubit.requestConfirm(model: model, notes:notesController.text);
              },
              btn: "قبول تحويل",
              content: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 500,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        InkWell(
                          onTap: (){
                            cubit.picRequestImageFromGallery();
                          },
                          child: ConditionalBuilder(
                            condition: cubit.webRequestImage==null,
                            builder: (context)=>Container(
                              color: Colors.grey[200],
                              padding: EdgeInsets.all(10),
                              child: Container(
                                width: 300,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Text("اضغط هنا لاستيراد سكرين التحويل ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),
                            fallback: (context)=>Container(
                              color: Colors.grey[200],
                              padding: EdgeInsets.all(10),
                              child: Container(
                                width: 300,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Image.memory(
                                    cubit.webRequestImage!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),),
                              ),
                            ),
                          ),
                        ),
                        _buildTextField(controller: notesController, label: "الملاحظة", hintText: "الملاحظة"),
                      ],
                    ),
                  ),
                ),
              ),
            );}
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required String hintText}) {
    return TextFormField(
      controller: controller,
      validator: (value) => value!.isEmpty ? "يجب إدخال $label" : null,
      decoration: InputDecoration(border: const OutlineInputBorder(), labelText: label, hintText: hintText),
    );
  }
}
