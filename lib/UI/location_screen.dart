import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/location_bloc.dart';
import 'package:restaurant_finder/BLoC/location_query_bloc.dart';

import '../DataLayer/location.dart';

class LocationScreen extends StatelessWidget {
  final bool isFullScreenDialog;

  const LocationScreen({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. instantiate new LocationQueryBloc
    final bloc = LocationQueryBloc();

    // 2. Store into BlocProvider to manage its lifecycle.
    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Where would you like to eat?')),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a location'),
                onChanged: (query) {
                  bloc.submitQuery(query);
                  // 3. Submit text to LocationQueryBloc to kick off chain of calling Zomato
                  // then emitting found locations to the stream.
                },
              ),
            ),
            Expanded(
              // 4. Pass Bloc to _buildResults method.
              child: _buildResults(bloc),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResults(LocationQueryBloc bloc) {
    return StreamBuilder<List<Location>>(
        stream: bloc.locationStream,
        builder: (context, snapshot) {
          // 1.
          final results = snapshot.data;
          if (results == null) {
            return Center(child: Text('Enter a location'));
          }
          return _buildSearchResults(results);
        });
  }

  Widget _buildSearchResults(List<Location> results) {
    // 2.
    return ListView.separated(
        itemCount: results.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (context, index) {
          final location = results[index];
          return ListTile(
            title: Text(location.title),
            onTap: () {
              // 3.
              final locationBloc = BlocProvider.of<LocationBloc>(context);
              locationBloc.selectLocation(location);

              if (isFullScreenDialog) {
                Navigator.of(context).pop();
              }
            },
          );
        });
  }
}
