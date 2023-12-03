import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/providers/todo_provider.dart';
import 'package:flutter_todo_app/utils/helper_function.dart';
import 'package:provider/provider.dart';

class TodoAddPage extends StatefulWidget {
  static const String routeName = '/add_todo';
  const TodoAddPage({super.key});

  @override
  State<TodoAddPage> createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  final _todoController = TextEditingController();
  final _priorityList = const ['Low', 'Normal', 'High'];
  String? priority;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _todoController,
              decoration: const InputDecoration(
                labelText: 'What to do?',
                labelStyle: TextStyle(
                  color: Colors.indigoAccent,
                ),
                prefixIcon: Icon(
                  Icons.work,
                  color: Colors.indigoAccent,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: DropdownButton<String>(
                    value: priority,
                    isExpanded: true,
                    hint: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Select Priority',
                        style: TextStyle(
                          color: Colors.indigoAccent,
                        ),
                      ),
                    ),
                    dropdownColor: Colors.white,
                    iconSize: 50,
                    underline: const Card(),
                    style: const TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    items: _priorityList
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(item),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        priority = value;
                      });
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _selectDate,
                  child: Text(
                    selectedDate == null
                        ? 'Select Date'
                        : getFormattedDate(selectedDate),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _selectTime,
                    child: Text(
                      selectedTime == null
                          ? 'Select Time'
                          : getFormattedTime(selectedTime),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: OutlinedButton(
                    onPressed: _saveTodo, child: const Text('SAVE TODO'))),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void _selectTime() async {
    final time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void _saveTodo() {
    if (_todoController.text.isEmpty) {
      showMsg(context, 'Todo name is not found');
      return;
    }
    if (priority == null) {
      showMsg(context, 'Priority not found');
      return;
    }
    if (selectedDate == null) {
      showMsg(context, 'Date not found');
      return;
    }
    if (selectedTime == null) {
      showMsg(context, 'Time not found');
    }
    final todo = TodoModel(
        id: DateTime.now().microsecondsSinceEpoch,
        name: _todoController.text,
        priority: priority!,
        date: selectedDate!,
        time: selectedTime!);
    Provider.of<TodoProvider>(context, listen: false).addTodo(todo);

    Navigator.pop(context);
  }
}
