import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:testlocation/helpers/storageHelper.dart';
import 'package:workmanager/workmanager.dart';

void callBackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    DartPluginRegistrant.ensureInitialized();
    switch (taskName) {
      case 'no-internet':
        try {
          final url = inputData!['url']!;
          final name = inputData!['name']!;
          var file = await _downloadFile(url: url, fileName: name);
          if (file == null) {
            return Future.error(Exception("Fail to download"));
          }
          break;
        }
        catch (exeption) {
          print(exeption.toString());
          return Future.error(exeption);
        }
      default:
    }
    return Future.value(true);
  });
}


Future<File?> _downloadFile(
    {required String url, required String fileName}) async {
  try {
    final localStorage = Storage();
    final file = await localStorage.getLocalFileOnBackgroudService(fileName);
    final response = await Dio().get(url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0));
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  } catch (exeption) {
    print("downloadFile error: $exeption");
    return null;
  }
}
