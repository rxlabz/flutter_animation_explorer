import 'package:flutter/material.dart';

const widgetTabs = [
  Tab(text: 'Container'),
  Tab(text: 'Positioned'),
  Tab(text: 'Align'),
  Tab(text: 'Text'),
  Tab(text: 'Opacity'),
  Tab(text: 'CrossFade'),
];

class NavItem {
  final String label;
  final IconData icon;

  const NavItem(this.label, this.icon);
}

const navItems = [
  NavItem('Curves', Icons.timeline),
  NavItem('Animated widgets', Icons.settings_overscan)
];

BottomNavigationBar buildBottomNav(int index, {ValueChanged<int> onNavTab}) =>
    BottomNavigationBar(
      currentIndex: index,
      items: [
        builBottomNav(Icons.timeline, 'Curves'),
        builBottomNav(Icons.settings_overscan, 'Widgets'),
      ],
      onTap: onNavTab,
    );

builBottomNav(IconData icon, String label) =>
    BottomNavigationBarItem(icon: Icon(Icons.timeline), title: Text(label));
