import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalStorage {
  Future<String?> get _localDownloadPath async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<File> getLocalFile(String nameFile) async {
    var status = await Permission.storage.request();
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    final path = await _localDownloadPath;
    return File('$path/$nameFile');
  }

  Future<File> getLocalFileOnBackgroudService(String nameFile) async {
    var status = await Permission.storage.status;
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    final path = await _localDownloadPath;
    return File('$path/$nameFile');
  }

  Future<String> readDataFile(String nameFile) async {
    try {
      final localFile = await getLocalFile(nameFile);
      return localFile.readAsStringSync();
    } catch (exeption) {
      return exeption.toString();
    }
  }

  Future<File?> writeDataFile(String nameFile, String data) async {
    try {
      print("Start writing");
      final localFile = await getLocalFile(nameFile);
      print(localFile);
      return localFile.writeAsString(data);
    } catch (exeption) {
      return null;
    }
  }
}
