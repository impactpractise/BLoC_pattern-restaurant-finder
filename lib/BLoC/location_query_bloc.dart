import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';

import '../DataLayer/location.dart';
import '../DataLayer/zomato_client.dart';

// BloC to query the location

class LocationQueryBloc implements Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();
  Stream<List<Location>> get locationStream => _controller.stream;

  void submitQuery(String query) async {
    // 1. Fetch Locations from ZomatoClient API async.
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
