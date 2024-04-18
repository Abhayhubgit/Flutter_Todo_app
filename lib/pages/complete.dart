import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/providers/todo_providers.dart';

class Completedpage extends ConsumerWidget {
  const Completedpage({
    super.key,
  });
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> Completetodos =
        todos.where((todo) => todo.Completed == true).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Text("Completed Todo"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: Completetodos.length,
          itemBuilder: (context, index) {
            return Slidable(
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                      onPressed: (context) {
                        ref
                            .watch(todoProvider.notifier)
                            .delete(Completetodos[index].todoId);
                      },
                      backgroundColor: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      icon: Icons.delete),
                ],
              ),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: ListTile(
                      title: Text(
                    Completetodos[index].Content,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                  ))),
            );
          }),
    );
  }
}
