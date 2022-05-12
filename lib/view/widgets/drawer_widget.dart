import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/drawe_items.dart';
import 'package:flutter_todo_app/models/drawer_item.dart';
import 'package:flutter_todo_app/shared/color.dart';

class DrawerWidget extends StatelessWidget {
  final ValueChanged<DrawerItem> onSelectedItem;
  const DrawerWidget({Key? key, required this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildDrawerItems(context),
        ],
      ),
    );
  }

  Widget buildDrawerItems(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 12, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width - 190),
              decoration: BoxDecoration(
                border: Border.all(color: grey.withOpacity(.5), width: 2),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  onSelectedItem(DrawerItems.home);
                },
              ),
            ),
            CircleAvatar(
              radius: 56,
              backgroundColor: grey.withOpacity(.5),
              child: CircleAvatar(
                radius: 54,
                backgroundColor: mainColor,
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80'),
                ),
              ),
            ),
            Column(
              children: DrawerItems.all
                  .map((item) => ListTile(
                        onTap: () => onSelectedItem(item),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        leading: Icon(
                          item.icon,
                          color: grey.withOpacity(.5),
                        ),
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      );
}
