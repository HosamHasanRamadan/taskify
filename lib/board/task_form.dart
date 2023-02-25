import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stateful_props/stateful_props.dart';
import 'package:taskify/board/board_controller.dart';
import 'package:taskify/projects/providers.dart';
import 'package:taskify/shared/extensions/context_x.dart';
import 'package:taskify/shared/models.dart';

class TaskForm extends StatefulWidget {
  final Task? initialTask;
  final List<Group> groups;
  const TaskForm({
    this.initialTask,
    required this.groups,
    super.key,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> with StatefulPropsMixin {
  final formKey = GlobalKey<FormState>();

  late final taskTitleController = TextEditingControllerProp(this).controller;
  late final taskTitleFocusNode = FocusNodeProp(this).node;

  late final taskContentController = TextEditingControllerProp(this).controller;
  late final taskContentsFocusNode = FocusNodeProp(this).node;

  Group? selectedGroup;
  @override
  void initState() {
    super.initState();
    if (widget.initialTask != null) {
      taskTitleController.text = widget.initialTask!.title;
      taskContentController.text = widget.initialTask!.content ?? '';
      selectedGroup = widget.groups.firstWhereOrNull((element) => element.id == widget.initialTask!.groupId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: Theme.of(context).textTheme.titleLarge,
                decoration: const InputDecoration(hintText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'required';
                  return null;
                },
                controller: taskTitleController,
                focusNode: taskTitleFocusNode,
              ),
              const SizedBox(height: 8),
              Consumer(
                builder: (context, ref, child) {
                  final groups = widget.groups;

                  return DropdownButtonFormField(
                    value: selectedGroup?.id,
                    decoration: const InputDecoration(hintText: 'Group'),
                    validator: (value) {
                      if (value == null) return 'required';
                      return null;
                    },
                    onChanged: (value) {
                      selectedGroup = groups.firstWhere((element) => element.id == value);
                      setState(() {});
                    },
                    items: [
                      ...groups.map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.title),
                        ),
                      )
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                minLines: 6,
                maxLines: 8,
                decoration: const InputDecoration(hintText: 'Content'),
                controller: taskContentController,
                focusNode: taskContentsFocusNode,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: save,
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void save() {
    final navigator = GoRouter.of(context);
    final controller = context.container.read(boardControllerProvider);
    final projectId = context.container.read(projectIdProvider);

    if (formKey.currentState!.validate() && selectedGroup != null) {
      if (widget.initialTask != null) {
        final updatedTask = widget.initialTask!.copyWith(
          title: taskTitleController.text,
          content: taskContentController.text,
          groupId: selectedGroup!.id,
        );
        controller
            .updateTask(
          newTask: updatedTask,
          oldTask: widget.initialTask!,
        )
            .then(
          (value) {
            if (mounted) navigator.pop();
          },
        );
        return;
      }
      final task = Task(
        projectId: projectId,
        groupId: selectedGroup!.id,
        id: '',
        title: taskTitleController.text,
        content: taskContentController.text,
        durationSpentInSec: 0,
        isCompleted: false,
        isRunning: false,
        lastStartTimestamp: -1,
      );

      controller.addTask(task).then((value) {
        if (mounted) navigator.pop();
      });
    }
  }
}
