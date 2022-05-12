part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodoCounter extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;

  const AddTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class RemoveTodo extends TodoEvent {
  final Todo todo;
  const RemoveTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class FilterBusinessTodo extends TodoEvent {
  final String category;
  const FilterBusinessTodo(this.category);
  @override
  List<Object> get props => [category];
}
