import 'package:expense_tracker_mvvm/Core/Routes/routes.dart';
import 'package:expense_tracker_mvvm/View/SplashScreen/splash_screen.dart';
import 'package:expense_tracker_mvvm/ViewModel/Controller/Auth/login_screen_controller.dart';
import 'package:expense_tracker_mvvm/ViewModel/Controller/Auth/signin_screen_controller.dart';
import 'package:expense_tracker_mvvm/ViewModel/Controller/Home/home_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Core/Routes/routes_name.dart';
import 'Core/Theme/app_pallete.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCGX-J0B-Gy8v2pdYbk5qbZBMgaIm1Ovnk',
        appId: '1:522571799917:android:2fba408e04a143fbd4ce64',
        messagingSenderId: '522571799917',
        projectId: 'expensetrackermvvm',
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(SigninScreenController());
    Get.put(LoginScreenController());
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppPallete.gradient1,
        ),
      ),
      debugShowCheckedModeBanner: false,

      home: const SplashScreen(),
      initialRoute: RouteName.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}


