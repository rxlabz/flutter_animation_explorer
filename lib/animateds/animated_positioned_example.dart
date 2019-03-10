import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import '../controls/duration_control.dart';
import '../curves/curves_data.dart';
import '../curves/curves_menu.dart';

final positions = [
  Rect.fromLTWH(0, 0, 200, 200),
  Rect.fromLTWH(100, 100, 150, 150),
  Rect.fromLTWH(0, 200, 200, 100),
];

class AnimatedPositionedExample extends StatefulWidget {
  final ChangeNotifier controller;

  const AnimatedPositionedExample({Key key, this.controller}) : super(key: key);

  @override
  _AnimatedPositionedExampleState createState() =>
      _AnimatedPositionedExampleState();
}

class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample>
    with TickerProviderStateMixin {
  double count = 1;

  int _duration = 1000;

  Rect _currentPosition = positions.first;

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
    _currentPosition = positions[(count % positions.length).toInt()];

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
                AnimatedPositioned.fromRect(
                  curve: _currentCurve,
                  rect: _currentPosition,
                  duration: aMillisecond * _duration,
                  child: Container(
                    color: Colors.blue,
                    /*height: 150,
                    width: 200,*/
                    child: Center(
                        child: Text(
                      'AnimatedPositioned : '
                          '$_currentPosition',
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
