import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/components/cons.dart';
import 'package:iot/const/colors.dart';
import 'package:iot/cubit/app_cubit/cubit.dart';
import 'package:iot/screens/edit_profile_screen.dart';
import '../cubit/app_cubit/states.dart';
import 'login_screen/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).model;
        return Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(elevation: 0),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 140.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://img.freepik.com/free-photo/cheerful-male-gives-nice-offer-advertises-new-product-sale-stands-torn-paper-hole-has-positive-expression_273609-38452.jpg?t=st=1652890094~exp=1652890694~hmac=6915b2424a8d31842d0d607abe8e11349892f47ca82f1088707178625778366e&w=1060',
                                  //${userModel!.cover}
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 63.0,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/cheerful-male-gives-nice-offer-advertises-new-product-sale-stands-torn-paper-hole-has-positive-expression_273609-38452.jpg?t=st=1652890094~exp=1652890694~hmac=6915b2424a8d31842d0d607abe8e11349892f47ca82f1088707178625778366e&w=1060',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '${userModel!.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${userModel.bio}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: [
                        Text(
                          'The Max Number Of Pieces Achived ',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '${AppCubit.get(context).counter}',
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'The number of pieces to be achieved ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                '2000',
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        defaultButton(
                            function: () {
                              navigateto(context, EditProfileScreen());
                            },
                            text: 'Edit profile',
                            background: Colors.red[50]),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultButton(
                            function: () async {
                              await userModel.uId == null;
                              await FirebaseAuth.instance.signOut();
                              // firebaseUser = await await _auth.currentUser();
                              // navigateAndFinish(context, LoginScreen());
                            },
                            text: 'log out',
                            background: Colors.red[50]),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
