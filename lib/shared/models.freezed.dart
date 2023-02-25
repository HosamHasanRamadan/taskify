// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get groupId => throw _privateConstructorUsedError;
  String get projectId => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get durationSpentInSec => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  int get lastStartTimestamp => throw _privateConstructorUsedError;
  bool get isRunning => throw _privateConstructorUsedError;
  int? get compilationTimestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String groupId,
      String projectId,
      String id,
      String? content,
      String title,
      int durationSpentInSec,
      bool isCompleted,
      int lastStartTimestamp,
      bool isRunning,
      int? compilationTimestamp});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? projectId = null,
    Object? id = null,
    Object? content = freezed,
    Object? title = null,
    Object? durationSpentInSec = null,
    Object? isCompleted = null,
    Object? lastStartTimestamp = null,
    Object? isRunning = null,
    Object? compilationTimestamp = freezed,
  }) {
    return _then(_value.copyWith(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      durationSpentInSec: null == durationSpentInSec
          ? _value.durationSpentInSec
          : durationSpentInSec // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastStartTimestamp: null == lastStartTimestamp
          ? _value.lastStartTimestamp
          : lastStartTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      isRunning: null == isRunning
          ? _value.isRunning
          : isRunning // ignore: cast_nullable_to_non_nullable
              as bool,
      compilationTimestamp: freezed == compilationTimestamp
          ? _value.compilationTimestamp
          : compilationTimestamp // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$_TaskCopyWith(_$_Task value, $Res Function(_$_Task) then) =
      __$$_TaskCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String groupId,
      String projectId,
      String id,
      String? content,
      String title,
      int durationSpentInSec,
      bool isCompleted,
      int lastStartTimestamp,
      bool isRunning,
      int? compilationTimestamp});
}

/// @nodoc
class __$$_TaskCopyWithImpl<$Res> extends _$TaskCopyWithImpl<$Res, _$_Task>
    implements _$$_TaskCopyWith<$Res> {
  __$$_TaskCopyWithImpl(_$_Task _value, $Res Function(_$_Task) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? projectId = null,
    Object? id = null,
    Object? content = freezed,
    Object? title = null,
    Object? durationSpentInSec = null,
    Object? isCompleted = null,
    Object? lastStartTimestamp = null,
    Object? isRunning = null,
    Object? compilationTimestamp = freezed,
  }) {
    return _then(_$_Task(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      durationSpentInSec: null == durationSpentInSec
          ? _value.durationSpentInSec
          : durationSpentInSec // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastStartTimestamp: null == lastStartTimestamp
          ? _value.lastStartTimestamp
          : lastStartTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      isRunning: null == isRunning
          ? _value.isRunning
          : isRunning // ignore: cast_nullable_to_non_nullable
              as bool,
      compilationTimestamp: freezed == compilationTimestamp
          ? _value.compilationTimestamp
          : compilationTimestamp // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Task extends _Task {
  const _$_Task(
      {required this.groupId,
      required this.projectId,
      required this.id,
      this.content,
      required this.title,
      required this.durationSpentInSec,
      required this.isCompleted,
      required this.lastStartTimestamp,
      required this.isRunning,
      this.compilationTimestamp})
      : super._();

  factory _$_Task.fromJson(Map<String, dynamic> json) => _$$_TaskFromJson(json);

  @override
  final String groupId;
  @override
  final String projectId;
  @override
  final String id;
  @override
  final String? content;
  @override
  final String title;
  @override
  final int durationSpentInSec;
  @override
  final bool isCompleted;
  @override
  final int lastStartTimestamp;
  @override
  final bool isRunning;
  @override
  final int? compilationTimestamp;

  @override
  String toString() {
    return 'Task(groupId: $groupId, projectId: $projectId, id: $id, content: $content, title: $title, durationSpentInSec: $durationSpentInSec, isCompleted: $isCompleted, lastStartTimestamp: $lastStartTimestamp, isRunning: $isRunning, compilationTimestamp: $compilationTimestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Task &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.durationSpentInSec, durationSpentInSec) ||
                other.durationSpentInSec == durationSpentInSec) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.lastStartTimestamp, lastStartTimestamp) ||
                other.lastStartTimestamp == lastStartTimestamp) &&
            (identical(other.isRunning, isRunning) ||
                other.isRunning == isRunning) &&
            (identical(other.compilationTimestamp, compilationTimestamp) ||
                other.compilationTimestamp == compilationTimestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      groupId,
      projectId,
      id,
      content,
      title,
      durationSpentInSec,
      isCompleted,
      lastStartTimestamp,
      isRunning,
      compilationTimestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskCopyWith<_$_Task> get copyWith =>
      __$$_TaskCopyWithImpl<_$_Task>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskToJson(
      this,
    );
  }
}

