import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import '../controls/duration_control.dart';
import '../curves/curves_data.dart';
import '../curves/curves_menu.dart';

class AnimatedAlignExample extends StatefulWidget {
  final ChangeNotifier controller;

  const AnimatedAlignExample({Key key, this.controller}) : super(key: key);

  @override
  _AnimatedAlignExampleState createState() => _AnimatedAlignExampleState();
}

class _AnimatedAlignExampleState extends State<AnimatedAlignExample>
    with TickerProviderStateMixin {
  double count = 1;

  int _duration = 1000;

  List<AlignmentDirectional> positions = [
    AlignmentDirectional.topCenter,
    AlignmentDirectional.centerStart,
    AlignmentDirectional.bottomEnd,
    AlignmentDirectional.centerEnd,
    AlignmentDirectional.topStart,
    AlignmentDirectional.bottomStart,
    AlignmentDirectional.center,
  ];

  AlignmentGeometry _currentAlign = AlignmentDirectional.center;

  Curve _currentCurve = curves.first.curve;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onAnimationStart);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(onAnimationStart);
  }

  onAnimationStart() => setState(() => count += 1);

  @override
  Widget build(BuildContext context) {
    final animationController =
        AnimationController(duration: aSecond, vsync: this);
    _currentAlign = positions[(count % positions.length).toInt()];
    return SizedBox.expand(
      child: Column(
        children: <Widget>[
          CurvesThumbMenu(
            currentCurve: _currentCurve,
            onCurveChanged: (curve) => setState(() => _currentCurve = curve),
            animationController: animationController,
          ),
          DurationControl(
            duration: _duration,
            onDurationChange: (value) =>
                _duration > 100 ? setState(() => _duration += value) : null,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                AnimatedAlign(
                  curve: _currentCurve,
                  alignment: _currentAlign,
                  duration: aMillisecond * _duration,
                  child: Container(
                    color: Colors.blue,
                    height: 150,
                    width: 200,
                    child: Center(
                        child: Text(
                      'Animated Align : '
                          '${_currentAlign.toString().split('.').last}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
