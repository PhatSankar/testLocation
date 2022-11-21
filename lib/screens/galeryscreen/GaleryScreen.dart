import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testlocation/widgets/Drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testlocation/widgets/PickButton.dart';

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
                    ? const FlutterLogo(
                        size: 160,
                      )
                    : GestureDetector(
                  child: Image.file(imageFile!,
                  height: MediaQuery.of(context).size.height / 2,),
                  onTap: () async {
                    var edittedImage = await Navigator.push(context, MaterialPageRoute(builder: (context) => ImageEditor(
                      image: imageFile!.readAsBytesSync(),
                      appBar: Colors.blue,
                    )));
                    if (edittedImage!= null)
                      {
                        imageCache.clear();
                        final tempDir = await getTemporaryDirectory();
                        final file = await File('${tempDir.path}/image.jpg').create();
                        await file.writeAsBytes(edittedImage);
                        setState(() {
                          imageFile = file;
                        });
                      }
                  },
                ),
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
                PickButton(
                    buttonTitle: "Save image",
                    buttonIcon: Icons.save,
                    onPressedButton:() => imageFile == null ? null : onPressSaveImage()
                ),
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
        imageFile = File(imagePath.path);
      });
    } else {
      cameraPermission = await Permission.camera.request();
      if (cameraPermission.isPermanentlyDenied) {
        return;
      }
      if (cameraPermission.isGranted) {
        final imagePath = await ImagePicker().pickImage(source: source);
        if (imagePath == null) return;
        setState(() {
          imageFile = File(imagePath.path);
        });
      }
    }
  }
  Future onPressSaveImage() async {
    await Permission.storage.request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final nameImage = 'image_$time';
    final result = await ImageGallerySaver
        .saveImage(imageFile!.readAsBytesSync(), name: nameImage);
    print(result['filePath']);
  }

}
