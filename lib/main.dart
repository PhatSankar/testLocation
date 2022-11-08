import 'package:flutter/material.dart';
import 'package:testlocation/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Geocoder',
      initialRoute: '/',
      onGenerateRoute: routeGenerator.generateRoute,
    );
  }
}