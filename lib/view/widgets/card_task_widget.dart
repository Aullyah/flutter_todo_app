import 'package:flutter/material.dart';
import 'package:flutter_todo_app/shared/color.dart';

class CardTaskWidget extends StatefulWidget {
  bool isCheck;
  final Color color;
  final String task;
  CardTaskWidget(
      {Key? key,
      required this.isCheck,
      required this.color,
      required this.task})
      : super(key: key);

  @override
  State<CardTaskWidget> createState() => _CardTaskWidgetState();
}

class _CardTaskWidgetState extends State<CardTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.all(widget.color),
            value: widget.isCheck,
            shape: CircleBorder(),
            onChanged: (bool? value) {
              setState(() {
                widget.isCheck = value!;
              });
            },
          ),
          Text(
            widget.task,
            style: widget.isCheck
                ? TextStyle(
                    color: Colors.white, decoration: TextDecoration.lineThrough)
                : TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
