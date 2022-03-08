import 'package:flutter/material.dart';
import 'package:great_places/screens/add_places_screen.dart';
import 'package:great_places/screens/place_list_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../screens/place_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amber),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => PlacesListScreen(),
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}
