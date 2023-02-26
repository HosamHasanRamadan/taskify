import 'dart:async';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:duration/duration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:taskify/board/board_controller.dart';
import 'package:taskify/board/completed_tasks_dialog.dart';
import 'package:taskify/board/export_csv.dart';
import 'package:taskify/board/group_form.dart';
import 'package:taskify/board/task_form.dart';
import 'package:taskify/shared/extensions/context_x.dart';
import 'package:taskify/shared/extensions/date_time_x.dart';
import 'package:taskify/shared/models.dart';
import 'package:taskify/projects/providers.dart';
import 'package:taskify/shared/repository/tasks_repo.dart';

part 'widgets.dart';

class Board extends ConsumerStatefulWidget {
  const Board({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<Board> createState() => _BoardState();
}

class _BoardState extends ConsumerState<Board> {
  BoardController get boardController => ref.read(boardControllerProvider);

  AppFlowyBoardController get controller => boardController.appFlowyBoardController;

  late AppFlowyBoardScrollController boardScrollController;
  late final ProviderSubscription subscription;
  final speedDialController = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    boardScrollController = AppFlowyBoardScrollController();

    subscription = ref.listenManual<List<GroupedTasks>?>(
      fireImmediately: true,
      groupedTasksProvider,
      (previous, groupedTasks) {
        if (groupedTasks == null) return;
        controller.clear();

        for (final group in groupedTasks) {
          final kanbanGroup = AppFlowyGroupData<Group>(
            customData: group.group,
            id: group.group.id,
            name: group.group.title,
            items: [...group.tasks.where((e) => e.isCompleted == false).map((e) => TaskGroupItem(task: e))],
          );
          kanbanGroup.draggable = boardController.isAllDraggable;
          controller.addGroup(kanbanGroup, notify: false);
        }
        controller.enableGroupDragging(boardController.isAllDraggable);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(boardControllerProvider);
    final isLoading = ref.watch(groupedTasksProvider.select((value) => value == null));
    if (isLoading) return loading();
    return ValueListenableBuilder(
      valueListenable: controller.isBoardEmptyNotifier,
      builder: (context, isEmpty, child) {
        if (isEmpty) return emptyBuilder();
        return boardBuilder();
      },
    );
  }

  Widget loading() {
    return Scaffold(
      appBar: AppBar(
        title: title(),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is TaskGroupItem) {
      return TaskCard(
        task: item.task,
        onTab: () {
          showTaskForm(item.task);
        },
        key: ValueKey(item.id),
      );
    }

    throw UnimplementedError();
  }

  Widget title() {
    return Consumer(
      builder: (context, ref, child) {
        final project = ref.watch(projectProvider);
        return Text(project?.title ?? '');
      },
    );
  }

  Widget boardBuilder() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: title(),
        actions: appBarActions(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: AppFlowyBoard(
          controller: boardController.appFlowyBoardController,
          boardScrollController: boardScrollController,
          groupConstraints: const BoxConstraints.tightFor(width: 300),
          config: AppFlowyBoardConfig(
            groupBackgroundColor: Theme.of(context).colorScheme.inversePrimary,
            groupPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          cardBuilder: (context, group, groupItem) {
            return _buildCard(groupItem);
          },
          headerBuilder: (context, columnData) {
            final customData = columnData.customData as Group;
            return GroupHeader(
              padding: const EdgeInsets.all(8),
              label: Text(columnData.headerData.groupName),
              color: HexColor(customData.color),
              onEditButtonPressed: () {
                showGroupFormDialog(customData);
              },
            );
          },
        ),
      ),
      floatingActionButton: SpeedDial(
        openCloseDial: speedDialController,
        icon: Icons.add,
        onPress: () {
          speedDialController.value = !speedDialController.value;
        },
        children: [
          SpeedDialChild(
            onTap: () {
              showTaskForm();
            },
            label: 'Add task',
            child: const Icon(Icons.add_task),
          ),
          SpeedDialChild(
            onTap: () {
              showGroupFormDialog();
            },
            label: 'Add group',
            child: const Icon(Icons.collections_bookmark),
          )
        ],
      ),
    );
  }

  void showTaskForm([Task? task]) {
    showDialog(
      context: context,
      builder: (_) {
        return ProviderScope(
          parent: ProviderScope.containerOf(context),
          child: TaskForm(
            groups: ref.read(groupsProvider).valueOrNull?.toList() ?? [],
            initialTask: task,
          ),
        );
      },
    );
  }

  List<Widget> appBarActions() {
    return [
      AnimatedBuilder(
        animation: boardController.isDraggableNotifier,
        builder: (context, child) {
          if (boardController.isAllDraggable) {
            return IconButton(
              onPressed: () {
                boardController.isAllDraggable = false;
              },
              icon: const Icon(Icons.calendar_view_week_sharp),
            );
          }

          return IconButton(
            onPressed: () {
              boardController.isAllDraggable = true;
            },
            icon: const Icon(Icons.edit),
          );
        },
      ),
      Consumer(
        builder: (context, ref, child) {
          final project = ref.watch(projectProvider);
          return PopupMenuButton(
            itemBuilder: (context) {
              return [
                if (project != null && kIsWeb == true)
                  PopupMenuItem(
                    onTap: () {
                      shareWeb(
                        projectName: project.title,
                        groups: ref.read(groupedTasksProvider) ?? [],
                      );
                    },
                    child: const Text('Export to CSV'),
                  ),
                if (project != null && kIsWeb == false) ...[
                  PopupMenuItem(
                    onTap: () {
                      exportProjectToCSV(
                        projectName: project.title,
                        groups: ref.read(groupedTasksProvider) ?? [],
                      );
                    },
                    child: const Text('Export to CSV'),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      shareAsCsv(
                        projectName: project.title,
                        groups: ref.read(groupedTasksProvider) ?? [],
                      );
                    },
                    child: const Text('Share as CSV'),
                  ),
                ],
                PopupMenuItem(
                  child: const Text('Completed tasks'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return ProviderScope(
                          parent: ProviderScope.containerOf(context),
                          child: const CompletedTaskDialog(),
                        );
                      },
                    );
                  },
                ),
                PopupMenuItem(
                  child: const Text('Order groups'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return ProviderScope(
                          parent: ProviderScope.containerOf(context),
                          child: GroupsOrderDialog(
                            initialGroupOrder: controller.groupDatas.map((e) => e.customData as Group).toList(),
                          ),
                        );
                      },
                    );
                  },
                )
              ];
            },
          );
        },
      )
    ];
  }

  Widget emptyBuilder() {
    return Scaffold(
      appBar: AppBar(
        title: title(),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                showGroupFormDialog();
              },
              iconSize: 100,
              icon: const Icon(Icons.add_circle),
            ),
            const SizedBox(height: 16),
            Text(
              'Add Group',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
      ),
    );
  }

  void showGroupFormDialog([Group? group]) {
    showDialog(
      context: context,
      builder: (_) => ProviderScope(
        parent: ProviderScope.containerOf(context),
        child: GroupForm(initialGroup: group),
      ),
    );
  }

  @override
  void dispose() {
    subscription.close();
    super.dispose();
  }
}
