import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/projects/providers.dart';
import 'package:taskify/shared/firebase_options.dart';

Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // remove hash from web url
  // setPathUrlStrategy();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final sharedPref = await SharedPreferences.getInstance();
  final container = ProviderContainer(overrides: [
    sharePrefProvider.overrideWithValue(sharedPref),
  ]);

  if (kIsWeb) {
    FirebaseFirestore.instance.enablePersistence(const PersistenceSettings(synchronizeTabs: true));
  } else {
    FirebaseFirestore.instance.settings = FirebaseFirestore.instance.settings.copyWith(persistenceEnabled: true);
  }

  if (kReleaseMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  return container;
}
