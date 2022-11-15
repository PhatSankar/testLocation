

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:testlocation/bloc/download_bloc/download_bloc.dart';
import 'package:testlocation/widgets/Drawer.dart';
import 'package:testlocation/widgets/PickButton.dart';

class DownloadOpenScreen extends StatelessWidget {
  final _nameFileController = TextEditingController();
  final _urlController = TextEditingController();
  DownloadOpenScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DownloadBloc _downloadBloc =BlocProvider.of(context);
    return SafeArea(child: Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: BlocBuilder<DownloadBloc, DownloadState> (
          bloc: _downloadBloc,
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: _urlController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Download url",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black, width: 1)
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: _nameFileController,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Name file",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black, width: 1)
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                PickButton(buttonTitle: "Download and open from URL",
                    buttonIcon: Icons.link,
                    onPressedButton: ()
                    {
                      _downloadBloc.add(
                          DownloadEvent(_urlController.text,
                         _nameFileController.text));
                    }),
                Visibility(
                child: CircularProgressIndicator(),
                  visible: state is Downloading ? true : false,
                ),
                Visibility(
                  child: Text("Error", style: TextStyle(color: Colors.red),),
                  visible: state is DownloadFailed ? true : false,
                ),
              ],
            );
          },
        )
      ),
    ));
  }
}
