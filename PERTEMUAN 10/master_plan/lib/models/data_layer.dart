// lib/models/data_layer.dart
class Task {
  final String description;
  final bool complete;

  const Task({this.description = '', this.complete = false});

  Task copyWith({String? description, bool? complete}) {
    return Task(
      description: description ?? this.description,
      complete: complete ?? this.complete,
    );
  }
}

class Plan {
  final String name;
  final List<Task> tasks;

  const Plan({this.name = '', this.tasks = const []});

  Plan copyWith({String? name, List<Task>? tasks}) {
    return Plan(
      name: name ?? this.name,
      tasks: tasks ?? this.tasks,
    );
  }

  int get completedCount => tasks.where((task) => task.complete).length;

  String get completenessMessage =>
      '$completedCount out of ${tasks.length} tasks';
}