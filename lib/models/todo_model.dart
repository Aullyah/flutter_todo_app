import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String task;
  final String category;

  const Todo({
    required this.id,
    required this.task,
    required this.category,
  });

  @override
  List<Object?> get props => [id, task];

  static List<Todo> todo = [
    const Todo(id: 0, task: "Belajar Flutter", category: "Personal"),
  ];
}
