import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/shared/chach_helper.dart';
import 'package:future/shared/constant/constant.dart';
import '../../layout/home_layout.dart';
import '../../shared/componnents/componnents.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late StreamSubscription subscription;
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  var isLoginSecure = true;

  @override
  Widget build(BuildContext context) {
    final ismobile = MediaQuery.of(context).size.width <= 500;
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,SocialLoginStates>(
          listener: (context, state) {
            if(state is SocialGetUserSuccessState){
              navigateToFinish(context: context, widget: const HomeLayout());

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم تسجيل الدخول بنجاح",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,duration: Duration(milliseconds: 1000),));
            }else if(state is LoginError){
              if(state.error=="[firebase_auth/invalid-email] The email address is badly formatted."){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("فشل في تسجيل الدخول تحقق من كلمة المرور ثم اعد المحاولة",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,duration: Duration(milliseconds: 1000),));
              }
              if(state.error=="[firebase_auth/unknown-error] An internal error has occurred."){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("فشل في تسجيل الدخول تحقق من الاتصال بالانترنت ثم اعد المحاولة",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,duration: Duration(milliseconds: 1000),));
              }
            }
          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context);
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(ismobile ? 20 : 40.0),
                    child: Center(
                      child: SizedBox(
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100)),
                              clipBehavior: Clip.antiAlias,
                              child:const Text("Future",style: TextStyle(color: Color.fromRGBO(13, 80, 159, 1),fontSize: 50,fontWeight: FontWeight.bold),),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      focusNode: _firstFocusNode,
                                      style:const TextStyle(color: Colors.black),
                                      autofocus: true,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_secondFocusNode);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "يجب ادخال اسم المستخدم ";
                                        }
                                        return null;
                                      },
                                      decoration:const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.grey)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.black)),
                                          label: FittedBox(
                                            child: Text("اسم المستخدم",
                                                style: TextStyle(color: Colors.black)),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.person_outline,
                                            color: Colors.black,
                                          ),
                                          border: OutlineInputBorder()),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      keyboardType: TextInputType.visiblePassword,
                                      obscureText: isLoginSecure,
                                      focusNode: _secondFocusNode,
                                      onFieldSubmitted: (_) {
                                        if (formKey.currentState!.validate()) {
                                          cubit.login(
                                            email: "${emailController.text}@gmail.com",
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                      style:const TextStyle(color: Colors.black),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "يجب ان تتكون كلمة السر من 8 احرف علي الافل";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          enabledBorder:const OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.grey)),
                                          focusedBorder:const OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.black)),
                                          label:const FittedBox(
                                            child: Text(
                                              "كلمة السر",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                          prefixIcon:
                                          const Icon(Icons.lock, color: Colors.black),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isLoginSecure = !isLoginSecure;
                                              });
                                            },
                                            icon: Icon(isLoginSecure
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          ),
                                          border:const OutlineInputBorder()),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                   ConditionalBuilder(
                                        condition: state is! OnLoadingLogin,
                                        builder: (context)=> defaultButton(
                                            text: "تسجيل الدخول",
                                            color: Colors.white,
                                            background: defaultColor,
                                            width: double.infinity,
                                            navigate: (){
                                              if (formKey.currentState!.validate()) {
                                                cubit.login(
                                                  email: "${emailController.text}@gmail.com",
                                                  password: passwordController.text,
                                                );
                                                // cubit
                                                //     .userRegister(
                                                //   name:
                                                //   "محمد فارس",
                                                //   email:
                                                //   emailController
                                                //       .text,
                                                //   password:
                                                //   passwordController
                                                //       .text,
                                                //   type: "ادمن",
                                                //   addOrder:
                                                //   true,
                                                //   editOrder:
                                                //   true,
                                                //   removeOrder:
                                                //   true,
                                                //   showCode:
                                                //   true,
                                                //   addCode:
                                                //   true,
                                                //   editCode:
                                                //   true,
                                                //   removeCode:
                                                //   true,
                                                //   showMandobe:
                                                //   true,
                                                //   addMandobe:
                                                //   true,
                                                //   editMandobe:
                                                //   true,
                                                //   removeMandobe:
                                                //   true,
                                                //   showStore:
                                                //   true,
                                                //   addStore:
                                                //   true,
                                                //   editStore:
                                                //   true,
                                                // );
                                              }
                                            }),
                                        fallback: (context)=>const Center(child: CircularProgressIndicator())),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
  Widget defaultButton({
    required String text,
    required Color color,
    required Color background,
    double? width,
    required Function() navigate,
  }) =>
      Container(
        width: width,
        padding:const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          onPressed: navigate,
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 25),
          ),
        ),
      );
}
