
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_todo/pages/todo/to_do_state.dart';

class TodoBloc extends Cubit<TodoState> {
  TodoBloc() : super(TodoState(todoList: [], doneList: [], status: TodoStateStatus.initial));

  void addTodo(String todo) {
    emit(state.copyWith(
      status: TodoStateStatus.addTodo,
      todoList: [...state.todoList ?? [], todo],
    ));
  }

  void removeTodo(int index) {
    state.todoList?.removeAt(index);
    emit(state.copyWith(
      status: TodoStateStatus.removeTodo,
      todoList: state.todoList,
    ));

  }

  void sortTodoList() {
    state.todoList?.sort((a, b) => b.compareTo(a));
    emit(state.copyWith(
      status: TodoStateStatus.sortTodo,
      todoList: state.todoList!.reversed.toList(),
    ));
  }

  void updateCompletedTodo(int index) {
    final todoList = List<String>.from(state.todoList!);
    final doneList = List<String>.from(state.doneList!);
    final String todo = todoList?[index] ?? '';
    todoList?.removeAt(index);
    doneList.add(todo);

    emit(state.copyWith(
      status: TodoStateStatus.updateCompletedTodo,
      todoList: todoList,
      doneList: doneList,
    ));
  }

  void setPriorityForTask(int index) {
    final listNew = List<String>.from(state.todoList!);
    final String todo = listNew[index] ?? '';
    listNew.removeAt(index);
    listNew.insert(0, todo);
    emit(state.copyWith(
      status: TodoStateStatus.setPriorityForTask,
      todoList: listNew,
    ));
  }
}
