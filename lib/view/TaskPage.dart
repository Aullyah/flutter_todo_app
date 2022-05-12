import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/shared/color.dart';
import '../bloc/todo_bloc.dart';
import '../shared/message.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // List<DropdownMenuItem<String>> get dropdownItems {
  //   List<DropdownMenuItem<String>> menuItems = const [
  //     DropdownMenuItem(child: Text("Business"), value: "business"),
  //     DropdownMenuItem(child: Text("Personal"), value: "personal"),
  //   ];
  //   return menuItems;
  // }
  bool _value = false;
  int? val = -1;
  TextEditingController txtTask = TextEditingController();

  var selectedValue = 'Business';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: grey),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.cancel_outlined),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: TextFormField(
                        controller: txtTask,
                        cursorColor: blackColor,
                        style: TextStyle(color: blackColor),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Input task  here',
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          title: const Text("Business"),
                          leading: Radio(
                            value: 1,
                            groupValue: val,
                            onChanged: (int? value) {
                              setState(() {
                                val = value;
                              });
                            },
                            activeColor: pink,
                          ),
                        ),
                        ListTile(
                          title: const Text("Personal"),
                          leading: Radio(
                            value: 2,
                            groupValue: val,
                            onChanged: (int? value) {
                              setState(() {
                                val = value;
                              });
                            },
                            activeColor: mainColor,
                          ),
                        ),
                      ],
                    )
                    // DropdownButton(
                    //   value: selectedValue == '' ? 'Business' : selectedValue,
                    //   items: dropdownItems,
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       selectedValue = newValue!;
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        var category = val == 1 ? "Business" : "Personal";
                        try {
                          context.read<TodoBloc>().add(AddTodo(Todo(
                              id: totalTask + 1,
                              task: txtTask.text,
                              category: category)));
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(errorMessage);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('New Task'),
                          Icon(Icons.arrow_upward),
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
