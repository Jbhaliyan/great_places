// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:great_places/helpers/location_helpers.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUsrrLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude!, longitude: locData.longitude!);
    // print(locData.latitude);
    // print(locData.longitude);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: _previewImageUrl == null
            ? const Text(
                'No Location Chossen',
                textAlign: TextAlign.center,
              )
            : Image.network(_previewImageUrl!,
                fit: BoxFit.cover, width: double.infinity),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton.icon(
            icon: const Icon(Icons.location_on),
            label: const Text('Current Location'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _getCurrentUsrrLocation,
          ),
          FlatButton.icon(
            icon: const Icon(Icons.map),
            label: const Text('Select on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {},
          )
        ],
      )
    ]);
  }
}
