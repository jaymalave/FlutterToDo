import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do List',
        home: new TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Todo List',
          style: new TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.teal,
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add Task',
        child: new Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.blueGrey,
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        backgroundColor: Colors.black,
        appBar: new AppBar(
          title: new Text('Add a new Task'),
          backgroundColor: Colors.teal,
        ),
        body: new TextField(
          autofocus: true,
          style: new TextStyle(
            color: Colors.white,
          ),
          onSubmitted: (val) {
            _addTodoItem(val);
            Navigator.pop(context);
          },
          decoration:
              new InputDecoration(contentPadding: const EdgeInsets.all(16.0)),
        ),
      );
    }));
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Mark "${_todoItems[index]}" as done?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('Cancel'),
              ),
              new FlatButton(
                onPressed: () {
                  _removeTodoItem(index);
                  Navigator.of(context).pop();
                },
                child: new Text('Mark as Done'),
              ),
            ],
          );
        });
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
          return ListTile(
            tileColor: Colors.blueGrey,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0)
          );
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          
                ),
          
          child: ListTile(

          
        title: new Text(
          todoText,
          style: new TextStyle(color: Colors.white, fontSize: 20),
        ),
        tileColor: Colors.blueGrey[700],
        onLongPress: () => _promptRemoveTodoItem(index),
        onTap: () {},
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0)
        ),
        
    ),
        );
  }
}
