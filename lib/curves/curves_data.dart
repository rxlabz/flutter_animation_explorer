import 'package:flutter/material.dart';

const curves = [
  const NamedCurve('Linear', Curves.linear),
  const NamedCurve('Decelerate', Curves.decelerate),
  const NamedCurve('FastLinearToSlowEaseIn', Curves.fastLinearToSlowEaseIn),
  const NamedCurve('Ease', Curves.ease),
  const NamedCurve('EaseIn', Curves.easeIn),
  const NamedCurve('EaseInToLinear', Curves.easeInToLinear),
  const NamedCurve('EaseInSine', Curves.easeInSine),
  const NamedCurve('EaseInQuad', Curves.easeInQuad),
  const NamedCurve('EaseInCubic', Curves.easeInCubic),
  const NamedCurve('EaseInQuart', Curves.easeInQuart),
  const NamedCurve('EaseInQuint', Curves.easeInQuint),
  const NamedCurve('EaseInExpo', Curves.easeInExpo),
  const NamedCurve('EaseInCirc', Curves.easeInCirc),
  const NamedCurve('EaseInBack', Curves.easeInBack),
  const NamedCurve('EaseOut', Curves.easeOut),
  const NamedCurve('LinearToEaseOut', Curves.linearToEaseOut),
  const NamedCurve('EaseOutSine', Curves.easeOutSine),
  const NamedCurve('EaseOutQuad', Curves.easeOutQuad),
  const NamedCurve('EaseOutCubic', Curves.easeOutCubic),
  const NamedCurve('EaseOutQuart', Curves.easeOutQuart),
  const NamedCurve('EaseOutQuint', Curves.easeOutQuint),
  const NamedCurve('EaseOutExpo', Curves.easeOutExpo),
  const NamedCurve('EaseOutCirc', Curves.easeOutCirc),
  const NamedCurve('EaseOutBack', Curves.easeOutBack),
  const NamedCurve('EaseInOutSine', Curves.easeInOutSine),
  const NamedCurve('EaseInOut', Curves.easeInOut),
  const NamedCurve('EaseInOutBack', Curves.easeInOutBack),
  const NamedCurve('EaseInOutCirc', Curves.easeInOutCirc),
  const NamedCurve('EaseInOutCubic', Curves.easeInOutCubic),
  const NamedCurve('EaseInOutQuad', Curves.easeInOutQuad),
  const NamedCurve('EaseInOutQuart', Curves.easeInOutQuart),
  const NamedCurve('EaseInOutQuint', Curves.easeInOutQuint),
  const NamedCurve('EaseInOutExpo', Curves.easeInOutExpo),
  const NamedCurve('FastOutSlowIn', Curves.fastOutSlowIn),
  const NamedCurve('BounceIn', Curves.bounceIn),
  const NamedCurve('BounceInOut', Curves.bounceInOut),
  const NamedCurve('BounceOut', Curves.bounceOut),
  const NamedCurve('ElasticIn', Curves.elasticIn),
  const NamedCurve('ElasticOut', Curves.elasticOut),
  const NamedCurve('ElasticInOut', Curves.elasticInOut),
];

final axisPaint = Paint()
  ..color = Colors.grey.shade400
  ..strokeWidth = 2;

final ptPaint = Paint()
  ..color = Colors.cyan
  ..strokeWidth = 2;

const divisions = 500;

class NamedCurve {
  final String name;
  final Curve curve;

  const NamedCurve(this.name, this.curve);
}
