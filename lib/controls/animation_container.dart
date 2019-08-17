import 'package:flutter/material.dart';

class AnimationContainer extends StatelessWidget {
  final Widget child;

  const AnimationContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 3,
        color: Colors.white,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
