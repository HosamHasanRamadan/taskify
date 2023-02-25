import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/shared/constants.dart';
import 'package:taskify/shared/models.dart';
import 'package:taskify/projects/providers.dart';

final projectRepoProvider = Provider((ref) => ProjectsRepo());

class ProjectsRepo {
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get projectCollection =>
      firestore.collection(FirebaseCollections.project);

  static CollectionReference<Map<String, dynamic>> get groupCollection =>
      firestore.collection(FirebaseCollections.group);

  static CollectionReference<Map<String, dynamic>> get projectGroupTasksOrderedCollection =>
      firestore.collection(FirebaseCollections.projectGroupTasksOrdered);

  Future<void> addProject(Project project) async {
    final ref = await projectCollection.add(project.toFirebaseMap());
    final emptyStructure = ProjectGroupsOrderStructure(
      id: ref.id,
      groupsOrder: [],
      groupedTasksOrder: [],
    );
    await projectGroupTasksOrderedCollection.doc(ref.id).set(emptyStructure.toFirebaseMap());
  }

  Future<void> addGroup(Group group) async {
    final ref = await groupCollection.add(group.toFirebaseMap());
    final structureSnapShot = await projectGroupTasksOrderedCollection.doc(group.projectId).get();
    final structure = ProjectGroupsOrderStructure.fromFirebaseSnapshot(structureSnapShot);
    final newGroupsOrder = [...structure.groupsOrder, ref.id];
    final newTasksGroupOrder = [...structure.groupedTasksOrder, TaskGroupOrder(id: ref.id, tasksIds: [])];
    final newStructure = structure.copyWith(
      groupsOrder: newGroupsOrder,
      groupedTasksOrder: newTasksGroupOrder,
    );
    await projectGroupTasksOrderedCollection.doc(group.projectId).update(newStructure.toFirebaseMap());
  }

  Future<void> updateGroup(Group group) async {
    await groupCollection.doc(group.id).update(group.toFirebaseMap());
  }
}
