import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/shared/constants.dart';
import 'package:taskify/shared/extensions/date_time_x.dart';
import 'package:taskify/shared/models.dart';
import 'package:taskify/projects/providers.dart';

final taskRepoProvider = Provider((ref) => TasksRepo());

class TasksRepo {
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get taskCollection => firestore.collection(FirebaseCollections.task);

  static CollectionReference<Map<String, dynamic>> get projectCollection =>
      firestore.collection(FirebaseCollections.project);

  static CollectionReference<Map<String, dynamic>> get groupCollection =>
      firestore.collection(FirebaseCollections.group);

  static CollectionReference<Map<String, dynamic>> get projectGroupTasksOrderedCollection =>
      firestore.collection(FirebaseCollections.projectGroupTasksOrdered);

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
    final projecttaskOrderRef = projectGroupTasksOrderedCollection.doc(task.projectId);

    firestore.runTransaction((transaction) async {
      final orderMap = await transaction.get(projecttaskOrderRef);
      transaction.update(taskRef, task.copyWith(groupId: newGroup.id).toFirebaseMap());
      final order = ProjectGroupsOrderStructure.fromFirebaseSnapshot(orderMap);

      final newGroupOrders = order.groupedTasksOrder.map((e) {
        if (e.id == oldGroup.id) {
          return e.copyWith(tasksIds: oldGroupOrder);
        }

        if (e.id == newGroup.id) {
          return e.copyWith(tasksIds: newGroupOrder);
        }
        return e;
      }).toList();
      final newprojectStructure = order.copyWith(groupedTasksOrder: newGroupOrders);
      transaction.update(projecttaskOrderRef, newprojectStructure.toFirebaseMap());
    });
  }

  Future<void> deleteTask(Task task) async {
    await taskCollection.doc(task.id).delete();
  }

  void changeTasksOrder(Group group, List<String> newIdsOrder) async {
    final projectId = group.projectId;
    final resultSnapshot = await projectGroupTasksOrderedCollection.doc(projectId).get();

    final a = ProjectGroupsOrderStructure.fromFirebaseSnapshot(resultSnapshot);
    final oldGroupIds = a.groupedTasksOrder.firstWhere((element) => element.id == group.id);
    final newGroupIds = oldGroupIds.copyWith(tasksIds: newIdsOrder);

    final newGroupTasksOrder = a.groupedTasksOrder.map((k) => k.id == group.id ? newGroupIds : k);

    final newProjectStructure = a.copyWith(groupedTasksOrder: newGroupTasksOrder.toList());
    projectGroupTasksOrderedCollection.doc(newProjectStructure.id).update(newProjectStructure.toFirebaseMap());
  }

  Future<Task> addTask(Task task) async {
    final projectId = task.projectId;
    final groupId = task.groupId;

    final docId = projectId;
    final resultSnapshot = await projectGroupTasksOrderedCollection.doc(docId).get();

    final a = ProjectGroupsOrderStructure.fromFirebaseSnapshot(resultSnapshot);
    final groupTasksOrder = a.groupedTasksOrder.firstWhere((k) => k.id == groupId);

    final taskDocRef = await taskCollection.add(task.toFirebaseMap());
    final taskId = taskDocRef.id;

    final newGroupOrder = groupTasksOrder.copyWith(tasksIds: [
      ...groupTasksOrder.tasksIds,
      taskId,
    ]);

    final newGroupTasksOrder = a.groupedTasksOrder.map((k) => k.id == groupId ? newGroupOrder : k);

    final newProjectStructure = a.copyWith(groupedTasksOrder: newGroupTasksOrder.toList());
    projectGroupTasksOrderedCollection.doc(newProjectStructure.id).update(newProjectStructure.toFirebaseMap());

    return task.copyWith(id: taskId);
  }

  Future<void> updateGroupsOrder(String projectID, List<String> newOrder) async {
    final resultSnapshot = await projectGroupTasksOrderedCollection.doc(projectID).get();
    final a = ProjectGroupsOrderStructure.fromFirebaseSnapshot(resultSnapshot);

    final newProjectStructure = a.copyWith(groupsOrder: newOrder);
    await projectGroupTasksOrderedCollection.doc(projectID).update(newProjectStructure.toFirebaseMap());
  }

  Future<void> updateTask(Task task) async {
    taskCollection.doc(task.id).update(task.toFirebaseMap());
  }

  Future<void> markTaskCompletion({
    required Task task,
    required bool value,
  }) async {
    Task newTask = task;
    if (task.isRunning == true) {
      final durationDiff = DateTime.now().unixTimestamp - task.lastStartTimestamp;
      final newDuration = durationDiff + task.durationSpentInSec;
      newTask = newTask.copyWith(
        durationSpentInSec: newDuration,
        isRunning: false,
      );
    }

    if (value) {
      newTask = Task(
        groupId: newTask.groupId,
        projectId: newTask.projectId,
        id: newTask.id,
        title: newTask.title,
        durationSpentInSec: newTask.durationSpentInSec,
        isCompleted: true,
        compilationTimestamp: DateTime.now().unixTimestamp,
        lastStartTimestamp: newTask.lastStartTimestamp,
        isRunning: newTask.isRunning,
        content: newTask.content,
      );
    } else {
      newTask = Task(
        groupId: newTask.groupId,
        projectId: newTask.projectId,
        id: newTask.id,
        title: newTask.title,
        durationSpentInSec: newTask.durationSpentInSec,
        isCompleted: false,
        compilationTimestamp: null,
        lastStartTimestamp: newTask.lastStartTimestamp,
        isRunning: newTask.isRunning,
        content: newTask.content,
      );
    }
    taskCollection.doc(task.id).update(newTask.toFirebaseMap());
  }
}
