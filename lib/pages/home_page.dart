import 'package:flutter/material.dart';
import 'package:todo_list/services/database_services.dart';

import '../models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  String _task = "";

  void addNewTask(){
    String taskName = _task.trim();
    if (taskName.isEmpty){
      return;
    }

    _databaseService.addTask(taskName);
    setState(() {
      _task = "";
    });
    Navigator.pop(context);
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      floatingActionButton: _addTaskButton(),
      body: _tasksList(),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Add Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _task = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Subscribe...',
                    ),
                  ),
                  MaterialButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        addNewTask();
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ));
  }

  Widget _tasksList() {
    return FutureBuilder(
        future: _databaseService.getTasks(),
        builder: (
          context,
          snapshot,
        ) {
          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Task task = snapshot.data![index];
                return ListTile(
                  title: Text(
                    task.content,
                  ),
                );
              });
        });
  }
}
