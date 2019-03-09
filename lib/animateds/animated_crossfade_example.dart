import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import '../controls/duration_control.dart';
import '../curves/curves_menu.dart';

class AnimatedCrossFadeExample extends StatefulWidget {
  final ChangeNotifier controller;

  const AnimatedCrossFadeExample({Key key, this.controller}) : super(key: key);

  @override
  _AnimatedCrossFadeExampleState createState() =>
      _AnimatedCrossFadeExampleState();
}

class _AnimatedCrossFadeExampleState extends State<AnimatedCrossFadeExample>
    with TickerProviderStateMixin {
  int _duration = 1000;

  bool _first = true;

  Curve _firstCurve = Curves.linear;

  Curve _secondCurve = Curves.linear;

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 60,
                      child: Text('First'),
                    ),
                    Flexible(
                      child: CurvesThumbMenu(
                        currentCurve: _firstCurve,
                        onCurveChanged: (curve) =>
                            setState(() => _firstCurve = curve),
                        animationController: animationController,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 60,
                      child: Text('Second'),
                    ),
                    Flexible(
                      child: CurvesThumbMenu(
                        currentCurve: _secondCurve,
                        onCurveChanged: (curve) =>
                            setState(() => _secondCurve = curve),
                        animationController: animationController,
                      ),
                    ),
                  ],
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
          AnimatedCrossFade(
            firstCurve: _firstCurve,
            secondCurve: _secondCurve,
            sizeCurve: _firstCurve,
            duration: aMillisecond * _duration,
            firstChild: ExampleBox(
                key: Key('b1'), text: 'BOX 1', color: Colors.blue, width: 150),
            secondChild: ExampleBox(
                key: Key('b2'), text: 'BOX 2', color: Colors.green, width: 250),
            crossFadeState:
                _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
        ],
      ),
    );
  }
}

class ExampleBox extends StatelessWidget {
  final String text;
  final Color color;
  final double width;

  const ExampleBox({Key key, this.text, this.color, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 150,
      width: width,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
