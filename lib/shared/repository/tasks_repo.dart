import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/shared/constants.dart';
import 'package:taskify/shared/extensions/date_time_x.dart';
import 'package:taskify/shared/models.dart';

final taskRepoProvider = Provider((ref) => TasksRepo());

class TasksRepo {
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get taskCollection => firestore.collection(FirebaseCollections.task);

  static CollectionReference<Map<String, dynamic>> get projectCollection =>
      firestore.collection(FirebaseCollections.project);

  static CollectionReference<Map<String, dynamic>> get groupCollection =>
      firestore.collection(FirebaseCollections.group);

  static CollectionReference<Map<String, dynamic>> get projectStructureCollection =>
      firestore.collection(FirebaseCollections.projectStructure);

  Future<void> startTimer(Task task) async {
    if (task.isRunning) return;
    taskCollection.doc(task.id).update(task
        .copyWith(
          isRunning: true,
          lastStartTimestamp: DateTime.now().unixTimestamp,
        )
        .toFirebaseMap());
  }

  Future<void> stopTimer(Task task) async {
    if (task.isRunning == false) return;
    final durationDiff = DateTime.now().unixTimestamp - task.lastStartTimestamp;
    final newDuration = durationDiff + task.durationSpentInSec;
    final newTask = task.copyWith(
      durationSpentInSec: newDuration,
      isRunning: false,
    );
    await taskCollection.doc(task.id).update(newTask.toFirebaseMap());
  }

  Future<void> updateTaskGroup({
    required Group oldGroup,
    required Group newGroup,
    required Task task,
    required List<String> oldGroupOrder,
    required List<String> newGroupOrder,
  }) async {
    final taskRef = taskCollection.doc(task.id);
    final structureRef = projectStructureCollection.doc(task.projectId);

    await firestore.runTransaction((transaction) async {
      final orderMap = await transaction.get(structureRef);
      transaction.update(taskRef, task.copyWith(groupId: newGroup.id).toFirebaseMap());
      final structure = ProjectStructure.fromFirebaseSnapshot(orderMap);

      final newGroupOrders = structure.groupedTasksOrder.map((e) {
        if (e.id == oldGroup.id) {
          return e.copyWith(tasksIds: oldGroupOrder);
        }

        if (e.id == newGroup.id) {
          return e.copyWith(tasksIds: newGroupOrder);
        }
        return e;
      }).toList();
      final newProjectStructure = structure.copyWith(groupedTasksOrder: newGroupOrders);
      transaction.update(structureRef, newProjectStructure.toFirebaseMap());
    });
  }

  Future<void> deleteTask(Task task) async {
    await taskCollection.doc(task.id).delete();
  }

  void changeTasksOrder(Group group, List<String> newIdsOrder) async {
    final projectId = group.projectId;
    final structureSnapshot = await projectStructureCollection.doc(projectId).get();

    final structure = ProjectStructure.fromFirebaseSnapshot(structureSnapshot);
    final oldGroupIds = structure.groupedTasksOrder.firstWhere((element) => element.id == group.id);
    final newGroupIds = oldGroupIds.copyWith(tasksIds: newIdsOrder);

    final newGroupTasksOrder = structure.groupedTasksOrder.map((item) => item.id == group.id ? newGroupIds : item);

    final newProjectStructure = structure.copyWith(groupedTasksOrder: newGroupTasksOrder.toList());
    projectStructureCollection.doc(newProjectStructure.id).update(newProjectStructure.toFirebaseMap());
  }

  Future<Task> addTask(Task task) async {
    final projectId = task.projectId;
    final groupId = task.groupId;

    final docId = projectId;
    final structureSnapshot = await projectStructureCollection.doc(docId).get();

    final structure = ProjectStructure.fromFirebaseSnapshot(structureSnapshot);
    final groupTasksOrder = structure.groupedTasksOrder.firstWhere((item) => item.id == groupId);

    final taskDocRef = await taskCollection.add(task.toFirebaseMap());
    final taskId = taskDocRef.id;

    final newGroupOrder = groupTasksOrder.copyWith(tasksIds: [
      ...groupTasksOrder.tasksIds,
      taskId,
    ]);

    final newGroupTasksOrder = structure.groupedTasksOrder.map((k) => k.id == groupId ? newGroupOrder : k);

    final newProjectStructure = structure.copyWith(groupedTasksOrder: newGroupTasksOrder.toList());
    projectStructureCollection.doc(newProjectStructure.id).update(newProjectStructure.toFirebaseMap());

    return task.copyWith(id: taskId);
  }

  Future<void> updateGroupsOrder(String projectID, List<String> newOrder) async {
    final structureSnapshot = await projectStructureCollection.doc(projectID).get();
    final structure = ProjectStructure.fromFirebaseSnapshot(structureSnapshot);

    final newProjectStructure = structure.copyWith(groupsOrder: newOrder);
    await projectStructureCollection.doc(projectID).update(newProjectStructure.toFirebaseMap());
  }

  Future<void> updateTask(Task task) async {
    taskCollection.doc(task.id).update(task.toFirebaseMap());
  }

  Future<void> markTaskCompletion({
    required Task task,
    required bool value,
  }) async {
    Task newTask = task;
    if (newTask.isRunning == true) {
      final durationDiff = DateTime.now().unixTimestamp - newTask.lastStartTimestamp;
      final newDuration = durationDiff + newTask.durationSpentInSec;
      newTask = newTask.copyWith(
        durationSpentInSec: newDuration,
        isRunning: false,
      );
    }

    if (value) {
      newTask = newTask.copyWith(
        isCompleted: true,
        compilationTimestamp: DateTime.now().unixTimestamp,
      );
    } else {
      newTask = newTask.copyWith(
        isCompleted: false,
        compilationTimestamp: null,
      );
    }
    await taskCollection.doc(task.id).update(newTask.toFirebaseMap());
  }
}
