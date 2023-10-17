import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/commons/custom_form.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';
import 'package:sajilo_yatra/const/app_images_const.dart';
import 'package:sajilo_yatra/dashboard/presentation/views/dashboard_screen.dart';
import 'package:sajilo_yatra/ride/presentation/views/confirm_destination.dart';
import 'package:sajilo_yatra/utils/bottom_bar/bottom_bar.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:sajilo_yatra/utils/form_validation/form_validation_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class SetWorkLocation extends ConsumerStatefulWidget {
  const SetWorkLocation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<SetWorkLocation> {
  LatLng? currentLocation;

  LatLng?
      selectedMarkerLocation; // Added variable to store the extra marker's location
  bool searching = false;
  String? currentAddress;

  bool isLocationLoaded = false;
  List<String> _places = [];
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();

  @override
  void initState() {
    super.initState();

    getCurrentLocation();
  }

  Future<void> searchPlacesInNepal() async {
    final query = _textEditingController.text;
    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?country=np&access_token=pk.eyJ1IjoiZGdkb24tMTIzIiwiYSI6ImNsbGFlandwcjFxNGMzcm8xbGJjNTY4bmgifQ.dGSMw7Ai7BpXWW4qQRcLgA';

    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);

      final features = data['features'] as List<dynamic>;
      final places = <String>[];

      if (features.isNotEmpty) {
        for (final feature in features) {
          final placeName = feature['place_name'] as String;

          // Extract coordinates
          final coordinates =
              feature['geometry']['coordinates'] as List<dynamic>;
          final latitude = coordinates[1] as double;
          final longitude = coordinates[0] as double;

          // Format into a string "Place Name|Latitude|Longitude"
          final formattedPlace = '$placeName|$latitude|$longitude';
          places.add(formattedPlace);
        }
      } else {
        places.add('No results found');
      }

      setState(() => _places = places);
    } catch (e) {
      print('Failed to get search results from Mapbox: $e');
    }
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLocation = LatLng(position.latitude, position.longitude);
      await getCurrentAddress();
      setState(() {
        isLocationLoaded = true;
      });
    }
  }

  Future<void> getCurrentAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentLocation!.latitude,
      currentLocation!.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];

      String thoroughfare = placemark.thoroughfare ?? '';
      String locality = placemark.locality ?? '';
      String administrativeArea = placemark.administrativeArea ?? '';

      currentAddress = '$thoroughfare, $locality, $administrativeArea';
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('currentAddress', currentAddress.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorConst.kappprimaryColorRed,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(
          AppConst.kMap,
          style: TextStyle(
            fontSize: AppDimensions.body_16,
            letterSpacing: 0.06.dp,
            fontFamily: AppFont.lProductsanfont,
            fontWeight: AppDimensions.fontMediumNormal,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      body: isLocationLoaded
          ? FlutterLocationPicker(
              selectLocationButtonText: AppConst.kConfirmWork,
              searchbarInputFocusBorderp: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColorConst.kappprimaryColorRed, width: 0.164.w),
              ),
              searchBarHintText: AppConst.loading,
              loadingWidget: SizedBox(
                height: 2.4.h,
                width: 4.6.w,
                child: const CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColorConst
                        .kappscafoldbggrey, // Set your desired color here
                  ),
                  backgroundColor: AppColorConst.kappprimaryColorRed,
                ),
              ),
              selectLocationButtonStyle: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              locationButtonBackgroundColor: AppColorConst.kappWhiteColor,
              zoomButtonsBackgroundColor: AppColorConst.kappWhiteColor,
              markerIcon: Image.asset(
                AppImagesConst.appPicker,
                width: 7.w,
                fit: BoxFit.fill,
              ),
              zoomButtonsColor: AppColorConst.kappprimaryColorRed,
              locationButtonsColor: AppColorConst.kappprimaryColorRed,
              contributorBadgeForOSMColor: AppColorConst.kappprimaryColorRed,
              contributorBadgeForOSMTextColor:
                  AppColorConst.kappprimaryColorRed,
              initZoom: 22,
              minZoomLevel: 5,
              maxZoomLevel: 18,
              trackMyPosition: true,
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              searchBarBackgroundColor: Colors.white,
              selectedLocationButtonTextstyle: const TextStyle(
                  fontSize: 18,
                  color: AppColorConst.kappprimaryColorRed,
                  letterSpacing: 0.25,
                  fontFamily: AppFont.lProductsanfont),
              mapLanguage: 'en',
              onError: (e) => print(e),
              selectLocationButtonLeadingIcon: const Icon(
                Icons.check,
                color: AppColorConst.kappprimaryColorRed,
              ),
              onPicked: (pickedData) {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setString('work', pickedData.address.toString());
                });
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setDouble('latitude2',
                      double.parse(pickedData.latLong.latitude.toString()));
                });
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setDouble('longitude2',
                      double.parse(pickedData.latLong.longitude.toString()));
                });
                normalNav(context, const BottomBar());
              })
          : const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColorConst
                      .kappscafoldbggrey, // Set your desired color here
                ),
                backgroundColor: AppColorConst.kappprimaryColorRed,
              ),
            ),
    );
  }
}
