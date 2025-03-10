import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/shared/constant/constant.dart';

import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../shared/componnents/componnents.dart';
import '../../shared/widgets/alert_widget.dart';
import '../record/record_screen.dart';
class MyBalanceAdminScreen extends StatefulWidget {
  const MyBalanceAdminScreen({super.key});

  @override
  State<MyBalanceAdminScreen> createState() => _MyBalanceAdminScreenState();
}

class _MyBalanceAdminScreenState extends State<MyBalanceAdminScreen> {
  final balanceController = TextEditingController();
  final phoneController = TextEditingController();
  final notesController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formEditKey = GlobalKey<FormState>();
  @override
  void dispose() {
    balanceController.dispose();
    notesController.dispose();
    phoneController.dispose();
    super.dispose();
  }
  String choose = "كاش";
  final List<String> list = ["كاش", "انستا"];
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getTransferRequest();
    return  BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {
          if(state is WhistlingAdminSuccessful ||state is AddRequestSuccessful){
            balanceController.text="";
            notesController.text="";
            phoneController.text="";
          }
        },
        builder: (context, state) {
          double screenWidth = MediaQuery.of(context).size.width;
          AppCubit cubit = AppCubit.get(context);
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
                                "محفظتي",
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
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("الرصيد :    ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                            Text("${cubit.usersAdmin[0].totalBalance}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40),)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child:  InkWell(
                              onTap: (){
                                _showWithdrawDialog(context, cubit,   StatefulBuilder(
                                builder: (context, setState) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: 500,
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          spacing: 10,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 1, color: Colors.grey),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: DropdownButton<String>(
                                                value: choose,
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                isExpanded: true,
                                                underline: Container(),
                                                onChanged: (value) => setState(() => choose = value!),
                                                items: list.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: balanceController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "يجب إدخال المبلغ لاكمال العمليه";
                                                }
                                                if (int.parse(value)>cubit.usersAdmin[0].totalBalance!) {
                                                  return "هذا المبلغ اكبر من رصيدك الحالي (${cubit.usersAdmin[0].totalBalance!})";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(border: const OutlineInputBorder(), labelText:  "المبلغ", hintText:  "المبلغ"),
                                            ),
                                            _buildTextField(controller: phoneController, label: "رقم الهاتف", hintText: "رقم الهاتف"),
                                            _buildTextField(controller: notesController, label: "الملاحظة", hintText: "الملاحظة"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );}
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1,color: defaultColor)
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Text("طلب سحب",style: TextStyle(color: defaultColor,fontWeight: FontWeight.bold,fontSize: screenWidth<700?15:22  ),),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child:  InkWell(
                              onTap: (){
                                dialog(context, onTap: () {
                                  cubit.whistlingAdmin();
                                  Navigator.pop(context);
                                }, onCancelTap: () {
                                  Navigator.pop(context);
                                }, icon: Icons.info_outline, onPressedTitle: "نعم", subTitle: "هل انت متاكد من تصفير الحساب", bigTitle: "", iconColor: Colors.orange);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1,color: defaultColor)
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Text("تصفير الحساب",style: TextStyle(color: defaultColor,fontWeight: FontWeight.bold,fontSize: screenWidth<700?15:22 ),),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child:  InkWell(
                              onTap: (){
                                navigateTo(context: context, widget: RecordScreen());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1,color: defaultColor)
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Text("سجل السحب",style: TextStyle(color: defaultColor,fontWeight: FontWeight.bold,fontSize: screenWidth<700?15:22  ),),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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
                          "اخر النشاطات",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(155, 145, 255, 1)),
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
                                      Expanded( child: Text("اسم المستخدم",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 16),)),
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

  void _showWithdrawDialog(BuildContext context, AppCubit cubit,Widget content) {
    showDialog(
      context: context,
      builder: (context) =>
             alert(
              cubit: cubit,
              context: context,
              formKey: formKey,
              onTap: () {
                cubit.createTransferRequest(amount: int.parse(balanceController.text), notes: notesController.text, type: choose, phone: phoneController.text);
              },
              btn: "طلب تحويل",
              content:content,
            )
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
