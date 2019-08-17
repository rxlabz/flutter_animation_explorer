import 'package:flutter/material.dart';

class DurationControl extends StatelessWidget {
  final int duration;

  final ValueChanged<int> onDurationChange;

  final MainAxisAlignment alignment;

  final _fieldBorder = BoxDecoration(
      color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8));

  DurationControl({
    Key key,
    this.duration,
    this.onDurationChange,
    this.alignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _fieldBorder,
      child: Row(
        mainAxisAlignment: alignment,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Duration',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          _buildIconButton(icon: Icons.remove, value: -100),
          Text('$duration ms'),
          _buildIconButton(icon: Icons.add, value: 100),
        ],
      ),
    );
  }

  IconButton _buildIconButton({IconData icon, int value}) => IconButton(
        color: Colors.pink,
        icon: Icon(icon),
        onPressed: () => onDurationChange(value),
      );
}
