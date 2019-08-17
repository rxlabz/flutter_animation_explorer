import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import '../../controls/animation_container.dart';
import '../../controls/animation_control.dart';
import '../../controls/example_header.dart';
import '../../curves/curves_data.dart';

class AnimatedAlignExample extends StatefulWidget {
  final ChangeNotifier controller;

  const AnimatedAlignExample({Key key, this.controller}) : super(key: key);

  @override
  _AnimatedAlignExampleState createState() => _AnimatedAlignExampleState();
}

class _AnimatedAlignExampleState extends State<AnimatedAlignExample>
    with TickerProviderStateMixin {
  AnimationController animationController;

  double _count = 1;

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
    animationController = AnimationController(duration: aSecond, vsync: this);
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
    _currentAlign = positions[(_count % positions.length).toInt()];
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ExampleHeader(
                title: 'AnimatedAlign',
                description:
                    'An AnimatedAlign automatically interpolate between the widget alignment values.'),
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
            ),
          ],
        ),
      ),
    );
  }
}
