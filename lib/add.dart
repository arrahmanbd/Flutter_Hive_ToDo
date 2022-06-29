import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:what_todo/home.dart';
import 'package:what_todo/todo.dart';

class AddTodo extends StatefulWidget {
  AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
   TextEditingController titleController = TextEditingController();
   // user box
  late Box userBox;

  @override
  void initState() {
    super.initState();
    // get the previously opened user box
    userBox = Hive.box('Todo');
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Something ToDo!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter a task',
              ),
              controller: titleController,
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  if (titleController.text != '') {
                    ToDo newTodo = ToDo(
                      title: titleController.text,
                      isDone: false,
                    );
                   userBox.add(newTodo);
                     Navigator.pop(
              context, MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Text('I Want ToDo')),
          ],
        ),
      ),
    );
 
  }
}


