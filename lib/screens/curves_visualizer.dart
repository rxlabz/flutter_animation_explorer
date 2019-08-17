import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:quiver/time.dart';

import '../controls/animation_control.dart';
import '../controls/animation_container.dart';
import '../controls/example_header.dart';
import '../controls/theme_code_preview.dart';
import '../curves/curve_painter.dart';
import '../curves/curves_data.dart';
import '../examples.dart';

class CurveVisualizer extends StatefulWidget {
  const CurveVisualizer({Key key}) : super(key: key);

  @override
  _CurveVisualizerState createState() => _CurveVisualizerState();
}

class _CurveVisualizerState extends State<CurveVisualizer>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AnimationController animationController;

  Curve _currentCurve = curves.first.curve;

  CurvedAnimation _curvedAnimation;

  int _duration = 1000;

  bool _animatedSize = true;
  bool _animatedOpacity = true;
  bool _animatedPosition = true;

  final _fieldBorder = BoxDecoration(
      color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8));

  get running => animationController.status != AnimationStatus.dismissed;

  @override
  void initState() {
    animationController =
        AnimationController(duration: aMillisecond * _duration, vsync: this)
          ..addStatusListener(_onAnimationStatus);
    super.initState();
  }

  _onAnimationStatus(status) {
    if (status == AnimationStatus.completed)
      Future.delayed(aSecond, () => animationController.reverse());
  }

  @override
  void dispose() {
    super.dispose();
    animationController.removeStatusListener(_onAnimationStatus);
  }

  @override
  Widget build(BuildContext context) {
    animationController.duration = aMillisecond * _duration;
    _curvedAnimation =
        CurvedAnimation(parent: animationController, curve: _currentCurve);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Flutter animations : Curves'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.code),
            onPressed: _openCodePreview,
          )
        ],
      ),
      endDrawer: Drawer(
        child:
            SizedBox(width: 600, child: ThemeCodePreview(curve_example_code)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: running ? Colors.grey : Colors.pink,
        child: Icon(Icons.play_arrow),
        onPressed: running ? null : animationController.forward,
      ),
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, widget) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ExampleHeader(
                  title: 'Animation curves explorer',
                  description:
                      'You can apply various kinds of acceleration/deceleration to your animations. You can select them from Curves static properties.'),
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: _fieldBorder,
                  padding: const EdgeInsets.all(12),
                  constraints: BoxConstraints.expand(height: 150),
                  child: CustomPaint(
                      key: Key('curveGraph'),
                      painter:
                          CurvePainter(animationController, _curvedAnimation)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Animate',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    Checkbox(
                        activeColor: Colors.pink,
                        value: _animatedSize,
                        onChanged: (value) =>
                            setState(() => _animatedSize = value)),
                    Text('Size'),
                    Checkbox(
                        activeColor: Colors.pink,
                        value: _animatedOpacity,
                        onChanged: (value) =>
                            setState(() => _animatedOpacity = value)),
                    Text('Opacity'),
                    Checkbox(
                        activeColor: Colors.pink,
                        value: _animatedPosition,
                        onChanged: (value) =>
                            setState(() => _animatedPosition = value)),
                    Text('Position'),
                  ],
                ),
              ),
              AnimationContainer(
                child: AnimationExample(
                  value: _curvedAnimation.value,
                  animatedSize: _animatedSize,
                  animatedOpacity: _animatedOpacity,
                  animatedPosition: _animatedPosition,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openCodePreview() {
    _scaffoldKey.currentState.openEndDrawer();
  }
}

class AnimationExample extends StatelessWidget {
  final double value;
  final bool animatedSize;
  final bool animatedOpacity;
  final bool animatedPosition;

  const AnimationExample(
      {Key key,
      this.value,
      this.animatedSize,
      this.animatedOpacity,
      this.animatedPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemWidth = 20 + (value * 100);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints.expand(height: 100),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: animatedPosition
                      ? value * (constraints.maxWidth - itemWidth - 16)
                      : 100,
                  child: Opacity(
                    opacity: animatedOpacity ? min([1, value + .2]) : 1,
                    child: Container(
                        color: Colors.cyan,
                        height: 100,
                        width: animatedSize ? itemWidth : 100),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
