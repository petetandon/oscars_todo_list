import 'package:flutter/material.dart';
import 'package:todo_list/services/databade_services.dart';

class HomePage extends StatefulWidget {
  const HomePage ({super.key});


    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final DatabaseService _databaseService = DatabaseService.instance;

  String? _task = null;

  @override
  Widget build(Object context) {
    return  Scaffold(
      floatingActionButton: _addTaskButton(),
    );
  }
  Widget _addTaskButton() {
  return FloatingActionButton(onPressed: () {
    showDialog(context: context,
      builder: (_) => AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged:(value) {
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
              if (_task == null || _task == "") return;
              _databaseService.addTask(_task!);
              setState(() {
                _task = null;
              });
              Navigator.pop(context);
        },
          child: const Text(
            "Done",
                style: TextStyle(
                  color: Colors.white,
                ),
          )

          ),
        ],
      ),
    ),
    );
  }, child: const Icon(Icons.add,));

  }
}

