

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("First Page"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: Text("Camera screen"),
            onTap: () async {
              final firstCamera = await getCamera();
              final currentCameraPermission = await Permission.camera.status;
              final currentMicPermission = await Permission.microphone.status;
              Navigator.pushReplacementNamed(context, '/camera-screen', arguments: {
                "camera": firstCamera,
                "currentCameraPermission": currentCameraPermission,
                "currentMicrophonePermission": currentMicPermission
              });
            },
          ),
          ListTile(
            title: Text("Gallery screen"),
            onTap: () async {
              Navigator.pushReplacementNamed(context, '/gallery-screen');
            },
          )
        ],
      ),
    );
  }

  Future<CameraDescription> getCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    return cameras.first;
  }
}
