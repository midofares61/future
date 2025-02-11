import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/gift_model.dart';
import '../../model/matress_model.dart';
import '../../shared/constant/constant.dart';
class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  var nameController = TextEditingController();

  var countController = TextEditingController();

  var countLocationController = TextEditingController();

  var formKey = GlobalKey<FormState>();


  GiftModel? giftvalue;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {
            if (state is CreateShippingPriceSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "تم اضافة المنطقة بنجاح",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
                duration: Duration(milliseconds: 1000),
              ));
              Navigator.pop(context);
            }
        },
    builder: (context, state) {
    AppCubit cubit = AppCubit.get(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("اضافة منطقة"),
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border(
                left:
                BorderSide(color: secondeColor, width: 2))),
        child: Padding(
          padding: const  EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(

            children: [
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب ادخال اسم المنطقة لاكمال العمليه";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "اسم المنطقة"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: countController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب ادخال السعر لاكمال العمليه";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "السعر"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          cubit.addShipping(
                            name: nameController.text,
                            price: int.parse(
                                countController.text),);
                          nameController.text = "";
                          countController.text = "";
                        }
                      },
                      child: Container(

                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        decoration: BoxDecoration(
                            color: defaultColor,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Text("اضافة منطقة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );});
  }
}
