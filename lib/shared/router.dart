import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/board/board.dart';

import 'package:taskify/projects/projects_page.dart';
import 'package:taskify/projects/providers.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProjectsPage(),
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            final id = state.params['projectId'] as String;
            return ProviderScope(
              parent: ProviderScope.containerOf(context),
              overrides: [
                projectIdProvider.overrideWithValue(id),
              ],
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: 'project/:projectId',
              builder: (context, state) {
                return const Board();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
