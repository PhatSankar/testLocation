

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
            title: Text("Camera screen (this is a test for Gallery Screen"),
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
            onTap: ()  {
              Navigator.pushReplacementNamed(context, '/gallery-screen');
            },
          ),
          ListTile(
            title: Text("Read Write File"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/read-write-screen');
            },
          ),
          ListTile(
            title: Text("Download open file"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/download-open-screen');
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
