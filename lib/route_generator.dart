
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testlocation/bloc/geo_bloc/geo_bloc.dart';
import 'package:testlocation/screens/firstscreen/FirstPage.dart';

class routeGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<GeoBloc>(
            create: (context) => GeoBloc(),
            child: const FirstPage(),
          );
        });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute()
  {
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