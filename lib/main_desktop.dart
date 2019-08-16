import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import 'animateds/animated_widgets.dart';
import 'curves/curves_visualizer.dart';
import 'nav.dart';
import 'screens/staggered_anim_screen.dart';

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
  runApp(MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.cyan,
        toggleableActiveColor: Colors.cyan,
      ),
      home: MainScreen()));
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin, ChangeNotifier {
  int _navIndex = 2;

  TabController _widgetTabsController;
  AnimationController animController;

  get running => animController.status != AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _widgetTabsController =
        TabController(length: widgetTabs.length, vsync: this);
    animController = AnimationController(duration: aSecond, vsync: this);
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbar(),
        body: _buildBody(),
        bottomNavigationBar: buildBottomNav(_navIndex, onNavTab: _onNavTab),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _navIndex != 2
            ? FloatingActionButton(
                backgroundColor:
                    _navIndex == 0 && running ? Colors.grey : Colors.pink,
                child: Icon(Icons.play_arrow),
                onPressed: _navIndex == 0
                    ? running ? null : animController.forward
                    : notifyListeners,
              )
            : null);
  }

  _buildAppbar() {
    final tabBar = _navIndex == 1
        ? TabBar(
            tabs: widgetTabs,
            controller: _widgetTabsController,
            isScrollable: true,
          )
        : null;

    return AppBar(
      title: Text('Flutter animation : ${navItems[_navIndex].label}'),
      bottom: tabBar,
    );
  }

  _buildBody() {
    switch (_navIndex) {
      case 1:
        return AnimatedWidgetsScreen(
          tabController: _widgetTabsController,
          notifier: this,
        );
      case 2:
        return StaggeredScreen(
            /*tabController: _widgetTabsController,
          notifier: this,*/
            );
      default:
        return AnimGraphr(animationController: animController);
    }
  }

  void _onNavTab(int value) => setState(() => _navIndex = value);
}
