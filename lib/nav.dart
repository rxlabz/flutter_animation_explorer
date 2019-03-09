import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNav(int index, {ValueChanged<int> onNavTab}) {
  return BottomNavigationBar(
    currentIndex: index,
    items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.timeline), title: Text('Curves')),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings_overscan), title: Text('Widgets')),
    ],
    onTap: onNavTab,
  );
}

const widgetTabs = [
  Tab(text: 'Container'),
  Tab(text: 'CrossFade'),
  Tab(text: 'Text'),
  Tab(text: 'Align'),
  Tab(text: 'Opacity'),
];
