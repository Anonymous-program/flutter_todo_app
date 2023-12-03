import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/todo_add_page.dart';
import 'package:flutter_todo_app/providers/todo_provider.dart';
import 'package:flutter_todo_app/utils/helper_function.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class TodoHomePage extends StatelessWidget {
  static const String routeName = '/';
  const TodoHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      floatingActionButton: FloatingActionButton(
        autofocus: true,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          Navigator.pushNamed(context, TodoAddPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.todoList.length,
          itemBuilder: (context, index) {
            final todo = provider.todoList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.star,
                    size: 30,
                    color: getPriorityColor(todo.priority),
                  ),
                  title: Text(todo.name),
                  subtitle: Text(todo.isCompeted
                      ? 'Competed'
                      : '${calculateTimeDifference(todo.date)} later'),
                  trailing: Checkbox(
                    fillColor:
                        MaterialStateColor.resolveWith((states) => Colors.blue),
                    value: todo.isCompeted,
                    onChanged: todo.isCompeted
                        ? null
                        : (value) {
                            provider.changeTodoStatus(todo);
                          },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar:  const GNav(
        gap: 8,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'All Todo',
          ),
          GButton(
            icon: Icons.check,
            text: 'Competed',
          ),
          GButton(
              icon:Icons.favorite,
            text: 'Favorite',
          ),
          GButton(icon: Icons.search,text: 'Search',)

        ],
      ),
    );
  }

  Color getPriorityColor(String priority) {
    if (priority == 'Low') {
      return Colors.yellow;
    } else if (priority == 'Normal') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
