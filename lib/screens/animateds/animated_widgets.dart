import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import '../../controls/theme_code_preview.dart';
import '../../examples.dart';
import '../../nav.dart';
import 'animated_align_example.dart';
import 'animated_container_example.dart';
import 'animated_opacity_example.dart';
import 'animated_positioned_example.dart';
import 'animated_textstyle_example.dart';

class AnimatedWidgetsScreen extends StatefulWidget {
  const AnimatedWidgetsScreen({Key key}) : super(key: key);

  @override
  _AnimatedWidgetsScreenState createState() => _AnimatedWidgetsScreenState();
}

class _AnimatedWidgetsScreenState extends State<AnimatedWidgetsScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _widgetTabsController;

  ChangeNotifier notifier = ChangeNotifier();

  AnimationController animController;

  final codeExamples = [
    animatedContainerExampleCode,
    positionnedExample,
    alignExample,
    animatedTextExample,
    animatedOpacityExample
  ];

  get running => animController.status != AnimationStatus.dismissed;

  @override
  void initState() {
    animController = AnimationController(duration: aSecond, vsync: this);
    _widgetTabsController =
        TabController(length: widgetTabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animController.stop();
    animController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppbar(),
      endDrawer: Drawer(
        child: ThemeCodePreview(codeExamples[_widgetTabsController.index]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: running ? Colors.grey : Colors.pink,
        child: Icon(Icons.play_arrow),
        onPressed: running ? null : notifier.notifyListeners,
      ),
      body: TabBarView(controller: _widgetTabsController, children: [
        AnimatedContainerExample(controller: notifier),
        AnimatedPositionedExample(controller: notifier),
        AnimatedAlignExample(controller: notifier),
        AnimatedTextExample(controller: notifier),
        AnimatedOpacityExample(controller: notifier),
        /*AnimatedCrossFadeExample(controller: notifier),*/
      ]),
    );
  }

  _buildAppbar() {
    final tabBar = TabBar(
      tabs: widgetTabs,
      controller: _widgetTabsController,
      isScrollable: true,
    );

    return AppBar(
      title: Text('Animated widgets'),
      bottom: tabBar,
      actions: <Widget>[
        FlatButton.icon(
          onPressed: _openCodePreview,
          icon: Icon(Icons.code, color: Colors.white),
          label: Text('Code', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  void _openCodePreview() {
    _scaffoldKey.currentState.openEndDrawer();
  }
}