abstract class _Task extends Task {
  const factory _Task(
      {required final String groupId,
      required final String projectId,
      required final String id,
      final String? content,
      required final String title,
      required final int durationSpentInSec,
      required final bool isCompleted,
      required final int lastStartTimestamp,
      required final bool isRunning,
      final int? compilationTimestamp}) = _$_Task;
  const _Task._() : super._();

  factory _Task.fromJson(Map<String, dynamic> json) = _$_Task.fromJson;

  @override
  String get groupId;
  @override
  String get projectId;
  @override
  String get id;
  @override
  String? get content;
  @override
  String get title;
  @override
  int get durationSpentInSec;
  @override
  bool get isCompleted;
  @override
  int get lastStartTimestamp;
  @override
  bool get isRunning;
  @override
  int? get compilationTimestamp;
  @override
  @JsonKey(ignore: true)
  _$$_TaskCopyWith<_$_Task> get copyWith => throw _privateConstructorUsedError;
}

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
mixin _$Group {
  String get id => throw _privateConstructorUsedError;
  String get projectId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res, Group>;
  @useResult
  $Res call({String id, String projectId, String title, String color});
}

/// @nodoc
class _$GroupCopyWithImpl<$Res, $Val extends Group>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? title = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$_GroupCopyWith(_$_Group value, $Res Function(_$_Group) then) =
      __$$_GroupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String projectId, String title, String color});
}

/// @nodoc
class __$$_GroupCopyWithImpl<$Res> extends _$GroupCopyWithImpl<$Res, _$_Group>
    implements _$$_GroupCopyWith<$Res> {
  __$$_GroupCopyWithImpl(_$_Group _value, $Res Function(_$_Group) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? title = null,
    Object? color = null,
  }) {
    return _then(_$_Group(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Group extends _Group {
  const _$_Group(
      {required this.id,
      required this.projectId,
      required this.title,
      required this.color})
      : super._();

  factory _$_Group.fromJson(Map<String, dynamic> json) =>
      _$$_GroupFromJson(json);

  @override
  final String id;
  @override
  final String projectId;
  @override
  final String title;
  @override
  final String color;

  @override
  String toString() {
    return 'Group(id: $id, projectId: $projectId, title: $title, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Group &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, projectId, title, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      __$$_GroupCopyWithImpl<_$_Group>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupToJson(
      this,
    );
  }
}

abstract class _Group extends Group {
  const factory _Group(
      {required final String id,
      required final String projectId,
      required final String title,
      required final String color}) = _$_Group;
  const _Group._() : super._();

  factory _Group.fromJson(Map<String, dynamic> json) = _$_Group.fromJson;

  @override
  String get id;
  @override
  String get projectId;
  @override
  String get title;
  @override
  String get color;
  @override
  @JsonKey(ignore: true)
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      throw _privateConstructorUsedError;
}

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res, Project>;
  @useResult
  $Res call({String id, String title, String color});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res, $Val extends Project>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$_ProjectCopyWith(
          _$_Project value, $Res Function(_$_Project) then) =
      __$$_ProjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String color});
}

