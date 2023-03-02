// ignore_for_file: invalid_annotation_target

import 'package:appflowy_board/appflowy_board.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.g.dart';
part 'models.freezed.dart';

@freezed
class Task with _$Task {
  const Task._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Task({
    required String groupId,
    required String projectId,
    required String id,
    String? content,
    required String title,
    required int durationSpentInSec,
    required bool isCompleted,
    required int lastStartTimestamp,
    required bool isRunning,
    int? compilationTimestamp,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.fromFirebaseSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = {
      ...snapshot.data(),
      'id': snapshot.id,
    };
    return _$TaskFromJson(map);
  }

  Map<String, dynamic> toFirebaseMap() {
    final map = toJson();
    map.remove('id');
    return map;
  }
}

@freezed
class Group with _$Group {
  const Group._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Group({
    required String id,
    required String projectId,
    required String title,
    required String color,
  }) = _Group;
  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  factory Group.fromFirebaseSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = {
      ...snapshot.data(),
      'id': snapshot.id,
    };
    return _$GroupFromJson(map);
  }

  Map<String, dynamic> toFirebaseMap() {
    final map = toJson();
    map.remove('id');
    return map;
  }
}

class TaskGroupItem extends AppFlowyGroupItem {
  final Task task;
  TaskGroupItem({
    required this.task,
  });

  @override
  String get id => task.id;
}

@freezed
class Project with _$Project {
  const Project._();

  @JsonSerializable()
  const factory Project({
    required String id,
    required String title,
    required String color,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  factory Project.fromFirebaseSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = {
      ...snapshot.data(),
      'id': snapshot.id,
    };
    return _$ProjectFromJson(map);
  }
  Map<String, dynamic> toFirebaseMap() {
    final map = toJson();
    map.remove('id');
    return map;
  }
}

@Freezed(makeCollectionsUnmodifiable: true)
class GroupedTasks with _$GroupedTasks {
  const GroupedTasks._();

  const factory GroupedTasks({
    required Group group,
    required List<Task> tasks,
  }) = _GroupedTasks;
}

@Freezed(makeCollectionsUnmodifiable: true)
class ProjectStructure with _$ProjectStructure {
  const ProjectStructure._();

  @JsonSerializable(
    fieldRename: FieldRename.snake,
    explicitToJson: true,
  )
  const factory ProjectStructure({
    required String id,
    required List<String> groupsOrder,
    required List<TaskGroupOrder> groupedTasksOrder,
  }) = _ProjectStructure;

  factory ProjectStructure.fromJson(Map<String, dynamic> json) => _$ProjectStructureFromJson(json);

  factory ProjectStructure.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = {
      'id': snapshot.id,
      ...snapshot.data()!,
    };
    return _$ProjectStructureFromJson(json);
  }

  Map<String, dynamic> toFirebaseMap() {
    final jsonMap = toJson();
    jsonMap.remove('id');
    return jsonMap;
  }
}

@Freezed(makeCollectionsUnmodifiable: true)
class TaskGroupOrder with _$TaskGroupOrder {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TaskGroupOrder({
    required String id,
    required List<String> tasksIds,
  }) = _TaskGroupOrder;

  factory TaskGroupOrder.fromJson(Map<String, dynamic> json) => _$TaskGroupOrderFromJson(json);
}
