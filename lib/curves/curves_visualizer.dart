import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:quiver/time.dart';

import '../controls/duration_control.dart';
import 'curve_painter.dart';
import 'curves_data.dart';
import 'curves_menu.dart';

const labelStyle = TextStyle(color: Colors.grey);

class AnimGraphr extends StatefulWidget {
  final AnimationController animationController;

  const AnimGraphr({Key key, this.animationController}) : super(key: key);

  @override
  _AnimGraphrState createState() => _AnimGraphrState();
}

class _AnimGraphrState extends State<AnimGraphr>
    with SingleTickerProviderStateMixin {
  Curve _currentCurve = curves.first.curve;

  CurvedAnimation _curvedAnimation;

  int _duration = 1000;

  bool _animatedSize = true;
  bool _animatedOpacity = true;
  bool _animatedPosition = true;

  get controller => widget.animationController;

  @override
  void initState() {
    super.initState();

    controller..addStatusListener(_onAnimationStatus);
  }

  _onAnimationStatus(status) {
    if (status == AnimationStatus.completed)
      Future.delayed(aSecond, () => controller.reverse());
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeStatusListener(_onAnimationStatus);
  }

  @override
  Widget build(BuildContext context) {
    controller.duration = aMillisecond * _duration;
    _curvedAnimation =
        CurvedAnimation(parent: controller, curve: _currentCurve);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, widget) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CurvesThumbMenu(
                    currentCurve: _currentCurve,
                    onCurveChanged: _onCurveChanged,
                    animController: controller,
                  ),
                ),
                DurationControl(
                  duration: _duration,
                  onDurationChange: (value) => _duration > 100
                      ? setState(() => _duration += value)
                      : null,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints.expand(height: 150),
            child: CustomPaint(
                key: Key('curveGraph'),
                painter: CurvePainter(controller, _curvedAnimation)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('Animate', style: labelStyle)),
                Checkbox(
                    value: _animatedSize,
                    onChanged: (value) =>
                        setState(() => _animatedSize = value)),
                Text('Size'),
                Checkbox(
                    value: _animatedOpacity,
                    onChanged: (value) =>
                        setState(() => _animatedOpacity = value)),
                Text('Opacity'),
                Checkbox(
                    value: _animatedPosition,
                    onChanged: (value) =>
                        setState(() => _animatedPosition = value)),
                Text('Position'),
              ],
            ),
          ),
          AnimationExample(
            value: _curvedAnimation.value,
            animatedSize: _animatedSize,
            animatedOpacity: _animatedOpacity,
            animatedPosition: _animatedPosition,
          ),
        ],
      ),
    );
  }

  void _onCurveChanged(Curve c) => setState(() => _currentCurve = c);
}

class AnimationExample extends StatelessWidget {
  final double value;
  final bool animatedSize;
  final bool animatedOpacity;
  final bool animatedPosition;

  const AnimationExample(
      {Key key,
      this.value,
      this.animatedSize,
      this.animatedOpacity,
      this.animatedPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemWidth = 20 + (value * 100);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints.expand(height: 100),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: animatedPosition
                      ? value * (constraints.maxWidth - itemWidth - 16)
                      : 100,
                  child: Opacity(
                    opacity: animatedOpacity ? min([1, value + .2]) : 1,
                    child: Container(
                        color: Colors.cyan,
                        height: 100,
                        width: animatedSize ? itemWidth : 100),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
