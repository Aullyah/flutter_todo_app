import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_app/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<LoadTodoCounter>(((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const TodoLoaded(todos: <Todo>[]));
    }));
    on<AddTodo>(((event, emit) {
      if (state is TodoLoaded) {
        final state = this.state as TodoLoaded;
        emit(TodoLoaded(todos: List.from(state.todos)..add(event.todo)));
      }
    }));
    on<RemoveTodo>(((event, emit) {
      if (state is TodoLoaded) {
        final state = this.state as TodoLoaded;
        emit(TodoLoaded(todos: List.from(state.todos)..remove(event.todo)));
      }
    }));
    // on<FilterBusinessTodo>(
    //   (event, emit) {
    //     if (state is TodoLoaded) {
    //       final state = this.state as TodoLoaded;
    //       print(state);
    //       print(event.category);
    //       emit(TodoLoaded(todos: state.todos.map((e) => null).toList()))
    //     }
    //   },
    // );
  }
}
