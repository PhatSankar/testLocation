import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:testlocation/route_generator.dart';
import 'package:testlocation/services/backgroundService.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await Workmanager().initialize(
    callBackDispatcher,
    isInDebugMode: true
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OverlaySupport.global(
        child: MaterialApp(
      title: 'Geocoder',
      initialRoute: '/',
      onGenerateRoute: routeGenerator.generateRoute,
    ));
  }
}
