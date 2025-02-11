import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:future/model/user_model.dart';
import 'package:future/shared/chach_helper.dart';
import 'package:future/shared/constant/constant.dart';
import 'cubit/bloc_observer.dart';
import 'cubit/cubit.dart';
import 'cubit/stats.dart';
import 'layout/home_layout.dart';
import 'modules/login/login_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyCn9mZ2WlZvh4FDpxIdjcojMc995dXYsU0", appId: "1:286971011051:web:6dda0ae7fcba54ab2703ae", messagingSenderId: "286971011051", projectId: "future-5bb96"),
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  var data=CacheHelper.getData(key: "user");
  print(data);
  if(data != null){
    user = json.decode(data);
    usermodel=UserModel(
      uId: user["uId"],
      password: user["password"],
      type: user["type"],
      name: user["name"],
      email: user["email"],
      addOrder: user["addOrder"],
      editOrder: user["editOrder"],
      removeOrder: user["removeOrder"],
      showMandobe: user["showMandobe"],
      addMandobe: user["addMandobe"],
      editMandobe: user["editMandobe"],
      removeMandobe: user["removeMandobe"],
        showCode: user["showCode"],
      addCode: user["addCode"],
      editCode: user["editCode"],
      removeCode: user["removeCode"],
      showStore: user["showStore"],
      addStore: user["addStore"],
      editStore: user["editStore"],
      changeStatus: user["changeStatus"],
      addComment: user["addComment"]
    );
  }
  print(user);
  if (user != null&&user!="") {
    widget = HomeLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget? latestwidget;
  MyApp(this.latestwidget, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>AppCubit(),
        child: BlocConsumer<AppCubit,AppStats>(
            listener: (context,state){
            },
            builder: (context,state){
              return  MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: Locale('ar'),
                supportedLocales: [
                  Locale('ar'), // العربية
                ],
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                title: 'The Future Market',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: latestwidget,
              );}));
  }
}

