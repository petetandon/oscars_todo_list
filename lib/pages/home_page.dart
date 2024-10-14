import 'package:flutter/material.dart';
import 'package:todo_list/services/databade_services.dart';

class HomePage extends StatefulWidget {
  const HomePage ({super.key});


    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final DatabaseService _databaseService = DatabaseService.instance;

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
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            hintText: 'Subscribe...',
            ),
          ),
          MaterialButton(onPressed: () {},)
        ],
      ),
    ),
    );
  }, child: const Icon(Icons.add,));

}
}

