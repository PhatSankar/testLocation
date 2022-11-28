import 'package:flutter/material.dart';
import 'package:testlocation/ultils/user_secure_storage.dart';
import 'package:testlocation/ultils/user_share_ref_storage.dart';

class CommonStorageWidget extends StatefulWidget {
  final bool isSecure;

  const CommonStorageWidget({required this.isSecure, Key? key})
      : super(key: key);

  @override
  State<CommonStorageWidget> createState() => _CommonStorageWidgetState();
}

class _CommonStorageWidgetState extends State<CommonStorageWidget> {
  final TextEditingController secureTextController = TextEditingController();
  String? storageValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future init() async {
    storageValue = widget.isSecure
        ? await UserSecuredStorage.getName()
        : await UserShareRefStorage.getName();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    secureTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: secureTextController,
              style: const TextStyle(fontSize: 18, color: Colors.black),
              decoration: const InputDecoration(
                labelText: "Data to save",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.black, width: 1)),
              ),
            )),
        ElevatedButton(
            onPressed: () async {
              widget.isSecure
                  ? await UserSecuredStorage.setName(secureTextController.text)
                  : await UserShareRefStorage.setName(
                      secureTextController.text);
              var getNewValue = widget.isSecure
                  ? await UserSecuredStorage.getName()
                  : await UserShareRefStorage.getName();

              setState(() {
                storageValue = getNewValue;
              });
            },
            child: Text(widget.isSecure
                ? "Save to secured storage"
                : "Save to shareRef storage")),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: storageValue != null
              ? Text(
                  storageValue!,
                  style: const TextStyle(color: Colors.black, fontSize: 32),
                )
              : null,
        )
      ],
    );
  }
}