/// @nodoc
class __$$_ProjectCopyWithImpl<$Res>
    extends _$ProjectCopyWithImpl<$Res, _$_Project>
    implements _$$_ProjectCopyWith<$Res> {
  __$$_ProjectCopyWithImpl(_$_Project _value, $Res Function(_$_Project) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? color = null,
  }) {
    return _then(_$_Project(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_Project extends _Project {
  const _$_Project({required this.id, required this.title, required this.color})
      : super._();

  factory _$_Project.fromJson(Map<String, dynamic> json) =>
      _$$_ProjectFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String color;

  @override
  String toString() {
    return 'Project(id: $id, title: $title, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Project &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectCopyWith<_$_Project> get copyWith =>
      __$$_ProjectCopyWithImpl<_$_Project>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProjectToJson(
      this,
    );
  }
}

abstract class _Project extends Project {
  const factory _Project(
      {required final String id,
      required final String title,
      required final String color}) = _$_Project;
  const _Project._() : super._();

  factory _Project.fromJson(Map<String, dynamic> json) = _$_Project.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get color;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectCopyWith<_$_Project> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GroupedTasks {
  Group get group => throw _privateConstructorUsedError;
  List<Task> get tasks => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroupedTasksCopyWith<GroupedTasks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupedTasksCopyWith<$Res> {
  factory $GroupedTasksCopyWith(
          GroupedTasks value, $Res Function(GroupedTasks) then) =
      _$GroupedTasksCopyWithImpl<$Res, GroupedTasks>;
  @useResult
  $Res call({Group group, List<Task> tasks});

  $GroupCopyWith<$Res> get group;
}

/// @nodoc
class _$GroupedTasksCopyWithImpl<$Res, $Val extends GroupedTasks>
    implements $GroupedTasksCopyWith<$Res> {
  _$GroupedTasksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? tasks = null,
  }) {
    return _then(_value.copyWith(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupCopyWith<$Res> get group {
    return $GroupCopyWith<$Res>(_value.group, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GroupedTasksCopyWith<$Res>
    implements $GroupedTasksCopyWith<$Res> {
  factory _$$_GroupedTasksCopyWith(
          _$_GroupedTasks value, $Res Function(_$_GroupedTasks) then) =
      __$$_GroupedTasksCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Group group, List<Task> tasks});

  @override
  $GroupCopyWith<$Res> get group;
}

/// @nodoc
class __$$_GroupedTasksCopyWithImpl<$Res>
    extends _$GroupedTasksCopyWithImpl<$Res, _$_GroupedTasks>
    implements _$$_GroupedTasksCopyWith<$Res> {
  __$$_GroupedTasksCopyWithImpl(
      _$_GroupedTasks _value, $Res Function(_$_GroupedTasks) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? tasks = null,
  }) {
    return _then(_$_GroupedTasks(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group,
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

/// @nodoc

class _$_GroupedTasks extends _GroupedTasks {
  const _$_GroupedTasks({required this.group, required final List<Task> tasks})
      : _tasks = tasks,
        super._();

  @override
  final Group group;
  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  String toString() {
    return 'GroupedTasks(group: $group, tasks: $tasks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupedTasks &&
            (identical(other.group, group) || other.group == group) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, group, const DeepCollectionEquality().hash(_tasks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupedTasksCopyWith<_$_GroupedTasks> get copyWith =>
      __$$_GroupedTasksCopyWithImpl<_$_GroupedTasks>(this, _$identity);
}

abstract class _GroupedTasks extends GroupedTasks {
  const factory _GroupedTasks(
      {required final Group group,
      required final List<Task> tasks}) = _$_GroupedTasks;
  const _GroupedTasks._() : super._();

  @override
  Group get group;
  @override
  List<Task> get tasks;
  @override
  @JsonKey(ignore: true)
  _$$_GroupedTasksCopyWith<_$_GroupedTasks> get copyWith =>
      throw _privateConstructorUsedError;
}

ProjectGroupsOrderStructure _$ProjectGroupsOrderStructureFromJson(
    Map<String, dynamic> json) {
  return _ProjectGroupsOrderStructure.fromJson(json);
}

/// @nodoc
mixin _$ProjectGroupsOrderStructure {
  String get id => throw _privateConstructorUsedError;
  List<String> get groupsOrder => throw _privateConstructorUsedError;
  List<TaskGroupOrder> get groupedTasksOrder =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectGroupsOrderStructureCopyWith<ProjectGroupsOrderStructure>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectGroupsOrderStructureCopyWith<$Res> {
  factory $ProjectGroupsOrderStructureCopyWith(
          ProjectGroupsOrderStructure value,
          $Res Function(ProjectGroupsOrderStructure) then) =
      _$ProjectGroupsOrderStructureCopyWithImpl<$Res,
          ProjectGroupsOrderStructure>;
  @useResult
  $Res call(
      {String id,
      List<String> groupsOrder,
      List<TaskGroupOrder> groupedTasksOrder});
}

/// @nodoc
class _$ProjectGroupsOrderStructureCopyWithImpl<$Res,
        $Val extends ProjectGroupsOrderStructure>
    implements $ProjectGroupsOrderStructureCopyWith<$Res> {
  _$ProjectGroupsOrderStructureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupsOrder = null,
    Object? groupedTasksOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupsOrder: null == groupsOrder
          ? _value.groupsOrder
          : groupsOrder // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groupedTasksOrder: null == groupedTasksOrder
          ? _value.groupedTasksOrder
          : groupedTasksOrder // ignore: cast_nullable_to_non_nullable
              as List<TaskGroupOrder>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProjectGroupsOrderStructureCopyWith<$Res>
    implements $ProjectGroupsOrderStructureCopyWith<$Res> {
  factory _$$_ProjectGroupsOrderStructureCopyWith(
          _$_ProjectGroupsOrderStructure value,
          $Res Function(_$_ProjectGroupsOrderStructure) then) =
      __$$_ProjectGroupsOrderStructureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<String> groupsOrder,
      List<TaskGroupOrder> groupedTasksOrder});
}

/// @nodoc
class __$$_ProjectGroupsOrderStructureCopyWithImpl<$Res>
    extends _$ProjectGroupsOrderStructureCopyWithImpl<$Res,
        _$_ProjectGroupsOrderStructure>
    implements _$$_ProjectGroupsOrderStructureCopyWith<$Res> {
  __$$_ProjectGroupsOrderStructureCopyWithImpl(
      _$_ProjectGroupsOrderStructure _value,
      $Res Function(_$_ProjectGroupsOrderStructure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupsOrder = null,
    Object? groupedTasksOrder = null,
  }) {
    return _then(_$_ProjectGroupsOrderStructure(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupsOrder: null == groupsOrder
          ? _value._groupsOrder
          : groupsOrder // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groupedTasksOrder: null == groupedTasksOrder
          ? _value._groupedTasksOrder
          : groupedTasksOrder // ignore: cast_nullable_to_non_nullable
              as List<TaskGroupOrder>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$_ProjectGroupsOrderStructure extends _ProjectGroupsOrderStructure {
  const _$_ProjectGroupsOrderStructure(
      {required this.id,
      required final List<String> groupsOrder,
      required final List<TaskGroupOrder> groupedTasksOrder})
      : _groupsOrder = groupsOrder,
        _groupedTasksOrder = groupedTasksOrder,
        super._();

  factory _$_ProjectGroupsOrderStructure.fromJson(Map<String, dynamic> json) =>
      _$$_ProjectGroupsOrderStructureFromJson(json);

  @override
  final String id;
  final List<String> _groupsOrder;
  @override
  List<String> get groupsOrder {
    if (_groupsOrder is EqualUnmodifiableListView) return _groupsOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groupsOrder);
  }

  final List<TaskGroupOrder> _groupedTasksOrder;
  @override
  List<TaskGroupOrder> get groupedTasksOrder {
    if (_groupedTasksOrder is EqualUnmodifiableListView)
      return _groupedTasksOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groupedTasksOrder);
  }

  @override
  String toString() {
    return 'ProjectGroupsOrderStructure(id: $id, groupsOrder: $groupsOrder, groupedTasksOrder: $groupedTasksOrder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectGroupsOrderStructure &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._groupsOrder, _groupsOrder) &&
            const DeepCollectionEquality()
                .equals(other._groupedTasksOrder, _groupedTasksOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_groupsOrder),
      const DeepCollectionEquality().hash(_groupedTasksOrder));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectGroupsOrderStructureCopyWith<_$_ProjectGroupsOrderStructure>
      get copyWith => __$$_ProjectGroupsOrderStructureCopyWithImpl<
          _$_ProjectGroupsOrderStructure>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProjectGroupsOrderStructureToJson(
      this,
    );
  }
}

abstract class _ProjectGroupsOrderStructure
    extends ProjectGroupsOrderStructure {
  const factory _ProjectGroupsOrderStructure(
          {required final String id,
          required final List<String> groupsOrder,
          required final List<TaskGroupOrder> groupedTasksOrder}) =
      _$_ProjectGroupsOrderStructure;
  const _ProjectGroupsOrderStructure._() : super._();

  factory _ProjectGroupsOrderStructure.fromJson(Map<String, dynamic> json) =
      _$_ProjectGroupsOrderStructure.fromJson;

  @override
  String get id;
  @override
  List<String> get groupsOrder;
  @override
  List<TaskGroupOrder> get groupedTasksOrder;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectGroupsOrderStructureCopyWith<_$_ProjectGroupsOrderStructure>
      get copyWith => throw _privateConstructorUsedError;
}

TaskGroupOrder _$TaskGroupOrderFromJson(Map<String, dynamic> json) {
  return _TaskGroupOrder.fromJson(json);
}

/// @nodoc
mixin _$TaskGroupOrder {
  String get id => throw _privateConstructorUsedError;
  List<String> get tasksIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskGroupOrderCopyWith<TaskGroupOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskGroupOrderCopyWith<$Res> {
  factory $TaskGroupOrderCopyWith(
          TaskGroupOrder value, $Res Function(TaskGroupOrder) then) =
      _$TaskGroupOrderCopyWithImpl<$Res, TaskGroupOrder>;
  @useResult
  $Res call({String id, List<String> tasksIds});
}

/// @nodoc
class _$TaskGroupOrderCopyWithImpl<$Res, $Val extends TaskGroupOrder>
    implements $TaskGroupOrderCopyWith<$Res> {
  _$TaskGroupOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tasksIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tasksIds: null == tasksIds
          ? _value.tasksIds
          : tasksIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskGroupOrderCopyWith<$Res>
    implements $TaskGroupOrderCopyWith<$Res> {
  factory _$$_TaskGroupOrderCopyWith(
          _$_TaskGroupOrder value, $Res Function(_$_TaskGroupOrder) then) =
      __$$_TaskGroupOrderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, List<String> tasksIds});
}

/// @nodoc
class __$$_TaskGroupOrderCopyWithImpl<$Res>
    extends _$TaskGroupOrderCopyWithImpl<$Res, _$_TaskGroupOrder>
    implements _$$_TaskGroupOrderCopyWith<$Res> {
  __$$_TaskGroupOrderCopyWithImpl(
      _$_TaskGroupOrder _value, $Res Function(_$_TaskGroupOrder) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tasksIds = null,
  }) {
    return _then(_$_TaskGroupOrder(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tasksIds: null == tasksIds
          ? _value._tasksIds
          : tasksIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_TaskGroupOrder implements _TaskGroupOrder {
  const _$_TaskGroupOrder(
      {required this.id, required final List<String> tasksIds})
      : _tasksIds = tasksIds;

  factory _$_TaskGroupOrder.fromJson(Map<String, dynamic> json) =>
      _$$_TaskGroupOrderFromJson(json);

  @override
  final String id;
  final List<String> _tasksIds;
  @override
  List<String> get tasksIds {
    if (_tasksIds is EqualUnmodifiableListView) return _tasksIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasksIds);
  }

  @override
  String toString() {
    return 'TaskGroupOrder(id: $id, tasksIds: $tasksIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskGroupOrder &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._tasksIds, _tasksIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_tasksIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskGroupOrderCopyWith<_$_TaskGroupOrder> get copyWith =>
      __$$_TaskGroupOrderCopyWithImpl<_$_TaskGroupOrder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskGroupOrderToJson(
      this,
    );
  }
}

abstract class _TaskGroupOrder implements TaskGroupOrder {
  const factory _TaskGroupOrder(
      {required final String id,
      required final List<String> tasksIds}) = _$_TaskGroupOrder;

  factory _TaskGroupOrder.fromJson(Map<String, dynamic> json) =
      _$_TaskGroupOrder.fromJson;

  @override
  String get id;
  @override
  List<String> get tasksIds;
  @override
  @JsonKey(ignore: true)
  _$$_TaskGroupOrderCopyWith<_$_TaskGroupOrder> get copyWith =>
      throw _privateConstructorUsedError;
}
