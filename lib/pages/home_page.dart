import 'package:flutter/material.dart';
import 'package:flutter_application_punctual/util/dialog_box.dart';
import 'package:flutter_application_punctual/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // text controller
  final _controller = TextEditingController();

  // list of todo tasks
  List toDoList = [
    ["Make Tutorial", false],
    ["Do this", false],
  ];


  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  // save new task
  void saveNewTask() {
    setState(() {
      toDoList.add([ _controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }


  // create a new task
  void createNewTask() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
    },);
  }


  // delete task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
  backgroundColor: const Color.fromARGB(255, 235, 18, 18),
  centerTitle: true, // This centers the Row horizontally in the AppBar
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(
        'assets/logo.png',
        height: 24,
      ),
      const SizedBox(width: 8),
      Text(
        'TO DO',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
  elevation: 0,
),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder:(context, index) {
          return ToDoTile(
            taskName: toDoList[index][0], 
            taskCompleted: toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            );
        },
      )
    );
  }
}