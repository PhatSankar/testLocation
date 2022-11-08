part of 'geo_bloc.dart';

class GeoEvent extends Equatable {
  final GBLatLng currentPosition;
  const GeoEvent(this.currentPosition);
  @override
  // TODO: implement props
  List<Object?> get props => [currentPosition];
}
