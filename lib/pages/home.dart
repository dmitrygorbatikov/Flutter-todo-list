import 'package:auth/components/main_drawer.dart';
import 'package:auth/models/todo_model.dart';
import 'package:auth/services/todo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoService todoService = TodoService();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  var todos = [];

  getUserTodos() async {
    var userTodos = await todoService.getTodos();
    setState(() {
      todos = userTodos;
    });
    return userTodos;
  }

  addTodo(BuildContext context) async {
    var statusCode = await todoService.addTodo(
        _titleController.text, _descriptionController.text);

    if (statusCode == 201) {
      setState(() {
        todos.add({
          "title": _titleController.text,
          "description": _descriptionController.text
        });
        _titleController.text = "";
        _descriptionController.text = "";
      });
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You need enter data'),
        ),
      );
    }
  }

  @override
  void initState() {
    getUserTodos();
    super.initState();
  }

  showDeleteModalFunc(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(15),
                      height: 360,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Do you wand to delete this todo ?"),
                            Center(
                                child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 25.0,
                                    child: MaterialButton(
                                        color: Colors.green,
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 25.0,
                                    child: MaterialButton(
                                        color: Colors.red,
                                        child: Text(
                                          'No',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                              ],
                            ))
                          ]))));
        });
  }

  showDialogFunc(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                height: 360,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Title",
                            fillColor: Colors.grey[200],
                            filled: true),
                        onChanged: (text) {
                          _titleController.text = text;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        autofocus: true,
                        maxLines: 8,
                        decoration: InputDecoration.collapsed(
                            hintText: "Description",
                            fillColor: Colors.grey[200],
                            filled: true),
                        onChanged: (text) {
                          _descriptionController.text = text;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 60.0,
                        width: 200,
                        child: MaterialButton(
                            color: Colors.lightBlueAccent,
                            child: Text(
                              'Create',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              addTodo(context);
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        drawer: MainDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialogFunc(context);
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body:
            // children: [
            // Text(todos.length > 0 ? "Your todos" : "You don't have todos"),
            ListView(
          physics: BouncingScrollPhysics(),
          children: todos
              .map((todo) => Padding(
                  padding: EdgeInsets.all(20),
                  child: Card(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: ListTile(
                            title: Text(
                              "${todo["title"]}",
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              "${todo["description"]}",
                            ),
                            leading: Icon(
                              Icons.local_activity,
                              size: 40,
                              color: Colors.black,
                            ),
                            trailing: Positioned(
                                right: 0.0,
                                bottom: 0.0,
                                child: PopupMenuButton<MenuItem>(
                                  itemBuilder: (context) => [
                                    ...MenuItems.items.map(buildItem).toList(),
                                  ],
                                  child: Icon(Icons.settings),
                                ))
                            //  IconButton(
                            //   icon: Icon(Icons.delete),
                            //   onPressed: () {},
                            //   color: Colors.red,
                            // ),
                            )
                        // Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Container(
                        //         child: Text(
                        //           "${todo["title"]}",
                        //           style: TextStyle(
                        //               fontSize: 22,
                        //               fontWeight: FontWeight.bold),
                        //         ),
                        //       ),
                        //       Text(
                        //         "${todo["description"]}",
                        //         style: TextStyle(
                        //             fontSize: 16,
                        //             color: Color(0xFF86829D),
                        //             height: 1.5),
                        //       ),
                        //     ])

                        ),
                  )))
              .toList(),
        ));
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 60.0,
            child: MaterialButton(
                color: Colors.lightBlueAccent,
                child: Row(children: [
                  Icon(
                    item.icon,
                    color: item.color,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Text(item.text),
                ]),
                onPressed: () {
                  showDeleteModalFunc(context);
                }),
          ),
        ),
      );
}

class MenuItem {
  final String text;
  final IconData icon;
  final MaterialColor color;

  const MenuItem({required this.text, required this.icon, required this.color});
}

class MenuItems {
  static const List<MenuItem> items = [deleteItem, updateItem];

  static const deleteItem =
      MenuItem(text: "Delete", icon: Icons.delete, color: Colors.red);
  static const updateItem =
      MenuItem(text: "Update", icon: Icons.update, color: Colors.yellow);
}
