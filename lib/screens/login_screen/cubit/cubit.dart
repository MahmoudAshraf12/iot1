import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/screens/login_screen/cubit/states.dart';


class IotLoginCubit extends Cubit<IotLoginStates> {
  IotLoginCubit() : super(IotLoginInitialStates());
  static IotLoginCubit get(context) => BlocProvider.of(context);
  // SocialLoginModel ? loginmodel;

  void userlogin({
    required String email,
    required String password,
  }) {
    emit(IotLoginLoadingStates());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(IotLoginSuccessStates(value.user!.uid));
    }).catchError((error) {
      emit(IotLoginFailStates(error.toString()));
    });
  }

  bool IsObsecure = true;
  IconData suffix = Icons.visibility_outlined;

  void ChangePasswordVisibility() {
    IsObsecure = !IsObsecure;
    suffix =
        IsObsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(IotChangePasswordVisibilityStates());
  }
}