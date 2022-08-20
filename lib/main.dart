import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iot/components/cons.dart';
import 'package:iot/const/colors.dart';
import 'package:iot/cubit/app_cubit/cubit.dart';
import 'package:iot/cubit/app_cubit/states.dart';
import 'package:iot/screens/home_screen.dart';
import 'package:iot/screens/login_screen/login_screen.dart';
import 'package:iot/screens/splash_screen.dart';
import 'package:iot/shared/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  late Widget widget ;
  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = SplashScreen();
  }
//  await FirebaseAuth.instance.authStateChanges().listen((user) {
//     if (user == null) {
//       widget = LoginScreen();
//     } else {
//       widget = HomeScreen();
//     }
//   });
//   _auth.authStateChanges().listen((User user) {
//   if (user == null) {
//     print('User is currently signed out!');
//   } else {
//     print('User is signed in!');
//   }
// });
  runApp(MyApp(
    startWidget: widget ,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.startWidget});
  Widget? startWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, State) {},
        builder: (context, State) {
          return MaterialApp(
            color: HexColor("5D0A84"),
            debugShowCheckedModeBanner: false,
            title: 'Iot',
            theme: ThemeData(
              colorScheme: ThemeData().colorScheme.copyWith(
                    primary: primaryColor,
                  ),
              backgroundColor: HexColor("5D0A84"),
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
