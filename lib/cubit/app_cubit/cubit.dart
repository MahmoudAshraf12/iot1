import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/components/cons.dart';
import 'package:iot/cubit/app_cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import '../../models/user_model.dart';
import '../../screens/home_screen.dart';
import '../../screens/profile_screen.dart';
import 'package:image_picker/image_picker.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(Context) => BlocProvider.of(Context);
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Profile',
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavabBarState());
  }

  UserModel? model;

  void getUserData() {
    emit(IotGetUserLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromjson(value.data()!);
      print(value.data());
      emit(IotGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(IotGetUserErrorStates(error.toString()));
    });
  }

  int counter = 1;

  void minis() {
    counter--;
    emit(CounterMinisState());
  }

  void plus() {
    counter++;
    emit(CounterPlusState());
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      profileImage = File(PickedFile.path);
      emit(IotProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(IotProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      coverImage = File(PickedFile.path);
      emit(IotCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(IotCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(IotUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());

        UpdateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(IotUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(IotUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(IotUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        UpdateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(IotUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(IotUploadCoverImageErrorState());
    });
  }

  void UpdateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    // emit(SocialUserUpdateLoadingState());
    // if (coverImage != null) {
    //   uploadCoverImage(name: name, phone: phone, bio: bio);
    // } else if (profileImage != null) {
    //   uploadProfileImage(name: name, phone: phone, bio: bio);
    // } else {
    UserModel model1 = UserModel(
      name: name,
      phone: phone,
      uId: uId,
      image: image ?? model!.image,
      cover: cover ?? model!.cover,
      email: model!.email,
      bio: bio,
      //isEmailverified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model1.uId)
        .set(model1.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(IotUserUpdateErrorState());
    });
  }

}
