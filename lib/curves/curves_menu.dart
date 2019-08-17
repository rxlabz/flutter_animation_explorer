import 'package:flutter/material.dart';

import '../curves/curve_painter.dart';
import 'curves_data.dart';

class CurvesMenu extends StatelessWidget {
  final Curve currentCurve;
  final ValueChanged<Curve> onCurveChanged;

  const CurvesMenu({Key key, this.currentCurve, this.onCurveChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) => DropdownButton(
        value: currentCurve,
        items: curves.map(_buildCurveMenuItem).toList(),
        onChanged: onCurveChanged,
      );

  DropdownMenuItem<Curve> _buildCurveMenuItem(NamedCurve c) => DropdownMenuItem(
      value: c.curve,
      child: Text(
        '${c.name}',
        style: TextStyle(fontSize: 13),
      ));
}

class CurvesThumbMenu extends StatelessWidget {
  final Curve currentCurve;
  final ValueChanged<Curve> onCurveChanged;
  final AnimationController animController;

  const CurvesThumbMenu({
    Key key,
    this.currentCurve,
    this.onCurveChanged,
    @required this.animController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Curve',
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
            Expanded(
              child: DropdownButton(
                iconSize: 32,
                iconEnabledColor: Colors.pink,
                isExpanded: true,
                value: currentCurve,
                items: curves
                    .map((c) => _buildCurveMenuItem(
                        c,
                        CurvedAnimation(
                            curve: c.curve, parent: animController)))
                    .toList(),
                onChanged: onCurveChanged,
              ),
            ),
          ],
        ),
      );

  DropdownMenuItem<Curve> _buildCurveMenuItem(
          NamedCurve c, CurvedAnimation curvedAnimation) =>
      DropdownMenuItem(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    '${c.name}',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 100,
                    minWidth: 50,
                    minHeight: 100,
                  ),
                  child: CustomPaint(
                    willChange: false,
                    painter: CurvePainter(
                      animController.value,
                      curvedAnimation,
                      thumbMode: true,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        value: c.curve,
      );
}
