import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';

/// https://docs.flutter.io/flutter/widgets/ImplicitlyAnimatedWidget-class.html
///
/// - [x] AnimatedAlign
/// - [x] AnimatedContainer
/// - [x] AnimatedDefaultTextStyle
/// - [x] AnimatedOpacity
/// - [x] AnimatedPadding
/// - [x] AnimatedPositioned
/// - [ ] AnimatedPositionedDirectional
///
///
void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(AnimationExplorer());
}
