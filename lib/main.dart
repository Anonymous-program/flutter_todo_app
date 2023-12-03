import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/todo_add_page.dart';
import 'package:flutter_todo_app/pages/toto_home_page.dart';
import 'package:flutter_todo_app/providers/todo_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => TodoProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: TodoHomePage.routeName,
      routes: {
        TodoHomePage.routeName: (_) => const TodoHomePage(),
        TodoAddPage.routeName: (_) => const TodoAddPage(),
      },
    );
  }
}
