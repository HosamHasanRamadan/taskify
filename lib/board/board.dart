import 'dart:async';
import 'dart:convert';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:csv/csv.dart';
import 'package:duration/duration.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taskify/board/board_controller.dart';
import 'package:taskify/board/completed_tasks_dialog.dart';
import 'package:taskify/board/group_form.dart';
import 'package:taskify/board/task_form.dart';
import 'package:taskify/shared/extensions/context_x.dart';
import 'package:taskify/shared/extensions/date_time_x.dart';
import 'package:taskify/shared/models.dart';
import 'package:taskify/projects/providers.dart';
import 'package:taskify/shared/repository/tasks_repo.dart';
import "package:universal_html/html.dart" as html;
import 'package:universal_io/io.dart';

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

    subscription = ref.listenManual<List<GroupedTasks>>(
      fireImmediately: true,
      groupedTasksProvider,
      (previous, groupedTasks) {
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
  void dispose() {
    subscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(boardControllerProvider);
    return ValueListenableBuilder(
      valueListenable: controller.isBoardEmptyNotifier,
      builder: (context, isEmpty, child) {
        if (isEmpty) return emptyBuilder();
        return boardBuilder();
      },
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
        actions: [
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
                            groups: ref.read(groupedTasksProvider),
                          );
                        },
                        child: const Text('Share Web'),
                      ),
                    if (project != null && kIsWeb == false) ...[
                      PopupMenuItem(
                        onTap: () {
                          exportProjectToCSV(
                            projectName: project.title,
                            groups: ref.read(groupedTasksProvider),
                          );
                        },
                        child: const Text('Export to CSV'),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          shareAsCsv(
                            projectName: project.title,
                            groups: ref.read(groupedTasksProvider),
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
        ],
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
            // final taskProgress = groupId.idToTaskProgress;
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
}

Future<bool> shareAsCsv({
  required String projectName,
  required List<GroupedTasks> groups,
}) async {
  final finalName = '$projectName.csv';
  var path = (await getTemporaryDirectory()).path;
  final csvFile = File('$path/$finalName');

  final result = createCSV(projectName: projectName, groups: groups);
  csvFile.writeAsString(result);
  Share.shareXFiles([XFile(csvFile.path)]);
  return true;
}

Future<bool> exportProjectToCSV({
  required String projectName,
  required List<GroupedTasks> groups,
}) async {
  final permessionResult = await [
    Permission.storage,
    Permission.manageExternalStorage,
  ].request();

  for (final perm in permessionResult.entries) {
    if (perm.value.isGranted == false) return false;
  }

  final fileName = '$projectName.csv';

  final path = await FilePicker.platform.getDirectoryPath();
  if (path == null) return false;
  final csvFile = File('$path/$fileName');

  final result = createCSV(projectName: projectName, groups: groups);
  csvFile.writeAsString(result);
  return true;
}

Future<void> shareWeb({
  required String projectName,
  required List<GroupedTasks> groups,
}) async {
  final result = createCSV(projectName: projectName, groups: groups);
  // prepare
  final bytes = utf8.encode(result);
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = '$projectName.csv';
  html.document.body?.children.add(anchor);

// download
  anchor.click();

// cleanup
  html.document.body?.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}

String createCSV({
  required String projectName,
  required List<GroupedTasks> groups,
}) {
  final rows = <List<dynamic>>[];
  final header = [
    'group',
    'title',
    'duration',
    'is_completed',
    'content',
  ];

  rows.add(header);

  for (final group in groups) {
    for (final task in group.tasks) {
      rows.add([
        group.group.title,
        task.title,
        task.durationSpentInSec,
        task.isCompleted,
        task.content,
      ]);
    }
  }
  return const ListToCsvConverter().convert(rows);
}
