part of 'board.dart';

class GroupFooter extends StatelessWidget {
  final Widget label;
  final Widget icon;
  final EdgeInsets padding;
  const GroupFooter({
    super.key,
    required this.label,
    required this.icon,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          label,
        ],
      ),
    );
  }
}

class GroupHeader extends StatelessWidget {
  final Widget label;

  final EdgeInsets padding;
  final Color? color;
  final VoidCallback? onEditButtonPressed;
  const GroupHeader({
    super.key,
    required this.label,
    this.color,
    this.padding = EdgeInsets.zero,
    this.onEditButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          SizedBox.square(
            dimension: 10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: label),
          IconButton(
            onPressed: () {
              onEditButtonPressed?.call();
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}

class TaskCard extends StatefulWidget {
  final Task task;
  final VoidCallback? onTab;

  const TaskCard({
    super.key,
    required this.task,
    this.onTab,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late Duration duration;
  late final StreamSubscription<int> timer;

  @override
  void initState() {
    super.initState();
    if (widget.task.isRunning) {
      final durationDiff = DateTime.now().unixTimestamp - widget.task.lastStartTimestamp;

      duration = Duration(
        seconds: widget.task.durationSpentInSec + durationDiff,
      );
    } else {
      duration = Duration(seconds: widget.task.durationSpentInSec);
    }
    timer = Stream<int>.periodic(const Duration(seconds: 1), (c) => c).listen(onTick);

    if (widget.task.isRunning == false) timer.pause();
  }

  void onTick(int tick) {
    duration = duration + const Duration(seconds: 1);
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant TaskCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.task.isRunning == oldWidget.task.isRunning) return;
    if (widget.task.isRunning) {
      final durationDiff = DateTime.now().unixTimestamp - widget.task.lastStartTimestamp;

      duration = Duration(
        seconds: widget.task.durationSpentInSec + durationDiff,
      );
    } else {
      duration = Duration(seconds: widget.task.durationSpentInSec);
    }
    if (widget.task.isRunning) {
      timer.resume();
    } else {
      timer.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTab,
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          shape: RoundedRectangleBorder(
            side: widget.task.isRunning
                ? BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  )
                : BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                PopupMenuButton(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.more_vert),
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () {
                          context.container.read(boardControllerProvider).deleteTask(widget.task);
                        },
                        child: Text(
                          'Delete',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      if (widget.task.isRunning)
                        PopupMenuItem(
                          onTap: () {
                            context.container.read(boardControllerProvider).stopTask(widget.task);
                          },
                          child: Text(
                            'Stop',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        )
                      else
                        PopupMenuItem(
                          onTap: () {
                            context.container.read(boardControllerProvider).startTask(widget.task);
                          },
                          child: Text(
                            'Resume',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      PopupMenuItem(
                        onTap: () {
                          final controller = context.container.read(boardControllerProvider);
                          controller.markCompleted(widget.task, true);

                          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 5),
                              content: Text(widget.task.title),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  controller.markCompleted(widget.task, false);
                                },
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Mark as completed',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      )
                    ];
                  },
                ),
              ],
            ),
            if (widget.task.content != null) ...[
              const SizedBox(height: 8),
              Text(
                widget.task.content!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (widget.task.durationSpentInSec > 0 || widget.task.isRunning) ...[
              const SizedBox(height: 8),
              Text(
                prettyDuration(duration, abbreviated: true),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ]
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

class GroupsOrderDialog extends StatefulWidget {
  final List<Group> initialGroupOrder;
  const GroupsOrderDialog({
    super.key,
    required this.initialGroupOrder,
  });

  @override
  State<GroupsOrderDialog> createState() => _GroupsOrderDialogState();
}

class _GroupsOrderDialogState extends State<GroupsOrderDialog> {
  late List<Group> groups;
  @override
  void initState() {
    super.initState();
    groups = widget.initialGroupOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: ReorderableListView(
          children: [
            ...groups.map(
              (g) => ListTile(
                key: ValueKey(g.id),
                title: Text(g.title),
                trailing: const Icon(Icons.reorder),
              ),
            )
          ],
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final newOrder = List<Group>.from(groups);
            final item = newOrder.removeAt(oldIndex);
            newOrder.insert(newIndex, item);
            setState(() {
              groups = newOrder;
            });

            final projectsId = newOrder[oldIndex].projectId;
            context.container.read(taskRepoProvider).updateGroupsOrder(
                  projectsId,
                  newOrder.map((e) => e.id).toList(),
                );
          },
        ),
      ),
    );
  }
}
