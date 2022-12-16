import 'package:flutter/material.dart';

class ClipBackGround extends CustomClipper<Path> {
  final double cSize;
  ClipBackGround(this.cSize);
  @override
  getClip(Size size) {
    var path = Path();
    var cPoint = Offset(size.width / 2, cSize);
    var ePoint = Offset(0, 0);
    path.moveTo(size.width, 0);
    path.quadraticBezierTo(cPoint.dx, cPoint.dy, ePoint.dx, ePoint.dy);
    //path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}