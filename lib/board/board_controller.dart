import 'dart:developer';

import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/shared/models.dart';
import 'package:taskify/shared/repository/tasks_repo.dart';

final boardControllerProvider = Provider.autoDispose((ref) {
  final controller = BoardController(ref);
  ref.onDispose(
    () {
      log('boardControllerProvider group tasks');
      controller.dispose();
    },
  );

  return controller;
});

class BoardController {
  BoardController(this.ref) {
    appFlowyBoardController = AppFlowyBoardController(
      onMoveGroup: _onMoveGroup,
      onMoveGroupItem: _onMoveGroupItem,
      onMoveGroupItemToGroup: _onMoveGroupItemToGroup,
    )..enableGroupDragging(false);

    appFlowyBoardController.addListener(boardContentListener);
  }

  final Ref ref;

  late final AppFlowyBoardController appFlowyBoardController;

  TasksRepo get tasksRepo => ref.read(taskRepoProvider);

  Iterable<AppFlowyGroupController> get _controllers =>
      appFlowyBoardController.groupIds.map((e) => appFlowyBoardController.getGroupController(e)!);

  final isDraggableNotifier = ValueNotifier(false);
  final isBoardEmptyNotifier = ValueNotifier(false);

  bool get isAllDraggable {
    return isDraggableNotifier.value;
  }

  set isAllDraggable(bool value) {
    appFlowyBoardController.enableGroupDragging(value);
    isDraggableNotifier.value = value;
  }

  void _onMoveGroup(
    String fromGroupId,
    int fromIndex,
    String toGroupId,
    int toIndex,
  ) {
    final projectId = (_controllers.first.groupData.customData as Group).projectId;
    final newOrder = _controllers.map((e) => e.groupData.id).toList();

    tasksRepo.updateGroupsOrder(projectId, newOrder);
  }

  void _onMoveGroupItem(
    String groupId,
    int fromIndex,
    int toIndex,
  ) {
    log(
      'Task $fromIndex -> $toIndex',
      name: 'Group: $groupId',
    );

    final groupController = appFlowyBoardController.controller(groupId)!;
    final group = groupController.groupData.customData as Group;
    final groupOrder = groupController.items.map((e) => e.id).toList();
    tasksRepo.changeTasksOrder(group, groupOrder);
  }

  void _onMoveGroupItemToGroup(
    String fromGroupId,
    int fromIndex,
    String toGroupId,
    int toIndex,
  ) {
    final fromGroupController = appFlowyBoardController.getGroupController(fromGroupId)!;
    final toGroupController = appFlowyBoardController.getGroupController(toGroupId)!;

    final fromGroup = fromGroupController.groupData.customData as Group;
    final toGroup = toGroupController.groupData.customData as Group;

    final fromGroupTasksOrder = fromGroupController.items.map((e) => e.id);
    final toGroupTasksOrder = toGroupController.items.map((e) => e.id);

    final taskGroupItem = toGroupController.items[toIndex] as TaskGroupItem;
    log('${fromGroupController.items.length}', name: 'From');
    log('${toGroupController.items.length}', name: 'To');

    tasksRepo.updateTaskGroup(
      task: taskGroupItem.task,
      oldGroup: fromGroup,
      newGroup: toGroup,
      oldGroupOrder: fromGroupTasksOrder.toList(),
      newGroupOrder: toGroupTasksOrder.toList(),
    );
  }

  Future<void> deleteTask(Task task) async {
    await tasksRepo.deleteTask(task);
  }

  Future<void> addTask(Task task) async {
    await tasksRepo.addTask(task);
  }

  Future<void> updateTask({
    required Task newTask,
    required Task oldTask,
  }) async {
    if (oldTask.groupId != newTask.groupId) {
      final fromGroupController = appFlowyBoardController.getGroupController(oldTask.groupId)!;
      final toGroupController = appFlowyBoardController.getGroupController(newTask.groupId)!;
      final fromGroup = fromGroupController.groupData.customData as Group;
      final toGroup = toGroupController.groupData.customData as Group;

      final fromGroupTasksOrder = [...fromGroupController.items.map((e) => e.id)]
        ..retainWhere((id) => id != newTask.id);

      final toGroupTasksOrder = [...toGroupController.items.map((e) => e.id), newTask.id];

      await tasksRepo.updateTaskGroup(
        task: newTask,
        oldGroup: fromGroup,
        newGroup: toGroup,
        oldGroupOrder: fromGroupTasksOrder.toList(),
        newGroupOrder: toGroupTasksOrder.toList(),
      );
    }
    await tasksRepo.updateTask(newTask);
  }

  Future<void> startTask(Task task) async {
    await tasksRepo.startTimer(task);
  }

  Future<void> markCompleted(Task task, bool value) async {
    tasksRepo.markTaskCompletion(task: task, value: value);
  }

  Future<void> stopTask(Task task) async {
    tasksRepo.stopTimer(task);
  }

  void boardContentListener() {
    isBoardEmptyNotifier.value = appFlowyBoardController.groupIds.isEmpty;
  }

  void dispose() {
    appFlowyBoardController.removeListener(boardContentListener);
    appFlowyBoardController.dispose();
  }
}
