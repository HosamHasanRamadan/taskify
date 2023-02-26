import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stateful_props/stateful_props.dart';
import 'package:taskify/shared/app_theme.dart';
import 'package:taskify/shared/extensions/context_x.dart';
import 'package:taskify/shared/models.dart';
import 'package:taskify/projects/providers.dart';
import 'package:taskify/shared/repository/projects_repo.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final asyncProjects = ref.watch(projectsProvider);

        final child = asyncProjects.map(
          error: (error) {
            return const Text('Error');
          },
          loading: (loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          data: (data) {
            final projects = data.requireValue;
            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects.elementAt(index);
                return InkWell(
                  onTap: () {
                    context.go('/project/${project.id}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        SizedBox.square(
                          dimension: 10,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HexColor(project.color),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          project.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );

        return Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  alignment: Alignment.center,
                  color: Theme.of(context).colorScheme.surfaceTint,
                  child: Text(
                    'Taskify',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                ExpansionTile(
                  title: const Text('Themes'),
                  leading: const Icon(Icons.style),
                  children: [
                    Consumer(builder: (context, ref, child) {
                      final selectedTheme = ref.watch(themeProvider);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ...AppThemes.themes.map(
                            (theme) {
                              return GestureDetector(
                                onTap: () {
                                  ref.read(themeProvider.notifier).state = theme;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox.square(
                                    dimension: 40,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: theme.lightTheme.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      );
                    }),
                    Consumer(
                      builder: (context, ref, child) {
                        final currentMode = ref.watch(themeModeProvider);
                        return Row(
                          children: [
                            ...ThemeMode.values.map(
                              (mode) => Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio<ThemeMode>(
                                    onChanged: (value) {
                                      if (value != null) {
                                        ref.read(themeModeProvider.notifier).state = value;
                                      }
                                    },
                                    groupValue: currentMode,
                                    value: mode,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(mode.name),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Taskify'),
          ),
          body: child,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const ProjectFromDialog(),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class ProjectFromDialog extends StatefulWidget {
  final Project? initialProject;
  const ProjectFromDialog({
    super.key,
    this.initialProject,
  });

  @override
  State<ProjectFromDialog> createState() => _ProjectFromDialogState();
}

class _ProjectFromDialogState extends State<ProjectFromDialog> with StatefulPropsMixin {
  late final titleController = TextEditingControllerProp(this).controller;
  late final symbolController = TextEditingControllerProp(this).controller;
  late final colorController = TextEditingControllerProp(this).controller;
  Color dialogPickerColor = Colors.cyan;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create new project',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: dialogPickerColor,
                    ),
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    colorPicker();
                  },
                  child: const Icon(Icons.palette),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final color = dialogPickerColor;
                if (title.isEmpty) return;
                context.container
                    .read(projectRepoProvider)
                    .addProject(
                      Project(
                        id: '-1',
                        title: title,
                        color: ColorToHex(color).hex,
                      ),
                    )
                    .then((value) {
                  context.pop();
                });
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
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
