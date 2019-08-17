import 'dart:math';

import 'package:animation_widgets/curves/curves_menu.dart';
import 'package:flutter/material.dart';

import 'staggered_animation.dart';

final _padding = const EdgeInsets.all(8.0);

final _fieldBorder =
    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8));

final _headerBorder = BoxDecoration(
    color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8));

class AnimationTimelineRow<T> extends StatefulWidget {
  final AnimationController controller;
  final AnimationIntervalValue<double> animationIntervalValue;
  final String label;
  final ValueChanged<AnimationIntervalValue<double>> onIntervalChanged;
  final List<Widget> fields;

  final bool expanded;

  const AnimationTimelineRow({
    Key key,
    this.expanded = false,
    @required this.controller,
    @required this.fields,
    @required this.label,
    @required this.animationIntervalValue,
    @required this.onIntervalChanged,
  }) : super(key: key);

  @override
  _AnimationTimelineRowState createState() => _AnimationTimelineRowState();
}

class _AnimationTimelineRowState extends State<AnimationTimelineRow> {
  bool expanded = false;

  @override
  void initState() {
    expanded = widget.expanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final header = Container(
        decoration: _headerBorder,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '${widget.label} [ ${widget.animationIntervalValue.start} - ${widget.animationIntervalValue.end} ]',
                  style: Theme.of(context).textTheme.subtitle),
            ),
            IconButton(
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() => expanded = !expanded),
            ),
          ],
        ));

    final intervalBegin = widget.animationIntervalValue.interval.begin;
    final intervalEnd = widget.animationIntervalValue.interval.end;
    final intervalLabel = 'Interval : [ '
        '${intervalBegin.toStringAsFixed(2)} - ${intervalEnd.toStringAsFixed(2)}'
        ' ] ';

    return Padding(
      padding: _padding,
      child: Container(
        decoration: _fieldBorder,
        padding: _padding,
        child: expanded
            ? _buildExpandedBody(
                header, intervalLabel, intervalBegin, intervalEnd)
            : header,
      ),
    );
  }

  Column _buildExpandedBody(Widget header, String intervalLabel,
      double intervalBegin, double intervalEnd) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        header,
        Row(
          children: <Widget>[
            Padding(
              padding: _padding,
              child: Text(intervalLabel),
            ),
            Expanded(
              child: RangeSlider(
                activeColor: Colors.pink,
                values: RangeValues(intervalBegin, intervalEnd),
                labels: RangeLabels('$intervalBegin', '$intervalEnd'),
                onChanged: _onRangeChanged,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[...widget.fields],
        ),
        CurvesThumbMenu(
          animController: widget.controller,
          currentCurve: this.widget.animationIntervalValue.curve,
          onCurveChanged: (curve) => widget.onIntervalChanged(
            widget.animationIntervalValue.copyWith(newCurve: curve),
          ),
        )
      ],
    );
  }

  void _onRangeChanged(RangeValues values) =>
      widget.onIntervalChanged(widget.animationIntervalValue
          .copyWith(newInterval: Interval(values.start, values.end)));
}
