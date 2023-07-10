
import 'package:equatable/equatable.dart';

enum TodoStateStatus {
  initial, addTodo, removeTodo, sortTodo, updateCompletedTodo, setPriorityForTask
}

class TodoState extends Equatable {

  TodoState({this.status, this.todoList, this.doneList});

  final TodoStateStatus? status;
  final List<String>? todoList;
  final List<String>? doneList;

  TodoState copyWith({TodoStateStatus? status, List<String>? todoList, List<String>? doneList}) {
    return TodoState(
        status: status ?? this.status,
        todoList: todoList ?? this.todoList,
        doneList: doneList ?? this.doneList,
    );
  }

  @override
  List<Object?> get props => [status, todoList, doneList];

}
