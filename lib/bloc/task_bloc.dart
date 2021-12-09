import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/task_event.dart';
import 'package:todo_list/model/task.dart';

class TaskBloc extends Bloc<TaskEvent, List<Task>> {
  TaskBloc(List<Task> initialState) : super(initialState) {
    on<TaskEvent>((taskEvent, emit) {
      switch (taskEvent.eventType) {
        case EventType.add:
          List<Task> newstate = List.from(state);
          if (taskEvent.task != null) {
            newstate.add(taskEvent.task);
          }
          emit(newstate);
          break;
        case EventType.delete:
          List<Task> newstate = List.from(state); // the current state
          newstate.removeAt(taskEvent.taskIndex); 
          emit(newstate);
          break;
        default:
          throw Exception('Error in maping');
      }
    });
  }
}
