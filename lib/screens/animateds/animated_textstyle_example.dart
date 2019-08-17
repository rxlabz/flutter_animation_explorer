import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import '../../controls/animation_control.dart';
import '../../controls/animation_container.dart';
import '../../controls/example_header.dart';

class AnimatedTextExample extends StatefulWidget {
  final ChangeNotifier controller;

  const AnimatedTextExample({Key key, this.controller}) : super(key: key);

  @override
  _AnimatedTextExampleState createState() => _AnimatedTextExampleState();
}

class _AnimatedTextExampleState extends State<AnimatedTextExample>
    with TickerProviderStateMixin {
  AnimationController animationController;

  int _duration = 600;

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ExampleHeader(
                title: 'AnimatedDefaultTextStyle',
                description:
                    'An AnimatedDefaultTextStyle can automatically interpolate between text style properties values (fontSize, color...).'),
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
                child: Container(
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
