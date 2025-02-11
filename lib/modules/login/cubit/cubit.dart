import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future/modules/login/cubit/states.dart';
import '../../../model/user_model.dart';
import '../../../shared/chach_helper.dart';
import '../../../shared/constant/constant.dart';
class LoginCubit extends Cubit<SocialLoginStates>{
  LoginCubit():super(SocialLoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);


  void login({required String email, required String password}) async {
    emit(OnLoadingLogin());
    FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
      getUser(uId: value.user!.uid);
      emit(LoginSuccessful(value.user!.uid));
    }).catchError((e){
      emit(LoginError(e.toString()));
    });
  }

  IconData suffix=Icons.visibility;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility:Icons.visibility_off;
    emit(SocialChangeLoginPasswordVisibilityState());
  }

  void getUser({required String uId}) {
    emit(SocialOnLoadingGetUserState());
    if (usermodel==null) {
      FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
        usermodel = UserModel.fromJson(value.data());
        CacheHelper.SaveData(key: "user", value: json.encode(value.data()));
        uId=usermodel!.uId!;
        emit(SocialGetUserSuccessState());
      }).catchError((error) {
        emit(SocialGetUserErrorState());
      });
    }
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String type,
    required bool addOrder,
    required bool editOrder,
    required bool removeOrder,
    required bool showMandobe,
    required bool addMandobe,
    required bool editMandobe,
    required bool removeMandobe,
    required bool showCode,
    required bool addCode,
    required bool editCode,
    required bool removeCode,
    required bool showStore,
    required bool addStore,
    required bool editStore,
  }) {
    emit(SocialRegisterOnLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: "$email@gmail.com", password: password)
        .then((value) {
      userCreate(
        email: email,
        password: password,
        uId: value.user!.uid,
        name: name,
        type: type,
        addOrder: addOrder,
        editOrder: editOrder,
        removeOrder: removeOrder,
        showMandobe: showMandobe,
        addMandobe: addMandobe,
        editMandobe: editMandobe,
        removeMandobe: removeMandobe,
        showCode: showCode,
        addCode: addCode,
        editCode: editCode,
        removeCode: removeCode,
        showStore: showStore,
        addStore: addStore,
        editStore: editStore,
      );
    }).catchError((e) {
      emit(SocialRegisterErrorState(e.toString()));
    });
  }

  void userCreate({
    required String email,
    required String password,
    required String uId,
    required String name,
    required String type,
    required bool addOrder,
    required bool editOrder,
    required bool removeOrder,
    required bool showMandobe,
    required bool addMandobe,
    required bool editMandobe,
    required bool removeMandobe,
    required bool showCode,
    required bool addCode,
    required bool editCode,
    required bool removeCode,
    required bool showStore,
    required bool addStore,
    required bool editStore,
  }) {
    emit(OnLoadingCreateUserState());
    UserModel model = UserModel(
      uId: uId,
      password: password,
      name: name,
      type: type,
      email: email,
      addOrder: addOrder,
      editOrder: editOrder,
      removeOrder: removeOrder,
      showMandobe: showMandobe,
      addMandobe: addMandobe,
      editMandobe: editMandobe,
      removeMandobe: removeMandobe,
      showCode: showCode,
      addCode: addCode,
      editCode: editCode,
      removeCode: removeCode,
      showStore: showStore,
      addStore: addStore,
      editStore: editStore,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      // getUsers();
      emit(SocialUserCreateSuccessState(uId));
    }).catchError((error) {
      emit(SocialUserCreateErrorState(error.toString()));
    });
  }
}