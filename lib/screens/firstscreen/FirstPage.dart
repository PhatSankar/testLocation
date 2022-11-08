import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testlocation/bloc/geo_bloc/geo_bloc.dart';

import '../../widgets/Drawer.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    GeoBloc _geoBloc = BlocProvider.of(context);
    return SafeArea(
        child: BlocBuilder<GeoBloc, GeoState> (
          bloc: _geoBloc,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              drawer: const AppDrawer(),
              body: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () async {
                          print("object");
                          _geoBloc.add(GeoEvent(await _getUserLocation()));
                        },
                        child: const Text("Get current position")
                    ),
                   state is GeoLoading
                    ? const Center(child: CircularProgressIndicator(),
                    )
                    : state is GeoError
                       ? const Text("Error")
                       : Text(state is GeoCompelete ? state.positionInfo.toString() : "No info")
                  ],
                ),
              ),
            );
          },
        )
    );
  }

  Future<GBLatLng> _getUserLocation() async {
    try{
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return GBLatLng(lat: position.latitude, lng: position.longitude);
    }
    catch(exeption)
    {
      return GBLatLng(lat: 10.762622, lng: 106.7);
    }
  }
}
