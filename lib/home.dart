import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:what_todo/add.dart';
import 'package:what_todo/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // user box
  // Box getBox = Hive.box<ToDo>('Todo');
  late Box getBox;
  @override
  void initState() {
    super.initState();
    // get the previously opened user box
    getBox = Hive.box('Todo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('What To Do!'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: getBox.listenable(),
          builder: (context, Box box, widget) {
            if (box.isEmpty) {
              return Center(
                child: Text('Nothing Todo !!'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                   
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      ToDo todo = box.getAt(index);
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 136, 193, 240),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                             
                            ),
                            child: ListTile(
                              title: Text(
                                todo.title,

                                style: TextStyle(
                                    decoration: todo.isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: todo.isDone
                                        ? Colors.blueGrey
                                        : Colors.black),

                                //  textDecoration: todo.isDone?TextDecoration.lineThrough : TextDecoration.none,
                              ),
                              leading: Checkbox(
                               
                                  value: todo.isDone,
                                  onChanged: (value) {
                                    ToDo newTodo =
                                        ToDo(title: todo.title, isDone: value!);

                                    box.putAt(index, newTodo);
                                  }),
                              trailing: IconButton(
                                onPressed: () {
                                  box.deleteAt(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Todo Deleted')));
                                },
                                icon: Icon(Icons.delete_forever),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          )
                        ],
                      );

                     
                    }),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTodo()));
        },
      ),
    );
  }
}
