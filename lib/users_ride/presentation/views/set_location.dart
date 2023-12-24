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
import 'package:sajilo_yatra/users_ride/presentation/views/confirm_destination.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:sajilo_yatra/utils/form_validation/form_validation_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class SetLocation extends ConsumerStatefulWidget {
  const SetLocation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<SetLocation> {
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
          ? Stack(
              children: [
                FlutterLocationPicker(
                    selectLocationButtonText: AppConst.kDestination,
                    searchbarInputFocusBorderp: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColorConst.kappprimaryColorRed,
                          width: 0.164.w),
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
                    contributorBadgeForOSMColor:
                        AppColorConst.kappprimaryColorRed,
                    contributorBadgeForOSMTextColor:
                        AppColorConst.kappprimaryColorRed,
                    initZoom: 22,
                    minZoomLevel: 5,
                    maxZoomLevel: 18,
                    trackMyPosition: true,
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                      if (_textEditingController.text != '') {
                        try {
                          final latitude =
                              double.parse(_textEditingController2.text);
                          final longitude =
                              double.parse(_textEditingController3.text);
                          log(latitude.toString());
                          log(longitude.toString());
                          normalNav(
                            context,
                            ConfirmLocation(
                              destination: _textEditingController.text,
                              latitude: latitude,
                              longitude: longitude,
                            ),
                          );
                        } catch (e) {
                          log('Error parsing latitude/longitude: $e');
                        }
                      } else {
                        try {
                          final latitude = pickedData.latLong.latitude;
                          final longitude = pickedData.latLong.longitude;
                          final current = pickedData.address;

                          log(latitude.toString());
                          log(longitude.toString());
                          normalNav(
                            context,
                            ConfirmLocation(
                              destination: current,
                              latitude: latitude,
                              longitude: longitude,
                            ),
                          );
                        } catch (e) {
                          log('Error parsing latitude/longitude: $e');
                        }
                      }
                    }),
                Positioned(
                  top: 90,
                  child: Container(
                    alignment: Alignment.center,
                    width: 95.w,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      cursorColor: AppColorConst.kappprimaryColorRed,
                      maxLines: 1,
                      controller: _textEditingController,
                      focusNode: _searchFocusNode,
                      onEditingComplete: () {
                        setState(() {
                          searching = false;
                          _searchFocusNode.unfocus();
                        });
                      },
                      style: const TextStyle(fontSize: 12),
                      textInputAction: TextInputAction.done,
                      onChanged: (value) => searchPlacesInNepal(),
                      onTap: () {
                        setState(() {
                          searching = true;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _textEditingController.clear();
                          },
                          child: const Icon(
                            Icons.clear_outlined,
                            size: 20,
                            color: CupertinoColors.darkBackgroundGray,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.location_on_rounded,
                          size: 5.w,
                          color: AppColorConst.kappprimaryColorRed,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappscafoldbggrey,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappscafoldbggrey,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappscafoldbggrey,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappscafoldbggrey,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5)),
                        border: InputBorder.none,
                        fillColor: const Color(0xffF9F9FC),
                        filled: true,
                        hintText: AppConst.ksearchDestination,
                        hintStyle:
                            const TextStyle(fontSize: 12, letterSpacing: 0.35),
                      ),
                    ),
                  ),
                ),
                searching
                    ? Positioned(
                        top: 145,
                        child: Container(
                          width: 95.w,
                          height: 26.2.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _places.length,
                            itemBuilder: (context, index) {
                              if (index >= 0 && index < _places.length) {
                                final placeInfo = _places[index];
                                final placeParts = placeInfo.split('|');

                                if (placeParts.length >= 3) {
                                  final placeName = placeParts[0];
                                  final latitude = placeParts[1];
                                  final longitude = placeParts[2];

                                  return ListTile(
                                    title: Text(placeName),
                                    onTap: () {
                                      _textEditingController.text = placeName;
                                      _textEditingController2.text = latitude;
                                      _textEditingController3.text = longitude;
                                      // You can access latitude and longitude here
                                      log('Latitude: $latitude, Longitude: $longitude');
                                      setState(() {
                                        _places = []; // Clear search results
                                      });
                                    },
                                  );
                                }
                              }
                              return const SizedBox(); // Return an empty widget if data is invalid
                            },
                          ),
                        ),
                      )
                    : Container()
              ],
            )
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
