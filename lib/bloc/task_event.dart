import 'package:todo_list/model/task.dart';

enum EventType { add, delete }

class TaskEvent {
  Task task;
  int taskIndex;
  EventType eventType;

  TaskEvent.add(Task task) {
    this.eventType = EventType.add;
    this.task = task;
  }

  TaskEvent.delete(int index) {
    this.eventType = EventType.delete;
    this.taskIndex = index;
  }
}
