import 'package:auth/components/main_drawer.dart';
import 'package:auth/services/todo_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoService todoService = TodoService();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  var todos = [];
  bool checkBoxValue = false;

  getUserTodos() async {
    var userTodos = await todoService.getTodos();
    setState(() {
      todos = userTodos;
    });
  }

  deleteUserTodo(int id, int index) async {
    var newTodos = await todoService.deleteTodo(id);
    setState(() {
      todos = newTodos;
    });
  }

  addTodo(BuildContext context) async {
    var data = await todoService.addTodo(
        _titleController.text, _descriptionController.text);

    if (_titleController.text != "" && _descriptionController.text != "") {
      setState(() {
        todos.add(data);
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

  updateTodo(BuildContext context, int id, int index) async {
    await todoService.updateTodo(
        _titleController.text, _descriptionController.text, id);

    if (_titleController.text != "" && _descriptionController.text != "") {
      setState(() {
        todos[index]["title"] = _titleController.text;
        todos[index]["description"] = _descriptionController.text;
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

  showUpdateModalFunc(contextm, id, index) {
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
                      height: 350,
                      width: 400,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Update",
                              style: TextStyle(fontSize: 22),
                            ),
                            TextField(
                              controller: TextEditingController(
                                  text: _titleController.text),
                              decoration: InputDecoration(
                                  hintText: "Title",
                                  fillColor: Colors.grey[200],
                                  filled: true),
                              onChanged: (text) {
                                _titleController.text = text;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                              autofocus: true,
                              maxLines: 8,
                              controller: TextEditingController(
                                  text: _descriptionController.text),
                              decoration: InputDecoration.collapsed(
                                  hintText: "Description",
                                  fillColor: Colors.grey[200],
                                  filled: true),
                              onChanged: (text) {
                                _descriptionController.text = text;
                              },
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 40.0,
                                    child: MaterialButton(
                                        color: Colors.green,
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          updateTodo(context, id, index);
                                        }),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 40.0,
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
                            )
                          ]))));
        });
  }

  showDeleteModalFunc(context, id, index) {
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
                      height: 150,
                      width: 400,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Do you wand to delete this todo ?",
                              style: TextStyle(fontSize: 22),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 40.0,
                                    child: MaterialButton(
                                        color: Colors.green,
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          deleteUserTodo(id, index);
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 40.0,
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
                            )
                          ]))));
        });
  }

  showAddTodoFunc(context) {
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
            showAddTodoFunc(context);
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body: ListView(
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
                            leading: Checkbox(
                              value: checkBoxValue,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            // Icon(
                            //   Icons.local_activity,
                            //   size: 40,
                            //   color: Colors.black,
                            // ),
                            trailing: Positioned(
                                right: 0.0,
                                bottom: 0.0,
                                child: PopupMenuButton<MenuItem>(
                                  onSelected: (item) {
                                    onSelected(context, item, todo,
                                        todos.indexOf(todo));
                                  },
                                  itemBuilder: (context) => [
                                    ...MenuItems.items.map(buildItem).toList(),
                                  ],
                                  child: Icon(Icons.settings),
                                )))),
                  )))
              .toList(),
        ));
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
      value: item,
      child: SizedBox(
        height: 60.0,
        child: Row(children: [
          Icon(
            item.icon,
            color: item.color,
            size: 20,
          ),
          SizedBox(width: 12),
          Text(item.text),
        ]),
      ));

  void onSelected(BuildContext context, MenuItem item, todo, index) {
    switch (item) {
      case MenuItems.deleteItem:
        showDeleteModalFunc(context, todo["id"], index);
        break;
      case MenuItems.updateItem:
        setState(() {
          _titleController.text = todo["title"];
          _descriptionController.text = todo["description"];
        });
        showUpdateModalFunc(context, todo["id"], index);
        break;
    }
  }
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
