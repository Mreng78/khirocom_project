import 'package:flutter/material.dart';

class Appcolors {
  // Primary Palette
  static Color background = const Color(0xFFF9FBF9);
  static Color emeraldPrimary = const Color(0xFF006837);
  static Color emeraldDark = const Color(0xFF004D2C);
  static Color goldSecondary = const Color(0xFFC5A059);
  static Color goldAccent = const Color(0xFFD4AF37);

  // Legacy mappings to avoid breaking existing code immediately
  static Color appBarbackground = emeraldDark;
  static Color appmaincolor = emeraldPrimary;

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF006837), // emeraldPrimary
      Color(0xFF004D2C), // emeraldDark
      Color(0xFF006837), // emeraldPrimary
    ],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFD4AF37), // goldAccent
      Color(0xFFC5A059), // goldSecondary
    ],
  );

  static const LinearGradient glossyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x4DFFFFFF), Color(0x1AFFFFFF), Color(0x0D000000)],
    stops: [0.0, 0.5, 1.0],
  );

  static LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white.withOpacity(0.15), Colors.white.withOpacity(0.05)],
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
