import 'package:flutter/material.dart';

class Appcolors {
  static Color background = const Color.fromARGB(255, 240, 248, 240);
  static Color appBarbackground = const Color(0xFF1B5E20); // Keep as dark base
  static Color appmaincolor = const Color(0xFF2E7D32); // More vibrant emerald
  
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

  static const LinearGradient glossyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x4DFFFFFF), // Semi-transparent white shine
      Color(0x1AFFFFFF), // Very transparent white
      Color(0x0D000000), // Subtle dark tint for depth
    ],
    stops: [0.0, 0.5, 1.0],
  );

  static LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withOpacity(0.15),
      Colors.white.withOpacity(0.05),
    ],
  );

  static List<BoxShadow> glossyShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 15,
      offset: const Offset(0, 6),
      spreadRadius: 2,
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.1),
      blurRadius: 1,
      offset: const Offset(0, -1),
    ),
  ];
}