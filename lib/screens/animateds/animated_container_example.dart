import 'package:animation_widgets/controls/example_header.dart';
import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import '../../controls/animation_control.dart';
import '../../controls/animation_container.dart';
import '../../curves/curves_data.dart';

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

  int _duration = 600;

  AnimationController animationController;

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
    double itemWidth = ((_count % 3) + 1) * 70;
    double itemHeight = ((_count % 3) + 1) * 60;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        /*crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,*/
        children: <Widget>[
          ExampleHeader(
              title: 'AnimatedContainer',
              description:
                  'An AnimatedContainer can automatically interpolate between differents values of his properties( width, height, color, padding).'),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 100),
            child: AnimationControl(
              duration: _duration,
              curve: _currentCurve,
              /*direction: Axis.vertical,*/
              animationController: animationController,
              onDurationChanged: (value) => setState(() {
                _duration += value;
                //animationController.duration = _duration;
              }),
              onCurveChanged: (curve) => setState(() => _currentCurve = curve),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 300),
            child: AnimationContainer(
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
            ),
          )
        ],
      ),
    );
  }
}
