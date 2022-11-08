part of 'geo_bloc.dart';

abstract class GeoState extends Equatable {
  const GeoState();
  List<Object> get props => [];

}

class GeoInitial extends GeoState { }

class GeoLoading extends GeoState { }

class GeoCompelete extends GeoState
{
  final LocationInfo positionInfo;
  const GeoCompelete({required this.positionInfo});
  @override
  List<Object> get props => [positionInfo];
}

class GeoError extends GeoState { }
