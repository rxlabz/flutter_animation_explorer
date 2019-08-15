import 'package:flutter/material.dart';

import '../controls/duration_control.dart';
import 'staggered/animation_timeline.dart';
import 'staggered/staggered_animation.dart';

final _defaultCurve = Curves.bounceIn;
final _defaultDuration = 2000;

const _padding = const EdgeInsets.all(8.0);

class StaggeredScreen extends StatefulWidget {
  @override
  _StaggeredScreenState createState() => _StaggeredScreenState();
}

class _StaggeredScreenState extends State<StaggeredScreen>
    with SingleTickerProviderStateMixin {
  Color currentColor;

  AnimationIntervalValue<double> currentLeft = AnimationIntervalValue(
    interval: Interval(0, .5),
    start: 10,
    end: 150,
    value: 10,
    curve: _defaultCurve,
  );

  AnimationIntervalValue<double> currentTop = AnimationIntervalValue(
    interval: Interval(0.5, 1),
    start: 10,
    end: 80,
    value: 10,
    curve: _defaultCurve,
  );

  AnimationIntervalValue<double> currentWidth = AnimationIntervalValue(
    interval: Interval(0, 1),
    start: 20,
    end: 150,
    value: 20,
    curve: _defaultCurve,
  );

  AnimationIntervalValue<double> currentHeight = AnimationIntervalValue(
    interval: Interval(0, 1),
    start: 20,
    end: 50,
    value: 20,
    curve: _defaultCurve,
  );

  AnimationIntervalValue<double> currentOpacity = AnimationIntervalValue(
    interval: Interval(0, 1),
    start: 0.2,
    end: 1.0,
    value: 0.2,
    curve: _defaultCurve,
  );

  AnimationController animationController;

  TextEditingController _leftStartFieldController;

  TextEditingController _leftEndFieldController;

  TextEditingController _topStartFieldController;

  TextEditingController _topEndFieldController;

  TextEditingController _widthStartFieldController;

  TextEditingController _widthEndFieldController;

  TextEditingController _heightStartFieldController;

  TextEditingController _heightEndFieldController;

  int _duration = _defaultDuration;

  StaggeredAnimationModel _model;

  Animation<double> _leftTween;
  Animation<double> _topTween;
  Animation<double> _widthTween;
  Animation<double> _heightTween;
  Animation<double> _opacityTween;

  @override
  void initState() {
    animationController = AnimationController(
        value: 0, duration: Duration(milliseconds: _duration), vsync: this)
      ..addListener(() => _updateAnimation());

    _leftStartFieldController =
        TextEditingController(text: '${currentLeft.start}')
          ..addListener(() {
            final newLeft = double.parse(_leftStartFieldController.text);
            setState(() {
              currentLeft = currentLeft.copyWith(newStart: newLeft);
              _model = _model.copyWith(
                  newLeft: currentLeft.copyWith(newStart: newLeft));
              _updateAnimation();
            });
          });

    _leftEndFieldController = TextEditingController(text: '${currentLeft.end}')
      ..addListener(() {
        final newLeft = double.parse(_leftEndFieldController.text);
        setState(() {
          currentLeft = currentLeft.copyWith(newEnd: newLeft);
          _model =
              _model.copyWith(newLeft: currentLeft.copyWith(newEnd: newLeft));
          _updateAnimation();
        });
      });

    _topStartFieldController =
        TextEditingController(text: '${currentLeft.start}')
          ..addListener(() {
            final newTop = double.parse(_topStartFieldController.text);
            setState(() {
              _model = _model.copyWith(
                  newTop: currentTop.copyWith(newStart: newTop));
              _updateAnimation();
            });
          });

    _topEndFieldController = TextEditingController(text: '${currentLeft.end}')
      ..addListener(() {
        final newTop = double.parse(_topStartFieldController.text);
        setState(() {
          _model = _model.copyWith(newTop: currentTop.copyWith(newEnd: newTop));
          _updateAnimation();
        });
      });

    _widthStartFieldController =
        TextEditingController(text: '${currentWidth.start}')
          ..addListener(() {
            final newWidth = double.parse(_widthStartFieldController.text);
            setState(() {
              _model = _model.copyWith(
                  newWidth: currentWidth.copyWith(newStart: newWidth));
              _updateAnimation();
            });
          });

    _widthEndFieldController =
        TextEditingController(text: '${currentWidth.end}')
          ..addListener(() {
            final newWidth = double.parse(_widthStartFieldController.text);
            setState(() {
              _model = _model.copyWith(
                  newWidth: currentWidth.copyWith(newEnd: newWidth));
              _updateAnimation();
            });
          });

    _heightStartFieldController =
        TextEditingController(text: '${currentHeight.start}')
          ..addListener(() {
            final newHeight = double.parse(_heightStartFieldController.text);
            setState(() {
              _model = _model.copyWith(
                  newHeight: currentHeight.copyWith(newStart: newHeight));
              _updateAnimation();
            });
          });

    _heightEndFieldController =
        TextEditingController(text: '${currentHeight.end}')
          ..addListener(() {
            final newHeight = double.parse(_heightStartFieldController.text);
            setState(() {
              _model = _model.copyWith(
                  newHeight: currentHeight.copyWith(newEnd: newHeight));
              _updateAnimation();
            });
          });

    _model = StaggeredAnimationModel(
      left: currentLeft,
      top: currentTop,
      width: currentWidth,
      height: currentHeight,
      opacity: currentOpacity,
    );
    _updateTweens();
    super.initState();
  }

  void _updateTweens() {
    _leftTween = _initTween(currentLeft);
    _topTween = _initTween(currentTop);
    _widthTween = _initTween(currentWidth);
    _heightTween = _initTween(currentHeight);
    _opacityTween = _initTween(currentOpacity);
  }

  Animation _initTween(AnimationIntervalValue value) =>
      Tween<double>(begin: value.start, end: value.end).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(
              value.interval.begin,
              value.interval.end,
              curve: value.curve,
            )),
      );

  void _updateAnimation() {
    _model = StaggeredAnimationModel(
      left: currentLeft.copyWith(newValue: _leftTween.value),
      top: currentTop.copyWith(newValue: _topTween.value),
      width: currentWidth.copyWith(newValue: _widthTween.value),
      height: currentHeight.copyWith(newValue: _heightTween.value),
      opacity: currentOpacity.copyWith(newValue: _opacityTween.value),
    );
    _updateTweens();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: _padding,
            child: RaisedButton.icon(
              onPressed: () => animationController.forward(),
              icon: Icon(Icons.play_arrow),
              label: Text('forward'),
            ),
          ),
          Padding(
            padding: _padding,
            child: RaisedButton.icon(
              onPressed: () => animationController.reverse(),
              icon: Icon(Icons.settings_backup_restore),
              label: Text('Reverse'),
            ),
          ),
        ],
      ),
      ConstrainedBox(
        constraints: BoxConstraints.expand(height: 200),
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, widget) => StaggeredAnimation(model: _model)),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AnimatedBuilder(
                animation: animationController,
                builder: (context, widget) => Column(
                  children: <Widget>[
                    Padding(padding: _padding, child: _buildDurationRow()),
                    Slider(value: animationController.value, onChanged: null),
                  ],
                ),
              ),
              _buildTimelineItemField(
                  label: 'Position : Left',
                  value: currentLeft,
                  startController: _leftStartFieldController,
                  endController: _leftEndFieldController,
                  onIntervalChanged: (value) => setState(() {
                        currentLeft = value;
                        _leftTween = _initTween(currentLeft);
                      })),
              _buildTimelineItemField(
                  label: 'Position : Top',
                  value: currentTop,
                  startController: _topStartFieldController,
                  endController: _topEndFieldController,
                  onIntervalChanged: (value) => setState(() {
                        currentTop = value;
                        _topTween = _initTween(currentTop);
                      })),
              _buildTimelineItemField(
                  label: 'Size : Width',
                  value: currentWidth,
                  startController: _widthStartFieldController,
                  endController: _widthEndFieldController,
                  onIntervalChanged: (value) => setState(() {
                        currentWidth = value;
                        _widthTween = _initTween(currentWidth);
                      })),
              _buildTimelineItemField(
                  label: 'Size : Height',
                  value: currentHeight,
                  startController: _heightStartFieldController,
                  endController: _heightEndFieldController,
                  onIntervalChanged: (value) => setState(() {
                        currentHeight = value;
                        _heightTween = _initTween(currentHeight);
                      })),
              _buildOpacityTimelineRow(),
            ],
          ),
        ),
      )
    ]);
  }

  AnimationTimelineRow _buildOpacityTimelineRow() {
    return AnimationTimelineRow(
        label: 'Opacity',
        controller: animationController,
        animationIntervalValue: currentOpacity,
        fields: [
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: Slider(
                    value: currentOpacity.start,
                    onChanged: (value) => setState(() {
                          currentOpacity =
                              currentOpacity.copyWith(newStart: value);
                          _heightTween = _initTween(currentHeight);
                        })),
              ),
              Expanded(
                child: Slider(
                    value: currentOpacity.end,
                    onChanged: (value) => setState(() {
                          currentOpacity =
                              currentOpacity.copyWith(newEnd: value);
                          _heightTween = _initTween(currentHeight);
                        })),
              ),
            ],
          ))
        ],
        onIntervalChanged: (value) => setState(() {
              currentOpacity = value;
              _opacityTween = _initTween(currentOpacity);
            }));
  }

  Widget _buildTimelineItemField(
      {String label,
      AnimationIntervalValue value,
      TextEditingController startController,
      TextEditingController endController,
      onIntervalChanged}) {
    final fieldStyle = const TextStyle(fontSize: 13);
    return AnimationTimelineRow(
      label: label,
      controller: animationController,
      animationIntervalValue: value,
      fields: [
        Expanded(
            child: Row(
          children: <Widget>[
            Text('Start'),
            Expanded(
              child: Padding(
                  padding: _padding,
                  child: TextField(
                      controller: startController, style: fieldStyle)),
            ),
            Text('End'),
            Expanded(
              child: Padding(
                padding: _padding,
                child: TextField(controller: endController, style: fieldStyle),
              ),
            ),
          ],
        ))
      ],
      onIntervalChanged: onIntervalChanged,
    );
  }

  void _onDurationChanged(value) => _duration > 100
      ? setState(() => _updateAnimationController(value))
      : null;

  void _updateAnimationController(int value) {
    final msDuration = animationController.duration.inMilliseconds + value;
    animationController.duration = Duration(milliseconds: msDuration);
  }

  Widget _buildDurationRow() {
    final progress = (animationController.value * 100).toInt();
    return Row(
      children: <Widget>[
        Text('Duration'),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DurationControl(
                duration: animationController.duration.inMilliseconds,
                onDurationChange: _onDurationChanged,
              ),
              Text('$progress %')
            ],
          ),
        )
      ],
    );
  }
}
