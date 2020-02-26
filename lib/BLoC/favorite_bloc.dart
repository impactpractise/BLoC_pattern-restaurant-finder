import 'dart:async';

import 'package:restaurant_finder/BLoC/bloc.dart';

import '../DataLayer/restaurant.dart';

class FavoriteBloc implements Bloc {
  var _restaurants = <Restaurant>[];
  List<Restaurant> get favorites => _restaurants;

  // 1. Broadcast instead of regular StreamController to allow multiple listeners.

  final _controller = StreamController<List<Restaurant>>.broadcast();
  Stream<List<Restaurant>> get favoritesStream => _controller.stream;

  void toggleRestaurant(Restaurant restaurant) {
    if (_restaurants.contains(restaurant)) {
      _restaurants.remove(restaurant);
    } else {
      _restaurants.add(restaurant);
    }

    _controller.sink.add(_restaurants);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
