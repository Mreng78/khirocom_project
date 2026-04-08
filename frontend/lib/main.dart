import 'package:flutter/material.dart';
import 'Screans/assistscrean/splashscrean.dart';
import "package:get/get.dart";
import 'Controller/splashscreancontroller.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  //todo This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(Splashscreancontroller());
      }),
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Cairo',
      ),
      home: const Splashscrean(),
    );  
  }
}
