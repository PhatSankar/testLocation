import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testlocation/widgets/Drawer.dart';

class CameraScreen extends StatefulWidget {
  CameraDescription camera;
  PermissionStatus cameraPermission;
  PermissionStatus microPermission;

  CameraScreen({Key? key, required this.camera, required this.cameraPermission, required this.microPermission})
      : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late PermissionStatus _cameraPermission;
  late PermissionStatus _microPermission;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraPermission = widget.cameraPermission;
    _microPermission = widget.microPermission;
    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(),
            body: FutureBuilder<void>(
              future: initCamera(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (_cameraPermission.isGranted && _microPermission.isGranted) {
                    return CameraPreview(_cameraController);
                  }
                  else
                    {
                      return isCameraDenied();
                    }
                } else {
                  // Otherwise, display a loading indicator.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )));
  }

  Future<void> initCamera() async {
    if (_cameraPermission.isGranted) {
      return _cameraController.initialize();
    }
  }

  Widget isCameraDenied() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 24.0,
            right: 16.0,
          ),
          child: const Text(
            'You need to give this permission from the system settings.',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, top: 24.0, right: 16.0, bottom: 24.0),
          child: ElevatedButton(
            child: Text(_cameraPermission.isPermanentlyDenied || _microPermission.isPermanentlyDenied
                ? 'Open settings to allow microphone and camera'
                : 'Allow access'),
            onPressed: () async {
              var cameraStatus = await Permission.camera.status;
              var microphoneStatus = await Permission.microphone.status;
              if (_cameraPermission.isPermanentlyDenied || _microPermission.isPermanentlyDenied) {
                openAppSettings();
              }
              else
                {

                  print(cameraStatus);
                  print(microphoneStatus);

                  if (!cameraStatus.isGranted) {
                      cameraStatus = await Permission.camera.request();
                  }
                  print("camera granted");

                  if (!microphoneStatus.isGranted) {
                    microphoneStatus = await Permission.microphone.request();
                  }
                  print("camera granted");
                }
             setState(() {
                _microPermission = microphoneStatus;
                _cameraPermission = cameraStatus;
              });
            },
          ),
        ),
      ],
    );
  }
}
