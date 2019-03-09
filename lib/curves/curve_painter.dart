import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

import 'curves_data.dart';

class CurvePainter extends CustomPainter {
  CurvePainter(this.controller, this.anim, {this.thumbMode = false});

  final CurvedAnimation anim;
  final bool thumbMode;

  final AnimationController controller;

  @override
  void paint(Canvas canvas, Size size) {
    final points = generateCurveValues(anim, divisions);
    _drawAxis(canvas, size);
    _drawCurve(canvas, points, size);
    if (!thumbMode) _drawCurrentValueMarker(canvas, size, points);
  }

  void _drawCurrentValueMarker(Canvas canvas, Size size, List<double> points) {
    canvas.drawCircle(
      Offset(controller.value * size.width,
          points[(controller.value * (divisions - 1)).floor()] * size.height),
      5.0,
      Paint()..color = Colors.pink,
    );
  }

  void _drawCurve(Canvas canvas, List<double> points, Size size) {
    canvas.drawPoints(
      PointMode.polygon,
      enumerate(points)
          .map((y) => Offset(
                y.index / divisions * size.width,
                y.value * size.height,
              ))
          .toList(),
      ptPaint,
    );
  }

  void _drawAxis(Canvas canvas, Size size) {
    if (!thumbMode) {
      _paintText(canvas, 'time',
          Offset(size.width, size.height) - Offset(30, 18), size.width);
      _paintText(canvas, 'value', Offset(10, 0), size.width);
    }

    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), axisPaint);
  }

  TextPainter _paintText(
          Canvas canvas, String text, Offset offset, double width) =>
      TextPainter(
          text: TextSpan(text: text, style: TextStyle(color: Colors.black)),
          textDirection: TextDirection.ltr)
        ..layout(maxWidth: width)
        ..paint(canvas, offset);

  @override
  bool shouldRepaint(CurvePainter oldDelegate) =>
      controller.value != oldDelegate.controller.value;
}

List<double> generateCurveValues(CurvedAnimation anim, int divisions) =>
    List.generate(
        divisions, (index) => 1 - anim.curve.transform(index / divisions));
