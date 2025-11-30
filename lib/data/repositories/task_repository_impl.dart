import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  // In a real app, you would inject a DataSource here
  final List<TaskModel> _mockData = [];

  @override
  Future<List<Task>> getTasks() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData;
  }

  @override
  Future<void> addTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _mockData.add(TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
    ));
  }

  @override
  Future<void> updateTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _mockData.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _mockData[index] = TaskModel(
        id: task.id,
        title: task.title,
        isCompleted: task.isCompleted,
      );
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _mockData.removeWhere((t) => t.id == id);
  }
}
