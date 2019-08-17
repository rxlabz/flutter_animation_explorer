import 'package:flutter/material.dart';
import 'package:quiver/time.dart';

import 'screens/animateds/animated_widgets.dart';
import 'screens/curves_visualizer.dart';
import 'nav.dart';
import 'screens/home_screen.dart';
import 'screens/staggered_anim_screen.dart';

class AnimationExplorer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.cyan,
        toggleableActiveColor: Colors.cyan,
      ),
      home: HomeScreen(),
      routes: {
        'curves': (context) => CurveVisualizer(),
        'animateds': (context) => AnimatedWidgetsScreen(),
        'staggered': (context) => StaggeredScreen(),
      },
    );
  }
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
          : null,
    );
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
        return AnimatedWidgetsScreen();
      case 2:
        return StaggeredScreen(
            /*tabController: _widgetTabsController,
          notifier: this,*/
            );
      default:
        return CurveVisualizer();
    }
  }

  void _onNavTab(int value) => setState(() => _navIndex = value);
}
