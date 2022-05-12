import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/bloc/todo_bloc.dart';
import 'package:flutter_todo_app/shared/color.dart';
import 'package:flutter_todo_app/shared/message.dart';
import 'package:flutter_todo_app/view/TaskPage.dart';
import 'package:flutter_todo_app/view/widgets/card_category_widget.dart';
import 'package:flutter_todo_app/view/widgets/card_task_widget.dart';
import 'package:flutter_todo_app/view/widgets/drawer_menu_widget.dart';

class TodoPage extends StatelessWidget {
  final VoidCallback openDrawer;

  const TodoPage({Key? key, required this.openDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      color: lightGrey,
      fontSize: 12,
      letterSpacing: 1,
    );
    TextStyle headingStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
    );
    TextStyle notaskStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      backgroundColor: accentColor,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: pink,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TaskPage()));
        },
      ),
      body: SafeArea(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoInitial) {
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              );
            }
            if (state is TodoLoaded) {
              if (state.todos.isNotEmpty) {
                totalTask = state.todos.length;
                totalBusiness = state.todos
                    .where((category) => category.category == 'Business')
                    .length;
                totalPersonal = state.todos
                    .where((category) => category.category == 'Personal')
                    .length;
              } else {
                totalTask = 0;
                totalBusiness = 0;
                totalPersonal = 0;
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        DrawerMenuWidget(onClicked: openDrawer),
                        Expanded(child: Container()),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(inProgressMessage);
                          },
                          icon: const Icon(Icons.search),
                          color: lightGrey,
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(inProgressMessage);
                          },
                          icon: const Icon(Icons.notifications_none),
                          color: lightGrey,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "What's up, Aullyah!",
                            style: headingStyle,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'CATEGORIES',
                            style: titleStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CardCategoryWidget(
                                totalTask: totalBusiness, category: 'Business'),
                            const SizedBox(
                              width: 15,
                            ),
                            CardCategoryWidget(
                                totalTask: totalPersonal, category: 'Personal'),
                            const SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Text(
                        'TODAY\'S TASKS',
                        style: titleStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // CardTaskWidget(isCheck: false, color: pink),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 800,
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              state.todos.isEmpty ? 1 : state.todos.length,
                          itemBuilder: ((context, index) {
                            return state.todos.isNotEmpty
                                ? Dismissible(
                                    key: Key(state.todos[index].task),
                                    onDismissed: (direction) {
                                      context
                                          .read<TodoBloc>()
                                          .add(RemoveTodo(state.todos[index]));
                                    },
                                    background: Container(
                                      color: lightGrey.withOpacity(.2),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: CardTaskWidget(
                                        isCheck: false,
                                        color: state.todos[index].category ==
                                                'Personal'
                                            ? accentColor
                                            : pink,
                                        task: state.todos[index].task,
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Center(
                                        child: Text(
                                      'No Task Today',
                                      style: notaskStyle,
                                    )),
                                  );
                          })),
                    )
                  ],
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(errorMessage);
              return const Text('');
            }
          },
        ),
      ),
    );
  }
}
