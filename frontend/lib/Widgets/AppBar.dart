import 'package:flutter/material.dart';
import 'AppColors.dart';

class Appbar {
  String title;
 Appbar({required this.title});
AppBar appbar(){
    return AppBar(
      backgroundColor:Colors.transparent,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 70, // Increased height for better visibility
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: Appcolors.primaryGradient,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
      title: Text(this.title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      ),
      ),
    );
}  
}

Appbar appbar({required String title}) => Appbar(title: title);
