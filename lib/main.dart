import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import 'animateds/animated_widgets.dart';
import 'curves/curves_visualizer.dart';
import 'nav.dart';

/// https://docs.flutter.io/flutter/widgets/ImplicitlyAnimatedWidget-class.html
///
/// AnimatedAlign AnimatedContainer AnimatedDefaultTextStyle
/// AnimatedOpacity AnimatedPadding AnimatedPhysicalModel
/// AnimatedPositioned AnimatedPositionedDirectional AnimatedTheme
///
///
void main() => runApp(MaterialApp(
    theme: ThemeData.light().copyWith(
        primaryColor: Colors.cyan, toggleableActiveColor: Colors.cyan),
    home: MainScreen()));

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class NavItem {
  final String label;
  final IconData icon;

  const NavItem(this.label, this.icon);
}

const navItems = [
  NavItem('Curves', Icons.timeline),
  NavItem('Animated widgets', Icons.settings_overscan)
];

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin, ChangeNotifier {
  int _navIndex = 0;

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: _navIndex == 0
              ? running ? Colors.grey : Colors.pink
              : Colors.pink,
          child: Icon(Icons.play_arrow),
          onPressed: _navIndex == 0
              ? running ? null : animController.forward
              : notifyListeners,
        ));
  }

  _buildAppbar() {
    final tabBar = _navIndex == 0
        ? null
        : TabBar(
            tabs: widgetTabs,
            controller: _widgetTabsController,
            isScrollable: true,
          );

    return AppBar(
      title: Text(navItems[_navIndex].label),
      bottom: tabBar,
    );
  }

  _buildBody() {
    return _navIndex == 0
        ? AnimGraphr(animationController: animController)
        : AnimatedWidgetsScreen(
            tabController: _widgetTabsController, notifier: this);
  }

  void _onNavTab(int value) => setState(() => _navIndex = value);
}
