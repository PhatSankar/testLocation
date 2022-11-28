import 'package:flutter/material.dart';
import 'package:testlocation/screens/storagescreen/commonwidgets/common_storage_widget.dart';
import 'package:testlocation/widgets/app_drawer.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                children: const [
                  Expanded(
                      flex: 1,
                      child: CommonStorageWidget(isSecure: true)
                  ),
                  Expanded(
                      flex: 1,
                      child: CommonStorageWidget(isSecure: false)
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
