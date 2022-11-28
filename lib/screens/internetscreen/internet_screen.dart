import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:testlocation/ultils/local_storage.dart';
import 'package:testlocation/widgets/app_drawer.dart';
import 'package:testlocation/widgets/pick_button.dart';
import 'package:workmanager/workmanager.dart';

const _url = "https://firebasestorage.googleapis.com/v0/b/comic-reader-7a6be.appspot.com/o/Books%2F4Nsz6TdR0GWiHHOXIpaI%2FChapters%2FChap%201?alt=media&token=a2cf323e-0a98-48f7-a533-fbd43e02d001";
const _name = "testPDF.pdf";

class InternetScreen extends StatelessWidget {
  const InternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PickButton(
                    buttonTitle: "Check connect wifi",
                    buttonIcon: Icons.signal_wifi_statusbar_4_bar_sharp,
                    onPressedButton: () async {
                      // var hasInternet = await InternetConnectionChecker().hasConnection;
                      // if (hasInternet) {
                      //   await openFile(url: _url, fileName: _name);
                      // }
                      // else
                      // {
                        await Workmanager().registerOneOffTask(
                          "1",
                          "no-internet",
                          constraints: Constraints(networkType: NetworkType.connected),
                          inputData: <String, dynamic> {
                            'url': _url,
                            'name': _name,
                          },
                        );
                      // }
                    }),
                ElevatedButton(onPressed: () {
                  Workmanager().cancelAll();
                }, child: Text("cancel all"))
              ],
            ),
          ),
        ));
  }

  Future openFile({required String url, required String fileName}) async {
    final file = await downloadFile(url: url, fileName: fileName);
    if (file == null) return;
    OpenFilex.open(file.path);
  }

  Future<File?> downloadFile({required String url, required String fileName}) async {
    try{
      final localStorage = LocalStorage();
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
