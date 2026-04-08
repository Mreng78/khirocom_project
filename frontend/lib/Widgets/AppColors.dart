import 'package:flutter/material.dart';

class Appcolors {
  static Color background = const Color.fromARGB(255, 240, 248, 240);
  static Color appBarbackground = const Color(0xFF1B5E20);
  static Color appmaincolor = const Color(0xFF1B5E20);
  
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF2E7D32), // Light edge
      Color(0xFF0D3311), // Dark middle
      Color(0xFF2E7D32), // Light edge
    ],
    stops: [0.0, 0.5, 1.0],
  );
}