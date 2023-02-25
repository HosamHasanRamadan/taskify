import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stateful_props/stateful_props.dart';
import 'package:taskify/board/board_controller.dart';
import 'package:taskify/projects/providers.dart';
import 'package:taskify/shared/extensions/context_x.dart';
import 'package:taskify/shared/models.dart';
import 'package:taskify/shared/repository/projects_repo.dart';

class GroupForm extends StatefulWidget {
  final Group? initialGroup;
  const GroupForm({
    super.key,
    this.initialGroup,
  });

  @override
  State<GroupForm> createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> with StatefulPropsMixin {
  late final titleController = TextEditingControllerProp(this).controller;
  Color dialogPickerColor = Colors.cyan;

  @override
  void initState() {
    super.initState();
    if (widget.initialGroup != null) {
      titleController.text = widget.initialGroup!.title;
      dialogPickerColor = HexColor(widget.initialGroup!.color);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.initialGroup == null ? 'Create new group' : 'Update group';
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                suffixIcon: InkWell(
                  onTap: () {
                    colorPicker();
                  },
                  child: Icon(Icons.color_lens),
                ),
                prefixIcon: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dialogPickerColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (widget.initialGroup == null) {
                  save();
                  return;
                }
                update();
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }

  void save() {
    final title = titleController.text;
    final color = dialogPickerColor;
    final pop = context.pop;
    if (title.isEmpty) return;
    context.container
        .read(projectRepoProvider)
        .addGroup(
          Group(
            id: '-1',
            projectId: context.container.read(projectIdProvider),
            title: title,
            color: ColorToHex(dialogPickerColor).hex,
          ),
        )
        .then((value) {
      pop();
    });
  }

  void update() {
    final pop = context.pop;

    context.container
        .read(projectRepoProvider)
        .updateGroup(
          Group(
            projectId: widget.initialGroup!.projectId,
            id: widget.initialGroup!.id,
            title: titleController.text,
            color: ColorToHex(dialogPickerColor).hex,
          ),
        )
        .then((value) => pop());
  }

  void colorPicker() {
    ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) => setState(() => dialogPickerColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: false,
      showColorName: true,
      showColorCode: false,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(longPressMenu: true),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: false,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
    ).showPickerDialog(context);
  }
}
