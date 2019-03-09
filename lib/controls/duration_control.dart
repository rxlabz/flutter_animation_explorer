import 'package:flutter/material.dart';

class DurationControl extends StatelessWidget {
  final int duration;

  final ValueChanged<int> onDurationChange;

  DurationControl({Key key, this.duration, this.onDurationChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildIconButton(icon: Icons.remove, value: -100),
        Text('$duration ms'),
        _buildIconButton(icon: Icons.add, value: 100),
      ],
    );
  }

  IconButton _buildIconButton({IconData icon, int value}) => IconButton(
        color: Colors.cyan,
        icon: Icon(icon),
        onPressed: () => onDurationChange(value),
      );
}
