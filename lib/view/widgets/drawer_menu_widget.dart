import 'package:flutter/material.dart';
import 'package:flutter_todo_app/shared/color.dart';

class DrawerMenuWidget extends StatelessWidget {
  final VoidCallback onClicked;
  const DrawerMenuWidget({Key? key, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onClicked,
      icon: Icon(Icons.menu),
      color: lightGrey,
    );
  }
}
