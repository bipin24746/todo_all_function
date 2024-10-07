import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TextEditingController todotext = TextEditingController();
  List<String> todotextlist = [];

  // Function to edit a todo item
  void edittodotext(BuildContext context, int index) {
    TextEditingController edittexttodo = TextEditingController();
    edittexttodo.text = todotextlist[index]; // Pre-fill the current todo item

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit ToDo"),
          content: TextField(
            controller: edittexttodo,
            decoration: InputDecoration(hintText: "Edit your task"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                }); // Close dialog without saving
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  todotextlist[index] = edittexttodo.text; // Save new value
                });
                Navigator.of(context).pop(); // Close dialog after saving
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ToDo List'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todotext,
                    decoration: InputDecoration(hintText: "Enter your task"),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      todotextlist.add(todotext.text);
                      todotext.clear();
                    });
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: todotextlist.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todotextlist[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize
                      .min, // To prevent the row from taking up too much space
                  children: [
                    IconButton(
                      onPressed: () {
                        edittodotext(context, index);
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          todotextlist.removeAt(
                              index); // Removes the item at the given index
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
