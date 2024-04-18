import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/pages/add.dart';
import 'package:todo/pages/complete.dart';
import 'package:todo/providers/todo_providers.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
  });

  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activetodos = todos
        .where(
          (todo) => todo.Completed == false,
        )
        .toList();
    List<Todo> Completetodos = todos
        .where(
          (todo) => todo.Completed == true,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Text("Todo App"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: activetodos.length + 1,
          itemBuilder: (context, index) {
            if (activetodos.isEmpty)
              return Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Center(
                  child: Text(
                    "Add a todo using the button below",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              );
            else if (index == activetodos.length) {
              if (Completetodos.isEmpty)
                return Container();
              else {
                return Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Completedpage()));
                      },
                      child: Text("Completed Todo")),
                );
              }
            } else {
              return Slidable(
                startActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                        onPressed: (context) => ref
                            .watch(todoProvider.notifier)
                            .delete(activetodos[index].todoId),
                        backgroundColor: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        icon: Icons.delete),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                        onPressed: (context) => ref
                            .watch(todoProvider.notifier)
                            .complete(activetodos[index].todoId),
                        backgroundColor: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        icon: Icons.check),
                  ],
                ),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: ListTile(
                        title: Text(
                      activetodos[index].Content,
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ))),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => addtodo()));
        },
        tooltip: 'Increment',
        backgroundColor: Colors.blue.shade100,
        child: const Icon(Icons.add),
      ),
    );
  }
}
