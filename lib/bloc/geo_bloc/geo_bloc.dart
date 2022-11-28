import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:testlocation/models/locationInfo.dart';

import '../../services/location_service.dart';

part 'geo_event.dart';
part 'geo_state.dart';

class GeoBloc extends Bloc<GeoEvent, GeoState> {
  GeoBloc() : super(GeoInitial()) {
    on<GeoEvent>((event, emit) async {
      try
      {
        if (state is GeoInitial || state is GeoError || state is GeoCompelete)
          {
            emit(GeoLoading());
            LocationInfo? getDetails = (await getInfo(event.currentPosition)) as LocationInfo?;
            if (getDetails == null)
            {
              emit(GeoError());
            }
            else
            {
              emit(GeoCompelete(positionInfo: getDetails));
            }
          }
      }
      catch(exeption)
      {
        emit(GeoError());
      }
    });
  }
}
