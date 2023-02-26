import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:taskify/projects/providers.dart';

class CompletedTaskDialog extends StatelessWidget {
  const CompletedTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FractionallySizedBox(
        heightFactor: .5,
        child: Consumer(
          builder: (context, ref, child) {
            final completedTasks = ref.watch(completedTasksProvider);
            if (completedTasks.isEmpty) {
              return Center(
                child: Text(
                  'No completed tasks yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 4,
              ),
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks.elementAt(index);
                final duration = printDuration(Duration(seconds: task.durationSpentInSec));
                final compellationDate = DateTime.fromMillisecondsSinceEpoch(task.compilationTimestamp! * 1000);
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: duration),
                        const TextSpan(
                          text: '\n',
                        ),
                        TextSpan(
                          text: DateFormat.yMMMEd().format(compellationDate),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
