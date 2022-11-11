import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testlocation/screens/galeryscreen/common_widget/PickButton.dart';
import 'package:testlocation/widgets/Drawer.dart';
import 'package:permission_handler/permission_handler.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                imageFile == null
                    ? FlutterLogo(
                        size: 160,
                      )
                    : Image.file(imageFile!),
                SizedBox(
                  height: 16,
                ),
                PickButton(
                    buttonTitle: "Pick from gallery",
                    buttonIcon: Icons.image_outlined,
                    onPressedButton: () =>
                        onPressPickImage(ImageSource.gallery)),
                PickButton(
                    buttonTitle: "Pick from Camera",
                    buttonIcon: Icons.camera_alt_outlined,
                    onPressedButton: () =>
                        onPressPickImage(ImageSource.camera)),
                const Spacer(),
              ],
            ),
          )),
    ));
  }

  Future onPressPickImage(ImageSource source) async {
    var cameraPermission = await Permission.camera.status;
    if (cameraPermission.isGranted) {
      final imagePath = await ImagePicker().pickImage(source: source);
      if (imagePath == null) return;
      setState(() {
        this.imageFile = File(imagePath.path);
      });
    } else {
      cameraPermission = await Permission.camera.request();
      if (cameraPermission.isPermanentlyDenied) {
        print("Is Permanently denied");
        return;
      }
      if (cameraPermission.isGranted) {
        final imagePath = await ImagePicker().pickImage(source: source);
        if (imagePath == null) return;
        setState(() {
          this.imageFile = File(imagePath.path);
        });
      }
    }
  }
}
