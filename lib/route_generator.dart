import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testlocation/bloc/download_bloc/download_bloc.dart';
import 'package:testlocation/bloc/geo_bloc/geo_bloc.dart';
import 'package:testlocation/screens/camerascreen/CameraScreen.dart';
import 'package:testlocation/screens/downloadopenscreen/DownloadOpenScreen.dart';
import 'package:testlocation/screens/firstscreen/FirsScreen.dart';
import 'package:testlocation/screens/galeryscreen/GaleryScreen.dart';
import 'package:testlocation/screens/internetscreen/InternetScreen.dart';
import 'package:testlocation/screens/readwritefilescreen/ReadWriteFileScreen.dart';

class routeGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<GeoBloc>(
            create: (context) => GeoBloc(),
            child: const FirstPage(),
          );
        });
      case '/camera-screen':
        return MaterialPageRoute(builder: (context) {
          final args = settings.arguments as Map;

          CameraDescription camera = args['camera'] as CameraDescription;
          PermissionStatus cameraPermission =
              args['currentCameraPermission'] as PermissionStatus;
          PermissionStatus microPermisson =
              args['currentMicrophonePermission'] as PermissionStatus;
          return CameraScreen(
              camera: camera,
              cameraPermission: cameraPermission,
              microPermission: microPermisson);
        });
      case '/gallery-screen':
        return MaterialPageRoute(builder: (context) {
          return const GalleryScreen();
        });
      case '/read-write-screen':
        return MaterialPageRoute(builder: (context) {
          return const ReadWriteFileScreen();
        });
      case '/download-open-screen':
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<DownloadBloc>(
            create: (context) => DownloadBloc(),
            child: DownloadOpenScreen(),
          );
        });
      case '/internet-screen':
        return MaterialPageRoute(builder: (context) {
          return const InternetScreen();
        });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Center(
            child: Text("Error"),
          ),
        ),
      );
    });
  }
}
