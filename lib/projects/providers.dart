import 'dart:developer' show log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/shared/constants.dart';
import 'package:taskify/shared/models.dart';
import 'package:taskify/shared/repository/tasks_repo.dart';

final sharePrefProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('SharePref should be overridden'),
);

final projectIdProvider = Provider<String>((ref) => throw UnimplementedError('error'));

final projectProvider = Provider(
  (ref) {
    final projectId = ref.watch(projectIdProvider);
    final projects = ref.watch(projectsProvider).valueOrNull;

    if (projects == null) return null;
    return projects.firstWhereOrNull((element) => element.id == projectId);
  },
  dependencies: [
    projectIdProvider,
    projectsProvider,
  ],
);

final projectsProvider = StreamProvider(
  (ref) {
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.project)
        .snapshots()
        .map((event) => event.docs.map(Project.fromFirebaseSnapshot));
  },
  dependencies: [projectIdProvider],
);

final groupsProvider = StreamProvider(
  (ref) {
    ref.onDispose(() {
      log('groupsProvider disposed');
    });
    final projectId = ref.watch(projectIdProvider);
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.group)
        .where('project_id', isEqualTo: projectId)
        .snapshots()
        .map((event) => event.docs.map(Group.fromFirebaseSnapshot));
  },
  dependencies: [projectIdProvider],
);

final tasksProvider = StreamProvider(
  (ref) {
    ref.onDispose(() {
      log('tasksProvider disposed');
    });
    final projectId = ref.watch(projectIdProvider);

    return FirebaseFirestore.instance
        .collection(FirebaseCollections.task)
        .where('project_id', isEqualTo: projectId)
        .snapshots()
        .map((event) => event.docs.map(Task.fromFirebaseSnapshot));
  },
  dependencies: [projectIdProvider],
);

final groupsTasksOrderProvider = StreamProvider(
  (ref) {
    ref.onDispose(() {
      log('groupsTasksOrderProvider disposed');
    });
    final projectId = ref.watch(projectIdProvider);

    return TasksRepo.projectGroupTasksOrderedCollection
        .doc(projectId)
        .snapshots()
        .map(ProjectGroupsOrderStructure.fromFirebaseSnapshot);
  },
  dependencies: [projectIdProvider],
);

final groupedTasksProvider = Provider(
  (ref) {
    ref.onDispose(() {
      log('groupedTasksProvider  disposed');
    });
    final asyncGroups = ref.watch(groupsProvider);
    final asyncTasks = ref.watch(tasksProvider);
    final asyncGroupsTasksOrder = ref.watch(groupsTasksOrderProvider);

    if (asyncGroups.hasValue && asyncTasks.hasValue && asyncGroupsTasksOrder.hasValue) {
      final tasks = asyncTasks.requireValue;
      final groups = asyncGroups.requireValue;
      final groupsTasksOrder = asyncGroupsTasksOrder.requireValue;

      final groupedTasks = <GroupedTasks>[];

      for (final groupId in groupsTasksOrder.groupsOrder) {
        final grouptaskOrder =
            groupsTasksOrder.groupedTasksOrder.firstWhere((element) => element.id == groupId).tasksIds;

        final group = groups.firstWhere((element) => element.id == groupId);

        final tasksIdMap = tasks.map((e) => MapEntry(e.id, e)).toMap();

        final orderedTasks = grouptaskOrder.map((id) => tasksIdMap[id]).whereNotNull();
        groupedTasks.add(
          GroupedTasks(
            group: group,
            tasks: UnmodifiableListView(orderedTasks),
          ),
        );
      }

      return groupedTasks;
    }

    return null;
  },
  dependencies: [
    groupsProvider,
    tasksProvider,
    groupsTasksOrderProvider,
  ],
);

final completedTasksProvider = Provider.autoDispose(
  (ref) {
    return ref.watch(
      tasksProvider.select(
        (asyncTasks) => asyncTasks.valueOrNull?.where((task) => task.isCompleted) ?? [],
      ),
    );
  },
  dependencies: [tasksProvider],
);

extension<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() {
    final map = <K, V>{};
    forEach((element) {
      map[element.key] = element.value;
    });
    return map;
  }
}
