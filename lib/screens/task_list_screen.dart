import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/bloc/task_bloc.dart';
import 'package:todo_list/bloc/task_event.dart';
import 'package:todo_list/model/task.dart';

class TaskList extends StatelessWidget {
  final TextEditingController title;
  final TextEditingController description;
  final TextEditingController time;
  TaskList(this.title, this.description, this.time);

  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: BlocConsumer<TaskBloc, List<Task>>(
        builder: (context, taskList) {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      taskList[index].title.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      '${taskList[index].description}\n${_dateFormat.format(taskList[index].time)}',
                      style: TextStyle(fontSize: 15),
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () {
                        context.read<TaskBloc>().add(TaskEvent.delete(index));
                        title.clear();
                        description.clear();
                        time.clear();
                      },
                    ),
                    onTap: () {
                      title.text = taskList[index].title;
                      description.text = taskList[index].description;
                      time.text = _dateFormat.format(taskList[index].time);
                    },
                  ),
                );
              });
        },
        listener: (context, taskList) {
          Scaffold.of(context)
              // ignore: deprecated_member_use
              .showSnackBar(
                  SnackBar(content: Text('The task was added to your list!')));
        },
        listenWhen: (List<Task> previousState, List<Task> currentState) {
          if (currentState.length > previousState.length) {
            return true;
          }
          return false;
        },
        buildWhen: (List<Task> previousState, List<Task> currentState) {
          return true;
        },
      ),
    );
  }
}
