// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      groupId: json['group_id'] as String,
      projectId: json['project_id'] as String,
      id: json['id'] as String,
      content: json['content'] as String?,
      title: json['title'] as String,
      durationSpentInSec: json['duration_spent_in_sec'] as int,
      isCompleted: json['is_completed'] as bool,
      lastStartTimestamp: json['last_start_timestamp'] as int,
      isRunning: json['is_running'] as bool,
      compilationTimestamp: json['compilation_timestamp'] as int?,
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'group_id': instance.groupId,
      'project_id': instance.projectId,
      'id': instance.id,
      'content': instance.content,
      'title': instance.title,
      'duration_spent_in_sec': instance.durationSpentInSec,
      'is_completed': instance.isCompleted,
      'last_start_timestamp': instance.lastStartTimestamp,
      'is_running': instance.isRunning,
      'compilation_timestamp': instance.compilationTimestamp,
    };

_$_Group _$$_GroupFromJson(Map<String, dynamic> json) => _$_Group(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      title: json['title'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$$_GroupToJson(_$_Group instance) => <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'title': instance.title,
      'color': instance.color,
    };

_$_Project _$$_ProjectFromJson(Map<String, dynamic> json) => _$_Project(
      id: json['id'] as String,
      title: json['title'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$$_ProjectToJson(_$_Project instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': instance.color,
    };

_$_ProjectStructure _$$_ProjectStructureFromJson(Map<String, dynamic> json) =>
    _$_ProjectStructure(
      id: json['id'] as String,
      groupsOrder: (json['groups_order'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      groupedTasksOrder: (json['grouped_tasks_order'] as List<dynamic>)
          .map((e) => TaskGroupOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ProjectStructureToJson(_$_ProjectStructure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groups_order': instance.groupsOrder,
      'grouped_tasks_order':
          instance.groupedTasksOrder.map((e) => e.toJson()).toList(),
    };

_$_TaskGroupOrder _$$_TaskGroupOrderFromJson(Map<String, dynamic> json) =>
    _$_TaskGroupOrder(
      id: json['id'] as String,
      tasksIds:
          (json['tasks_ids'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_TaskGroupOrderToJson(_$_TaskGroupOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tasks_ids': instance.tasksIds,
    };
