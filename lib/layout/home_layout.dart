
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:future/modules/login/login_screen.dart';
import 'package:future/shared/chach_helper.dart';
import '../cubit/cubit.dart';
import '../cubit/stats.dart';
import '../shared/componnents/componnents.dart';
import '../shared/constant/constant.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).getOrders();
    AppCubit.get(context).getUsers();
    AppCubit.get(context).getUsersAdmin();
    AppCubit.get(context).getGift();
    AppCubit.get(context).getPendingGift();
    AppCubit.get(context).getOrderCode();
    AppCubit.get(context).getShippingPrice();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppStats>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return mobile(cubit);
        });
  }

  Widget mobile(AppCubit cubit) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(cubit.labelAppBar),
        ),
        drawer: Container(
            color: Colors.white,
            width: 240,
            padding: EdgeInsets.all(20),
            child: Column(
              spacing: 10,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "مرحيا بك يا ${usermodel!.name ?? ""}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey,
                ),
                defaultButton(
                    text: "الاوردرات",
                    width: double.infinity,
                    image: "",
                    index: 0,
                    context: context,
                    icon: Icons.shopping_cart_outlined,
                    menu: true,
                    labelAppBar: "الاوردرات"),
                if (usermodel!.showMandobe!)
                  defaultButton(
                      text: "شركات الشحن",
                      width: double.infinity,
                      image: "",
                      index: 1,
                      context: context,
                      icon: Icons.person,
                      menu: true,
                      labelAppBar: "شركات الشحن"),
                if (usermodel!.type == "ادمن")
                  defaultButton(
                      text: "المناطق",
                      width: double.infinity,
                      image: "",
                      index: 2,
                      context: context,
                      icon: Icons.person,
                      menu: true,
                      labelAppBar: "المناطق"),
                if (usermodel!.showStore!)
                  defaultButton(
                      text: "المنتجات",
                      width: double.infinity,
                      image: "",
                      index: 3,
                      context: context,
                      icon: Icons.home,
                      menu: true,
                      labelAppBar: "المنتجات"),
                if (usermodel!.showStore!)
                  defaultButton(
                      text: "المنتجات المعلقة",
                      width: double.infinity,
                      image: "",
                      index: 4,
                      context: context,
                      icon: Icons.home,
                      menu: true,
                      labelAppBar: "المنتجات المعلقة"),
                if (usermodel!.showCode!)
                  defaultButton(
                      text: "المسوقين",
                      width: double.infinity,
                      image: "",
                      index: 5,
                      context: context,
                      icon: Icons.group,
                      menu: true,
                      labelAppBar: "المسوقين"),
                if (usermodel!.type == "ادمن")
                defaultButton(
                      text: "التجار",
                      width: double.infinity,
                      image: "",
                      index: 6,
                      context: context,
                      icon: Icons.group,
                      menu: true,
                      labelAppBar: "التجار"),
                usermodel!.type == "ادمن"
                    ? defaultButton(
                    text: "محفظتي",
                    width: double.infinity,
                    image: "",
                    index: 7,
                    context: context,
                    icon: Icons.attach_money,
                    menu: true,
                    labelAppBar: "محفظتي")
                    : defaultButton(
                        text: "محفظتي",
                        width: double.infinity,
                        image: "",
                        index: 8,
                        context: context,
                        icon: Icons.attach_money,
                        menu: true,
                        labelAppBar: "محفظتي"),
                if (usermodel!.type == "ادمن")
                  defaultButton(
                      text: "الحسابات",
                      width: double.infinity,
                      image: "",
                      index: 9,
                      context: context,
                      icon: Icons.request_page_outlined,
                      menu: true,
                      labelAppBar: "الحسابات"),
                if (usermodel!.type == "ادمن")
                  defaultButton(
                      text: "الطلبات",
                      width: double.infinity,
                      image: "",
                      index: 10,
                      context: context,
                      icon: Icons.request_page_outlined,
                      menu: true,
                      labelAppBar: "الطلبات"),
                if (usermodel!.type == "ادمن")
                  defaultButton(
                      text: "المستخدمين",
                      width: double.infinity,
                      image: "",
                      index: 11,
                      context: context,
                      icon: Icons.settings,
                      menu: true,
                      labelAppBar: "المستخدمين"),
                Container(
                  child: InkWell(
                    onTap: () {
                      CacheHelper.removeData(key: "user").then((value) {
                        cubit.currentIndex = 0;
                        navigateToFinish(
                            context: context, widget: LoginScreen());
                        usermodel = null;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        if (true)
                          const SizedBox(
                            width: 15,
                          ),
                        if (true)
                          Text(
                            "تسجيل الخروج".toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            )),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: cubit.screen[cubit.currentIndex],
          ),
        ),
      );
}
