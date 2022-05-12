import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/drawe_items.dart';
import 'package:flutter_todo_app/models/drawer_item.dart';
import 'package:flutter_todo_app/shared/color.dart';
import 'package:flutter_todo_app/view/TaskPage.dart';
import 'TodoPage.dart';
import 'package:flutter_todo_app/view/widgets/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  late bool isDrawerOpen;
  DrawerItem item = DrawerItems.home;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    // openDrawer();
    closeDrawer();
  }

  void closeDrawer() => setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });

  void openDrawer() => setState(() {
        xOffset = MediaQuery.of(context).size.width - 90;
        yOffset = 70;
        scaleFactor = 0.8;
        isDrawerOpen = true;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: [buildDrawer(), buildPage()],
      ),
    );
  }

  Widget buildDrawer() => SafeArea(
        child: DrawerWidget(
          onSelectedItem: (item) {
            setState(() => this.item = item);
            closeDrawer();
          },
        ),
      );
  Widget buildPage() {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          if (!isDragging) return;
          const delta = 1;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }
          isDragging = false;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor),
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
              // child: TodoPage(openDrawer: openDrawer))),
              child: getDrawerPage(),
            ),
          ),
        ),
      ),
    );
  }

  Widget getDrawerPage() {
    switch (item) {
      default:
        return TodoPage(openDrawer: openDrawer);
    }
  }
}
