import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/model/gift_model.dart';
import 'package:future/modules/store/add_store.dart';
import 'package:future/shared/constant/constant.dart';
import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../model/matress_model.dart';
import '../../shared/componnents/componnents.dart';
import '../../shared/widgets/search_widget.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  var nameController = TextEditingController();

  var nameEditController = TextEditingController();
  var countEditController = TextEditingController();

  var nameGiftController = TextEditingController();

  var sizeController = TextEditingController();

  var heightController = TextEditingController();

  var countController = TextEditingController();

  var countStoreController = TextEditingController();

  var countGiftController = TextEditingController();
  List<GiftModel> searchOrder = [];
  var countGiftStoreController = TextEditingController();
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var formEditKey = GlobalKey<FormState>();

  MattressModel? mattressValue;

  String? choose="اضافة صنف";

  List<String> listChoose=[
    "اضافة صنف",
    if(usermodel!.addStore!)
    "اضافة للمخزن"
  ];

  GiftModel? giftvalue;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 800;
    int crossAxisCount = MediaQuery.of(context).size.width ~/ 250;
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          double screenWidth = MediaQuery.of(context).size.width;
          return Scaffold(
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                color:const Color.fromRGBO(232, 243, 255, 1),
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.grey,offset: Offset(0, 0),blurRadius: 5)
                    ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey, width: 1))),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 15, vertical: 10),
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Color.fromRGBO(
                                                                155, 145, 255, 1),
                                                            width: 2))),
                                                child: const Text(
                                                  "المنتجات",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          155, 145, 255, 1)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: search(
                                                    searchController:
                                                    searchController,
                                                    onChange: (search) {
                                                      setState(() {
                                                        searchOrder = [];
                                                        searchOrder = cubit.gift!
                                                            .where((element) =>
                                                            element.name!
                                                                .contains(
                                                                searchController
                                                                    .text)  )
                                                            .toList();
                                                      });
                                                    },
                                                    hint:
                                                    "ابحث بالاسم ..."),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              if(usermodel!.addOrder!)
                                                InkWell(
                                                  onTap: () {
                                                    navigateTo(
                                                        context: context,
                                                        widget: const AddStore());

                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 15, vertical: 13),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey.shade100,
                                                        borderRadius: BorderRadius.circular(5)),
                                                    child: Text(
                                                      "اضافة منتج",
                                                      style: TextStyle(
                                                          color: defaultColor,
                                                          fontSize: screenWidth>600?18:15,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                  Expanded(
                      child: ConditionalBuilder(
                    condition: cubit.gift!=null,
                    builder: (context) => ConditionalBuilder(
                        condition: cubit.gift!.isNotEmpty,
                        builder: (context)=>GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount,childAspectRatio:isMobile?1/0.9:1),
                            itemCount: cubit.gift!.length,
                            itemBuilder: (context,index)=>Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(color: Colors.grey,offset: Offset(0, 0),blurRadius: 5)
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // الجزء الخاص بالصورة والأيقونة
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        alignment: AlignmentDirectional.topStart,
                                        children: [
                                          Image.network(
                                            cubit.gift![index].image!,
                                            width: double.infinity,
                                            fit: BoxFit.contain,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: defaultColor,
                                              borderRadius: BorderRadius.circular(50)
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                            child: Text(cubit.gift![index].code!.toString(),style: TextStyle(color: Colors.white,fontSize: 15),),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "الاسم : ${cubit.gift![index].name!}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                              "الكميه : ${cubit.gift![index].count!}"  ,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text( "السعر : ${cubit.gift![index].price!}"),
                                      Text("الملاحظات  : ${cubit.gift![index].notes!}"),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            )
                        ),
                        fallback: (context)=>Expanded(child: Center(child: Text("لم يتم اضافة اي منتج",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                              FontWeight.bold),),))
                    ),
                    fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                  )),
                                      ],
                                    ),
                ),
              ),
            ),
          );
        });
  }
}
