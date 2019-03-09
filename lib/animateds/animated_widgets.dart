import 'package:flutter/material.dart';

import 'animated_align_example.dart';
import 'animated_container_example.dart';
import 'animated_crossfade_example.dart';
import 'animated_opacity_example.dart';
import 'animated_textstyle_example.dart';

class AnimatedWidgetsScreen extends StatelessWidget {
  final TabController tabController;
  final ChangeNotifier notifier;

  const AnimatedWidgetsScreen({Key key, this.tabController, this.notifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: tabController, children: [
      AnimatedContainerExample(controller: notifier),
      AnimatedCrossFadeExample(controller: notifier),
      AnimatedTextExample(controller: notifier),
      AnimatedAlignExample(controller: notifier),
      AnimatedOpacityExample(controller: notifier),
    ]);
  }
}
