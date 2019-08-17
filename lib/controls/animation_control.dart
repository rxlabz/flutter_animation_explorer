import 'package:flutter/material.dart';

import 'duration_control.dart';
import 'field_container.dart';
import '../curves/curves_menu.dart';

const _gap = 10.0;

class AnimationControl extends StatelessWidget {
  final Axis direction;
  final int duration;
  final Curve curve;
  final AnimationController animationController;
  final ValueChanged<int> onDurationChanged;
  final ValueChanged<Curve> onCurveChanged;

  const AnimationControl({
    Key key,
    @required this.curve,
    @required this.duration,
    @required this.animationController,
    @required this.onDurationChanged,
    @required this.onCurveChanged,
    this.direction = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onMobile = MediaQuery.of(context).size.shortestSide <= 640;
    return Flex(
      direction: onMobile ? Axis.vertical : Axis.horizontal,
      children: <Widget>[
        Expanded(
          child: DurationControl(
            duration: duration,
            onDurationChange: duration > 100 ? onDurationChanged : null,
          ),
        ),
        SizedBox(
          width: _gap,
          height: _gap,
        ),
        Expanded(
          child: FieldContainer(
            child: CurvesThumbMenu(
              currentCurve: curve,
              onCurveChanged: onCurveChanged,
              animController: animationController,
            ),
          ),
        ),
      ],
    );
  }
}
