import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todo.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void add(String content) {
    state = [
      ...state,
      Todo(
          todoId: state.isEmpty ? 0 : state[state.length - 1].todoId + 1,
          Content: content,
          Completed: false)
    ];
  }

  void complete(int id) {
    state = [
      for (final todo in state)
        if (todo.todoId == id)
          Todo(todoId: todo.todoId, Content: todo.Content, Completed: true)
        else
          todo
    ];
  }

  void delete(int id) {
    state = state.where((Todo) => Todo.todoId != id).toList();
  }
}
