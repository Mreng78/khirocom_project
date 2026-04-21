import 'package:flutter/material.dart';
import 'package:frontend/Screens/assistscreen/SplashScreen.dart';
import 'package:frontend/app_binding.dart';
import "package:get/get.dart";
//import 'package:intl/date_symbol_data_file.dart';
import 'Controller/SplashScreenController.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // خليه أول شيء

  await GetStorage.init();
  await initializeDateFormatting('ar', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  //todo This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
    initialBinding: AppBinding(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Cairo',
      ),
      home: const SplashScreen(),
    );  
  }
}
