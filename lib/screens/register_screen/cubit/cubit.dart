import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/screens/register_screen/cubit/states.dart';

import '../../../models/user_model.dart';

class IotRegisterCubit extends Cubit<IotRegisterStates> {
  IotRegisterCubit() : super(IotRegisterInitialStates());
  static IotRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(IotRegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(IotRegisterFailStates(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      image:
          'https://www.freepik.com/free-photo/man-using-picking-playing-background_6140279.htm',
      cover:
          'https://www.freepik.com/free-photo/coffee-music-objects_1363550.htm#&position=2&from_view=detail#&position=2&from_view=detail',
      bio: 'write your bio...',
      // isEmailverified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(IotCreateUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(IotCreateUserFailStates(error.toString()));
    });
  }

  bool IsObsecure = true;
  IconData suffix = Icons.visibility_outlined;

  // void ChangePasswordVisibility() {
  //   IsObsecure = !IsObsecure;
  //   suffix =
  //       IsObsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  //   emit(SocialRegisterChangePasswordVisibilityStates());
  // }
}
