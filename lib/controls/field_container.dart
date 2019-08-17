import 'package:flutter/material.dart';

final _fieldBorder = BoxDecoration(
  color: Colors.grey.shade200,
  borderRadius: BorderRadius.circular(8),
);

class FieldContainer extends StatelessWidget {
  final Widget child;

  FieldContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _fieldBorder,
      child: child,
    );
  }
}
