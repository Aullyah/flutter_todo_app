import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/drawer_item.dart';

class DrawerItems {
  static var home = DrawerItem(title: 'Home', icon: Icons.home);
  static var category = DrawerItem(title: 'Category', icon: Icons.group);

  static final List<DrawerItem> all = [
    home,
    category,
  ];
}
