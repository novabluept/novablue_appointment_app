
import 'package:flutter/material.dart';

class MyDecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {

  final TabBar tabBar;
  final BoxDecoration decoration;

  MyDecoratedTabBar({required this.tabBar, required this.decoration});

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(decoration: decoration)),
        tabBar,
      ],
    );
  }
}