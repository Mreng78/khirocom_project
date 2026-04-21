import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/Widgets/AppColors.dart';
import 'package:frontend/Controller/SplashScreenController.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController get splashcontroller =>
      Get.find<SplashScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: appbar(title: 'خيركم').appbar(),
      backgroundColor: Appcolors.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/appbackground.jpg"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
               
                
              ),
             
              Text(
                "خيركم",
                style: TextStyle(
                  color: Appcolors.appmaincolor,
                  fontSize: 32,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "من تعلم القرآن وعلمه",
                style: TextStyle(
                  color: Appcolors.appmaincolor,
                  fontSize: 24,
                  fontFamily  : 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
