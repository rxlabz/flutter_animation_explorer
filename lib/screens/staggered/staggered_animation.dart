import 'package:flutter/material.dart';

class AnimationIntervalValue<T> {
  final T value;
  final T start;
  final T end;
  final Interval interval;
  final Curve curve;

  AnimationIntervalValue({
    @required this.value,
    @required this.start,
    @required this.end,
    @required this.interval,
    @required this.curve,
  });

  AnimationIntervalValue<T> copyWith({
    T newValue,
    T newEnd,
    T newStart,
    Interval newInterval,
    Curve newCurve,
  }) =>
      AnimationIntervalValue(
        value: newValue ?? value,
        interval: newInterval ?? interval,
        start: newStart ?? start,
        end: newEnd ?? end,
        curve: newCurve ?? curve,
      );
}

class StaggeredAnimationModel {
  final AnimationIntervalValue left;
  final AnimationIntervalValue top;
  final AnimationIntervalValue width;
  final AnimationIntervalValue height;
  final AnimationIntervalValue opacity;

  StaggeredAnimationModel({
    @required this.left,
    @required this.top,
    @required this.width,
    @required this.height,
    @required this.opacity,
  });

  copyWith({
    AnimationIntervalValue newLeft,
    AnimationIntervalValue newTop,
    AnimationIntervalValue newWidth,
    AnimationIntervalValue newHeight,
    AnimationIntervalValue newOpacity,
  }) =>
      StaggeredAnimationModel(
        left: newLeft ?? left,
        top: newTop ?? top,
        width: newWidth ?? width,
        height: newHeight ?? height,
        opacity: newOpacity ?? opacity,
      );
}

class StaggeredAnimation extends StatelessWidget {
  final StaggeredAnimationModel model;

  const StaggeredAnimation({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 3,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: model.left.value,
              top: model.top.value,
              child: Opacity(
                opacity: model.opacity.value,
                child: Container(
                  color: Colors.red,
                  width: model.width.value,
                  height: model.height.value,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
