import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo_providers.dart';

class addtodo extends ConsumerWidget {
  const addtodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController todoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: todoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(todoProvider.notifier).add(todoController.text);
              Navigator.pop(context);
            },
            child: Text(
              "Add Todo",
              style: TextStyle(
                  color: const Color.fromARGB(199, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}
