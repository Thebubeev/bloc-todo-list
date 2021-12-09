import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/task_bloc.dart';
import 'package:todo_list/bloc/task_event.dart';
import 'package:todo_list/model/task.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/screens/task_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _time = TextEditingController();

  DateTime _date = DateTime.now(); // our time
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _time.text = _dateFormat.format(date);
    }
  }

  @override
  void initState() {
    _time.text = _dateFormat.format(_date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bloc To-do List'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _title,
                  decoration: InputDecoration(labelText: 'Title'),
                  onSaved: (val) {
                    setState(() {
                      _title.text = val;
                    });
                  },
                ),
                TextFormField(
                  controller: _description,
                  decoration: InputDecoration(labelText: 'Description'),
                  onSaved: (val) {
                    setState(() {
                      _description.text = val;
                    });
                  },
                ),
                TextFormField(
                  readOnly: true,
                  controller: _time,
                  onTap: _handleDatePicker,
                  decoration: InputDecoration(
                    labelText: 'Date',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<TaskBloc>().add(TaskEvent.add(Task(
                            title: _title.text,
                            description: _description.text,
                            time: _date)));
                        _title.clear();
                        _description.clear();
                        _time.clear();
                      },
                      child: Text('Save'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        _title.clear();
                        _description.clear();
                        _time.clear();
                      },
                      child: Text(
                        'Delete',
                      ),
                    ),
                  ],
                ),
                TaskList(_title, _description, _time)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
