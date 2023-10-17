import 'dart:convert';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;

LatLng? getCurrentLatLngFromSharedPrefs() {
  final latitude = sharedPreferences?.getDouble('latitude');
  final longitude = sharedPreferences?.getDouble('longitude');
  if (latitude != null && longitude != null) {
    return LatLng(latitude, longitude);
  }
  return null;
}

String? getCurrentAddressFromSharedPrefs() {
  return sharedPreferences?.getString('current-address');
}

LatLng? getTripLatLngFromSharedPrefs(String type) {
  final sourceLocationJson = sharedPreferences?.getString('source');
  final destinationLocationJson = sharedPreferences?.getString('destination');

  if (sourceLocationJson != null && destinationLocationJson != null) {
    final sourceLocationList = json.decode(sourceLocationJson)['location'];
    final destinationLocationList =
        json.decode(destinationLocationJson)['location'];

    LatLng source = LatLng(sourceLocationList[0], sourceLocationList[1]);
    LatLng destination =
        LatLng(destinationLocationList[0], destinationLocationList[1]);

    if (type == 'source') {
      return source;
    } else {
      return destination;
    }
  }
  return null;
}

String? getSourceAndDestinationPlaceText(String type) {
  final sourceJson = sharedPreferences?.getString('source');
  final destinationJson = sharedPreferences?.getString('destination');

  if (sourceJson != null && destinationJson != null) {
    String sourceAddress = json.decode(sourceJson)['name'];
    String destinationAddress = json.decode(destinationJson)['name'];

    if (type == 'source') {
      return sourceAddress;
    } else {
      return destinationAddress;
    }
  }
  return null;
}
