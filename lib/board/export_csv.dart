import 'package:taskify/shared/models.dart';
import "package:universal_html/html.dart" as html;
import 'package:universal_io/io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

Future<bool> shareAsCsv({
  required String projectName,
  required List<GroupedTasks> groups,
}) async {
  final finalName = '$projectName.csv';
  var path = (await getTemporaryDirectory()).path;
  final csvFile = File('$path/$finalName');

  final result = _createCSV(projectName: projectName, groups: groups);
  csvFile.writeAsString(result);
  Share.shareXFiles([XFile(csvFile.path)]);
  return true;
}

Future<bool> exportProjectToCSV({
  required String projectName,
  required List<GroupedTasks> groups,
}) async {
  final permissionsResult = await [
    Permission.storage,
    Permission.manageExternalStorage,
  ].request();

  for (final perm in permissionsResult.entries) {
    if (perm.value.isGranted == false) return false;
  }

  final fileName = '$projectName.csv';

  final path = await FilePicker.platform.getDirectoryPath();
  if (path == null) return false;
  final csvFile = File('$path/$fileName');

  final result = _createCSV(projectName: projectName, groups: groups);
  csvFile.writeAsString(result);
  return true;
}

Future<void> shareWeb({
  required String projectName,
  required List<GroupedTasks> groups,
}) async {
  final result = _createCSV(projectName: projectName, groups: groups);
  // prepare
  final bytes = utf8.encode(result);
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = '$projectName.csv';
  html.document.body?.children.add(anchor);

// download
  anchor.click();

// cleanup
  html.document.body?.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}

String _createCSV({
  required String projectName,
  required List<GroupedTasks> groups,
}) {
  final rows = <List<dynamic>>[];
  final header = [
    'group',
    'title',
    'duration',
    'is_completed',
    'content',
  ];

  rows.add(header);

  for (final group in groups) {
    for (final task in group.tasks) {
      rows.add([
        group.group.title,
        task.title,
        task.durationSpentInSec,
        task.isCompleted,
        task.content,
      ]);
    }
  }
  return const ListToCsvConverter().convert(rows);
}
