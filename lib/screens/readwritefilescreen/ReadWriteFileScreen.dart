

import 'package:flutter/material.dart';
import 'package:testlocation/widgets/Drawer.dart';
import 'package:testlocation/helpers/storageHelper.dart';

class ReadWriteFileScreen extends StatefulWidget {
  const ReadWriteFileScreen({Key? key}) : super(key: key);

  @override
  State<ReadWriteFileScreen> createState() => _ReadWriteFileScreenState();
}

class _ReadWriteFileScreenState extends State<ReadWriteFileScreen> {
  late Storage localStorage;
  final _nameFileController = TextEditingController();
  final _dataFileController = TextEditingController();
  bool _isWriteFileSuccess = true;
  String _dataFromFile = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localStorage = Storage();
    _nameFileController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameFileController.dispose();
    _dataFileController.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: _dataFileController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Data file",
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
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Name file",
                    errorText: _nameFileController.text.isEmpty ? "Please provide valid username" : null,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.black, width: 1)
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Text(_isWriteFileSuccess == true ? "" : "Failed to write file"),
                ),
                ElevatedButton(onPressed: _nameFileController.text.isEmpty ? null : () async {
                  var file = await localStorage.writeDataFile(_nameFileController.text, _dataFileController.text);
                  setState(() {
                    _isWriteFileSuccess = (file != null);
                  });
                }, child:
                Text("Write to file")
                ),
                ElevatedButton(onPressed: _nameFileController.text.isEmpty ? null : () async {
                  String getDataFromFile = await localStorage.readDataFile(_nameFileController.text);
                  setState(() {
                    _dataFromFile = getDataFromFile;
                  });
                }, child:
                Text("Read from a file")
                ),
                SizedBox(
                  height: 50,
                ),
                Text(_dataFromFile),
              ],
            ),
          )
        )
    );
  }
}
