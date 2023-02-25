import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/shared/constants.dart';
import 'package:taskify/projects/providers.dart';

abstract class AppThemes {
  AppThemes._();
  static final blue = AppTheme(
    lightTheme: FlexThemeData.light(scheme: FlexScheme.aquaBlue),
    darkTheme: FlexThemeData.dark(scheme: FlexScheme.aquaBlue),
    name: 'blue',
  );
  static final red = AppTheme(
    lightTheme: FlexThemeData.light(scheme: FlexScheme.redWine),
    darkTheme: FlexThemeData.dark(scheme: FlexScheme.redWine),
    name: 'red',
  );
  static final green = AppTheme(
    lightTheme: FlexThemeData.light(scheme: FlexScheme.greyLaw),
    darkTheme: FlexThemeData.dark(scheme: FlexScheme.greyLaw),
    name: 'green',
  );

  static final fallback = red;

  static final themes = {red, green, blue};
}

class AppTheme {
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final String name;

  AppTheme({
    required this.lightTheme,
    required this.darkTheme,
    required this.name,
  });
}

final themeProvider = StateProvider<AppTheme>((ref) {
  ref.listenSelf((previous, next) {
    ref.read(sharePrefProvider).setString(Constants.themeCacheKey, next.name);
  });
  final cachedTheme = ref.read(sharePrefProvider).get(Constants.themeCacheKey);

  if (cachedTheme == null) return AppThemes.fallback;

  final theme = AppThemes.themes.firstWhere(
    (element) => element.name == cachedTheme,
    orElse: () => AppThemes.fallback,
  );
  return theme;
});

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  ref.listenSelf((previous, next) {
    ref.read(sharePrefProvider).setString(Constants.themeModeCacheKey, next.name);
  });

  final cachedMode = ref.read(sharePrefProvider).get(Constants.themeModeCacheKey);

  if (cachedMode == null) return ThemeMode.system;
  final mode = ThemeMode.values.firstWhere(
    (element) => element.name == cachedMode,
    orElse: () => ThemeMode.system,
  );
  return mode;
});
