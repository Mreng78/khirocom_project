import 'package:flutter/material.dart';
import 'package:frontend/Screens/assistscreen/SplashScreen.dart';
import 'package:frontend/app_binding.dart';
import "package:get/get.dart";
import 'package:hive_flutter/adapters.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // خليه أول شيء

  await GetStorage.init();
  await Hive.initFlutter();
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006837),
          primary: const Color(0xFF006837),
          secondary: const Color(0xFFC5A059),
        ),
        fontFamily: 'Cairo',
      ),
      home: const SplashScreen(),
    );
  }
}
