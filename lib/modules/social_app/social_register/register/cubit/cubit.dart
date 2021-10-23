import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutter/modules/shop_app/register/cubit/states.dart';
import 'package:udemy_flutter/modules/social_app/social_register/register/cubit/states.dart';
import 'package:udemy_flutter/shared/network/end_points.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {

      userCreate(
        uId: value.user.uid,
        phone: phone,
        email: email,
        name: name,
      );
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    @required String name,
    @required String email,
    @required String phone,
    @required String uId,
  }) {
    SocialUserModel model=SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio...',
      image: 'https://image.freepik.com/free-photo/blocks-social-media-icons-arranged-circular-shape-textured-background_23-2147841409.jpg',
      cover: 'https://image.freepik.com/free-photo/blocks-social-media-icons-arranged-circular-shape-textured-background_23-2147841409.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value){
      emit(SocialCreateUserSuccessState());
    }).catchError((error){
      print(error.toString());

      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
