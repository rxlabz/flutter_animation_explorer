import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import '../controls/duration_control.dart';
import '../curves/curves_menu.dart';

class AnimatedOpacityExample extends StatefulWidget {
  final ChangeNotifier controller;

  const AnimatedOpacityExample({Key key, this.controller}) : super(key: key);

  @override
  _AnimatedOpacityExampleState createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample>
    with TickerProviderStateMixin {
  bool opaque = true;

  int _duration = 1000;

  Curve _currentCurve = Curves.linear;

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

  onAnimationStart() => setState(() => opaque = !opaque);

  @override
  Widget build(BuildContext context) {
    final animationController =
        AnimationController(duration: aSecond, vsync: this);
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
          AnimatedOpacity(
            curve: _currentCurve,
            duration: aMillisecond * _duration,
            opacity: opaque ? 1 : .2,
            child: Container(
              color: Colors.pink,
              height: 200,
              width: 200,
              child: Center(
                  child: Text(
                'Animated Opacity ${opaque ? 1 : 0.2}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}
