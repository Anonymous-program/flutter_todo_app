import 'package:flutter/foundation.dart';
import '../models/todo_model.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> todoList = [];
  void addTodo(TodoModel todoModel) {
    todoList.add(todoModel);
    notifyListeners();
  }

  void changeTodoStatus(TodoModel todoModel) {
    final index = todoList.indexOf(todoModel);
    todoList[index].isCompeted = !todoList[index].isCompeted;
    notifyListeners();
  }
}
