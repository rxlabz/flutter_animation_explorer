import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import '../controls/duration_control.dart';
import '../curves/curves_data.dart';
import '../curves/curves_menu.dart';

class AnimatedContainerExample extends StatefulWidget {
  final ChangeNotifier controller;

  const AnimatedContainerExample({Key key, this.controller}) : super(key: key);

  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample>
    with TickerProviderStateMixin {
  double _count = 1;

  Curve _currentCurve = curves.first.curve;

  int _duration = 1000;

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

  onAnimationStart() => setState(() => _count += 1);

  @override
  Widget build(BuildContext context) {
    final animationController =
        AnimationController(duration: aSecond, vsync: this);
    double itemWidth = ((_count % 3) + 1) * 100;
    double itemHeight = ((_count % 3) + 1) * 60;
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            child: Center(
              child: AnimatedContainer(
                duration: aMillisecond * _duration,
                curve: _currentCurve,
                color: Colors.primaries[(_count % 8).floor()],
                height: itemHeight,
                width: itemWidth,
                child: Center(
                    child: Text(
                  'Animated Container',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
