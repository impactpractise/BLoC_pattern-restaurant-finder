import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/location_bloc.dart';

import '../DataLayer/location.dart';
import 'location_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Location>(
        // 1. Use .of method to retrieve the LocationBloc and add its data stream to the StreamBuilder
        stream: BlocProvider.of<LocationBloc>(context).locationStream,
        builder: (context, snapshot) {
          final location = snapshot.data;
          if (location == null) {
            return LocationScreen();
          }
          return Container();
        });
  }
}
