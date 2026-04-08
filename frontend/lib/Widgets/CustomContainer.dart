import 'package:flutter/material.dart';
import 'package:frontend/Widgets/AppColors.dart';

class Customcontainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF2E7D32),
        Appcolors.appmaincolor, // Light edge
     // Color(0xFF0D3311), // Dark middle
      Color(0xFF2E7D32),
      

      ],
    ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint);
    
    Path curvepath = Path();
    curvepath.moveTo(size.width*0.2, 0);
    curvepath.quadraticBezierTo(size.width*0.5, size.height*0.2, size.width, size.height*0.15);
    curvepath.lineTo(size.width, 0);
    curvepath.close();
    
    
    paint.shader = LinearGradient(
      colors: [
       Colors.white.withOpacity(0.2),
       Colors.white.withOpacity(0.05),
      ],
    ).createShader(Offset.zero & size);
    canvas.drawPath(curvepath, paint);

    Paint linepaint = Paint()
    ..color = Colors.white.withOpacity(0.1)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

    canvas.drawLine(Offset(size.width, 0),
     Offset(0, size.height), linepaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
}
