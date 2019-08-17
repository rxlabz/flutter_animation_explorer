import 'package:animation_widgets/examples.dart';
import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import '../../controls/animation_control.dart';
import '../../controls/animation_container.dart';
import '../../controls/example_header.dart';
import '../../controls/theme_code_preview.dart';
import '../../curves/curves_data.dart';

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
  double _count = 1;

  int _duration = 600;

  AnimationController animationController;

  Rect _currentPosition = positions.first;

  Curve _currentCurve = curves.first.curve;

  @override
  void initState() {
    animationController = AnimationController(duration: aSecond, vsync: this);
    widget.controller.addListener(onAnimationStart);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(onAnimationStart);
  }

  onAnimationStart() {
    animationController.forward();
    setState(() => _count += 1);
  }

  @override
  Widget build(BuildContext context) {
    animationController = AnimationController(duration: aSecond, vsync: this);
    _currentPosition = positions[(_count % positions.length).toInt()];

    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ExampleHeader(
                title: 'AnimatedPositioned',
                description:
                    'An AnimatedPositioned can automatically interpolate between multiple positions.'),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 100),
              child: AnimationControl(
                duration: _duration,
                curve: _currentCurve,
                /*direction: Axis.vertical,*/
                animationController: animationController,
                onDurationChanged: (value) =>
                    setState(() => _duration += value),
                onCurveChanged: (curve) =>
                    setState(() => _currentCurve = curve),
              ),
            ),
            Expanded(
              child: AnimationContainer(
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned.fromRect(
                      curve: _currentCurve,
                      rect: _currentPosition,
                      duration: aMillisecond * _duration,
                      child: Container(
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            'AnimatedPositioned : '
                            '$_currentPosition',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ) /*,
            Expanded(
              child: ThemeCodePreview(positionnedExample),
            )*/
          ],
        ),
      ),
    );
  }
}
