import 'package:flutter/material.dart';
import 'package:flutter_todo_app/shared/color.dart';

class CardCategoryWidget extends StatelessWidget {
  int totalTask;
  String category;
  CardCategoryWidget({this.totalTask = 0, this.category = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      width: 250,
      height: 120,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$totalTask tasks',
            style: TextStyle(
              color: lightGrey,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            category,
            style: TextStyle(
                color: category == 'Business' ? pink : accentColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
