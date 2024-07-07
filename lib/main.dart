// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<String> _todoList = ["hellow"];
  final TextEditingController _textController = TextEditingController();

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoList.add(task);
      });
      _textController.clear();
    }
  }

  void _editTodoItem(int index, String newTask) {
    if (newTask.isNotEmpty) {
      setState(() {
        _todoList[index] = newTask;
      });
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  Widget _buildTodoItem(String task, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100], // Set background color here
          borderRadius: BorderRadius.circular(12.0), // Set border radius here
        ),
        child: ListTile(
          title: Text(task),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 24,
                  color: Colors.grey[500],
                ), // Adjust the size here
                onPressed: () {
                  _showEditDialog(task, index);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  size: 24,
                  color: Colors.red[600],
                ), // Adjust the size here
                onPressed: () => _removeTodoItem(index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(String currentTask, int index) {
    final TextEditingController _editController = TextEditingController();
    _editController.text = currentTask;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(hintText: 'Edit task'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _editTodoItem(index, _editController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddTaskDialog() {
    final TextEditingController _addController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            controller: _addController,
            decoration: InputDecoration(hintText: 'Enter task'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addTodoItem(_addController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoList.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoList[index], index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
            child: Text(
          'To Do',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        )),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildTodoList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _showAddTaskDialog,
        child: Icon(
          Icons.add,
          size: 24,
          color: Colors.white,
        ), // Adjust the size here
        tooltip: 'Add Task',
      ),
    );
  }
}
