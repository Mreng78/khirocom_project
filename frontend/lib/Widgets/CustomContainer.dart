import 'dart:ui';
import "package:flutter/material.dart";

class Customcontainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Rect rect = Offset.zero & size;

    // 1. اللون الأساسي الخلفي (اللون الأخضر الغامق كما في الصورة)
    const Color darkGreen = Color(0xFF2E7D32); // درجة الأخضر الملكي الغامق من الصورة

    paint.color = darkGreen; // تلوين الخلفية باللون الأخضر الغامق مباشرة
    canvas.drawRect(rect, paint);
    
    // 2. توهج علوي خفيف (بدرجة أفتح قليلاً من الأخضر)
    Path curvepath1 = Path();
    curvepath1.moveTo(0, 0);
    curvepath1.lineTo(size.width * 0.7, 0);
    curvepath1.quadraticBezierTo(
      size.width * 0.4, 
      size.height * 0.25, 
      0, 
      size.height * 0.5
    );
    curvepath1.close();
    
    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF4CAF50).withOpacity(0.3), // أخضر أفتح كـ "ضوء"
        const Color(0xFF4CAF50).withOpacity(0.01),
      ],
    ).createShader(rect);
    canvas.drawPath(curvepath1, paint);

    // 3. لمسة ضوء حادة في الأسفل باللون الأبيض النقي لإعطاء مظهر زجاجي
    Path curvepath2 = Path();
    curvepath2.moveTo(size.width, size.height * 0.6);
    curvepath2.quadraticBezierTo(
      size.width * 0.5, 
      size.height * 0.85, 
      size.width * 0.2, 
      size.height
    );
    curvepath2.lineTo(size.width, size.height);
    curvepath2.close();

    paint.shader = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [
        Colors.white.withOpacity(0.2), // أبيض شفاف جداً
        Colors.transparent,
      ],
    ).createShader(rect);
    canvas.drawPath(curvepath2, paint);

    // 4. الحافة الخارجية (Border) بلمسة بيضاء شفافة لتحديد الشكل
    // لجعل الحاوية تبرز فوق الخلفية الغامقة
    Paint borderPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.4), // حافة بيضاء علوية
          Colors.white.withOpacity(0.05),
          const Color(0xFF81C784).withOpacity(0.3), // حافة سفلية خضراء فاتحة
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    canvas.drawRect(
      Rect.fromLTWH(0.5, 0.5, size.width - 1.0, size.height - 1.0), 
      borderPaint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}