import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

import 'curves_data.dart';

class CurvePainter extends CustomPainter {
  CurvePainter(this.value, this.anim, {this.thumbMode = false});

  final CurvedAnimation anim;
  final bool thumbMode;

  final double value;
  //final AnimationController controller;

  double _heightRef;
  double _widthRef;

  @override
  void paint(Canvas canvas, Size size) {
    final points = anim != null ? generateCurveValues(anim, divisions) : [];
    _heightRef = size.height * .8;
    _widthRef = size.width;
    _drawAxis(canvas, size);
    _drawCurve(canvas, points, size);
    if (!thumbMode) _drawCurrentValueMarker(canvas, size, points);
  }

  void _drawCurrentValueMarker(Canvas canvas, Size size, List<double> points) {
    canvas.drawCircle(
      Offset(value * _widthRef,
          points[(value * (divisions - 1)).floor()] * (_heightRef * 1.1)),
      5.0,
      Paint()..color = Colors.cyan.shade800,
    );
  }

  void _drawCurve(Canvas canvas, List<double> points, Size size) {
    enumerate(points)
        .map((y) => Offset(
              y.index / divisions * _widthRef,
              y.value * _heightRef * 1.1,
            ))
        .forEach((p) => canvas.drawCircle(p, 1, ptPaint));

    /* FIXME when flutter web implements canvas.drawPoints
    canvas.drawPoints(
      PointMode.polygon,
      enumerate(points)
          .map((y) => Offset(
                y.index / divisions * _widthRef,
                y.value * _heightRef,
              ))
          .toList(),
      ptPaint,
    );*/
  }

  void _drawAxis(Canvas canvas, Size size) {
    if (!thumbMode) {
      _paintText(canvas, 'time', Offset(_widthRef, _heightRef) - Offset(30, 18),
          _widthRef);
      _paintText(canvas, 'value', Offset(10, 0), _widthRef);
    }

    canvas.drawLine(Offset(0, _heightRef * 1.1),
        Offset(_widthRef, _heightRef * 1.1), axisPaint);
    canvas.drawLine(
        Offset(0, _heightRef * 0.1), Offset(0, _heightRef * 1.1), axisPaint);
  }

  TextPainter _paintText(
          Canvas canvas, String text, Offset offset, double width) =>
      TextPainter(
          text: TextSpan(text: text, style: TextStyle(color: Colors.black)),
          textDirection: TextDirection.ltr)
        ..layout(maxWidth: width)
        ..paint(canvas, offset);

  @override
  bool shouldRepaint(CurvePainter oldDelegate) => true;
}

List<double> generateCurveValues(CurvedAnimation anim, int divisions) =>
    List.generate(
        divisions, (index) => 1 - anim.curve.transform(index / divisions));
