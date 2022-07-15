import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width*1.0; // for convenient shortage
    double th = sh * 0.1; // total frame thickness
    double side = sw * 0.12; 
    

    Paint outerPaint = Paint()
      ..color = Color.fromARGB(199, 151, 0, 252)
      ..strokeWidth = th
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint lightTopPaint = Paint()
      ..color = Color(0XFFD197F9)
      ..style = PaintingStyle.fill;

    Paint lightSmallPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = th*0.09
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Paint arcPaint = Paint()
      ..color = Color.fromARGB(255, 173, 118, 210)
       ..strokeWidth = th*0.06
      ..style = PaintingStyle.fill;

    Paint minilinePaint = Paint()
      ..color = Color.fromARGB(255, 24, 41, 0)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = th*0.06;
      
    Path outerPath = Path()
      ..moveTo(side, 0)
      ..lineTo(sw - side, 0)
      ..quadraticBezierTo(sw, 0, sw, sh/2)
      ..quadraticBezierTo(sw, sh, sw - side, sh)
      ..lineTo(side, sh)
      ..quadraticBezierTo(0, sh, 0, sh/2)
      ..quadraticBezierTo(0, 0, side, 0);
      
      
    Path lightTop = Path()
      ..moveTo(-th, sh/2)
      ..quadraticBezierTo(0, 0, side, -th/3)
      ..lineTo(sw-side, -th/3)
      ..quadraticBezierTo(sw, 0, sw+th, sh/2)
      ..quadraticBezierTo(sw, 0, sw-side, th/20)
      ..lineTo(side, th/20)
      ..quadraticBezierTo(0, 0, -th, sh/2);

        Path lightBottom = Path()
      ..moveTo(-th, sh/2)
      ..quadraticBezierTo(0, sh, side, sh+th/3)
      ..lineTo(sw-side, sh+th/3)
      ..quadraticBezierTo(sw, sh, sw+th, sh/2)
      ..quadraticBezierTo(sw, sh, sw-side, sh - th/20)
      ..lineTo(side, sh - th/20)
      ..quadraticBezierTo(0, sh, -th, sh/2);

    Path lightSmallTop = Path()
      ..moveTo(side*0.8, th*0.3)
      ..lineTo(sw-side*0.8, th*0.3);

    Path miniLineTop = Path()
      ..moveTo(side*0.8, th/3)
      ..lineTo(sw - side*0.8, th/3);

    Path miniLineBottom = Path()
      ..moveTo(side*0.8, sh+th/3)
      ..lineTo(sw - side*0.8, sh+th/3);

    Path lightSmallBottom = Path()
      ..moveTo(side*0.8, sh -th*0.3)
      ..lineTo(sw-side*0.8, sh -th*0.3);



    Path leftArc = Path()
      ..moveTo(side, -th/2)
      ..quadraticBezierTo(0, 0, -th/2, sh/2)
      ..quadraticBezierTo(0, sh, side, sh)
      ..quadraticBezierTo(0, sh, 0, sh/2)
      ..quadraticBezierTo(0, 0, side, -th/2);

    Path rightArc = Path()
      ..moveTo(sw - side, th/2)
      ..quadraticBezierTo(sw, 0, sw + th/2, sh/2)
      ..quadraticBezierTo(sw, sh, sw-side, sh)
      ..quadraticBezierTo(sw, sh, sw, sh/2)
      ..quadraticBezierTo(sw, 0, sw-side, th/2);


    Float64List matrix4 = Float64List.fromList([1,0,0,0,
                              0,0.3,0,0,
                              0,0,1,0,
                              0,0,0,1,]);


    canvas.drawShadow(outerPath.transform(matrix4).shift(Offset(0,-sh)), Color.fromARGB(208, 151, 0, 252), sh, true);
    canvas.drawShadow(outerPath.transform(matrix4).shift(Offset(0,0)), Color.fromARGB(188, 151, 0, 252), sh, true);

    canvas.drawPath(outerPath, outerPaint);
    canvas.drawPath(lightTop, lightTopPaint);
    canvas.drawPath(miniLineTop, minilinePaint);
    canvas.drawPath(miniLineBottom, minilinePaint);
    canvas.drawPath(lightBottom, lightTopPaint);
    canvas.drawPath(lightSmallTop, lightSmallPaint);
    canvas.drawPath(lightSmallBottom, lightSmallPaint);
    canvas.drawPath(leftArc, arcPaint);
    canvas.drawPath(rightArc, arcPaint);

  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}