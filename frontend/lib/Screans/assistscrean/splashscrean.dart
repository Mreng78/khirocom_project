import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Widgets/AppColors.dart';
import '../../Controller/splashscreancontroller.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class Splashscrean extends StatefulWidget {
  const Splashscrean({super.key});

  @override
  State<Splashscrean> createState() => _SplashscreanState();
}

class _SplashscreanState extends State<Splashscrean> {
  Splashscreancontroller get splashcontroller =>
      Get.put(Splashscreancontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FlutterIslamicIcons.solidQuran2,
              size: 200,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
