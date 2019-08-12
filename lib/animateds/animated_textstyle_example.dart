import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import '../controls/duration_control.dart';
import '../curves/curves_menu.dart';

class AnimatedTextExample extends StatefulWidget {
  final ChangeNotifier controller;

  const AnimatedTextExample({Key key, this.controller}) : super(key: key);

  @override
  _AnimatedTextExampleState createState() => _AnimatedTextExampleState();
}

class _AnimatedTextExampleState extends State<AnimatedTextExample>
    with TickerProviderStateMixin {
  int _duration = 1000;

  bool _first = true;

  final TextStyle style1 = TextStyle(color: Colors.red, fontSize: 32);

  final TextStyle style2 =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);

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

  onAnimationStart() => setState(() => _first = !_first);

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
            animController: animationController,
          ),
          DurationControl(
            duration: _duration,
            onDurationChange: (value) =>
                _duration > 100 ? setState(() => _duration += value) : null,
          ),
          Container(
            height: 300,
            width: 200,
            child: Center(
              child: AnimatedDefaultTextStyle(
                curve: _currentCurve,
                duration: aMillisecond * _duration,
                style: _first ? style1 : style2,
                child: Column(
                  children: <Widget>[
                    Text('Animated Text'),
                    Text('Lorem ipsum...'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
