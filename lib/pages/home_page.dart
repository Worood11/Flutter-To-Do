import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//references the box
  final _mybox = Hive.openBox('mybox');

  final _controller = TextEditingController();
  List toDoList = [
    ['Task 1', false],
    ['Task 2', false],
  ];

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('To-Do'),
        backgroundColor: Colors.blue.shade400,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (BuildContext context, index) {
            return TodoList(
              taskName: toDoList[index][0],
              taskCompleted: toDoList[index][1],
              onChanged: (value) => checkBoxChanged(index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add a new task',
                    filled: true,
                    fillColor: Colors.blue.shade200,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue.shade700,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue.shade700,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: saveNewTask,
              child: Icon(Icons.add),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
