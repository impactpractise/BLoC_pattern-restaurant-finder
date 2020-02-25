import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';

import '../DataLayer/location.dart';

// Managing the apps selected location

class LocationBloc implements Bloc {
  Location _location;
  Location get selectedLocation => _location;

  // 1. Declare StreamController and type of object emitted.
  final _locationController = StreamController<Location>();

  // 2. Expose public getter to StreamController's stream
  Stream<Location> get locationStream => _locationController.stream;

  // 3. Input for BLoC. Cache objects private _location and add it to sink.
  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }

  // 4. Close StreamController to provide memory leak.
  @override
  void dispose() {
    _locationController.close();
  }
}
