import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension BuildContextX on BuildContext {
  ProviderContainer get container => ProviderScope.containerOf(this, listen: false);
}
