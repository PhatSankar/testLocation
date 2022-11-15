import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:open_filex/open_filex.dart';
import 'package:testlocation/helpers/storageHelper.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  DownloadBloc() : super(DownloadInitial()) {
    on<DownloadEvent>((event, emit) async {
      try {
        if (state is! Downloading)
          {
            emit(Downloading());
            final file = await downloadFile(url: event.url, fileName: event.fileName);
            if (file == null) {
              emit(DownloadFailed());
            }

            emit(DownloadComplete());
            OpenFilex.open(file!.path);
          }
      }
      catch(exption)
      {
        print(exption.toString());
        emit(DownloadFailed());
      }
    });
  }

  Future<File?> downloadFile({required String url, required String fileName}) async {
    try{
      final localStorage = Storage();
      final file = await localStorage.getLocalFile(fileName);
      final response = await Dio().get(
          url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0
          )
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    }
    catch(exeption){
      print("downloadFile error: $exeption");
      return null;
    }
  }
}
