import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Widgets/AppColors.dart';
import '../../Controller/splashscreancontroller.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import '../../Widgets/AppBar.dart';
class Splashscrean extends StatefulWidget {
  const Splashscrean({super.key});

  @override
  State<Splashscrean> createState() => _SplashscreanState();
}

class _SplashscreanState extends State<Splashscrean> {
  Splashscreancontroller get splashcontroller =>
      Get.find<Splashscreancontroller>();

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
              SizedBox(height: 20),
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
