import 'dart:convert';
import 'dart:developer' as dd;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';
import 'package:sajilo_yatra/const/app_images_const.dart';
import 'package:sajilo_yatra/ride/data/address_model.dart';
import 'package:sajilo_yatra/ride/presentation/views/set_location.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeLocation extends ConsumerStatefulWidget {
  final double latitude;
  final double longitude;
  final String destination;
  const HomeLocation({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.destination,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<HomeLocation> {
  LatLng? currentLocation;
  bool isLocationLoaded = false;
  String? currentAddress;
  List<LatLng> routeCoordinates = [];
  final TextEditingController emailController = TextEditingController();
  AddressClassModel? add;
  String formattedDuration = '';
  int totalDurationInMinutes = 0;
  double fixedRatePerKilometer = 0.3;
  double? totalPriceNPR;
  double exchangeRateUSDToNPR = 130;
  double? totalPriceUSD;
  double initialZoom = 18.0; // Initial zoom level
  double minZoom = 5.0; // Minimum zoom level
  double maxZoom = 18.0; // Maximum zoom level
  final panelController1 = PanelController();
  final panelController2 = PanelController();
  bool isSecondPanelOpen = false;
  @override
  void initState() {
    super.initState();
    loadSharedPrefsData();
    getCurrentLocation();
  }

  Future<void> getRouteCoordinates(LatLng origin, LatLng destination) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      const accessToken =
          'pk.eyJ1IjoiZGdkb24tMTIzIiwiYSI6ImNsbGFlandwcjFxNGMzcm8xbGJjNTY4bmgifQ.dGSMw7Ai7BpXWW4qQRcLgA'; // Replace with your Mapbox access token

      final url =
          'https://api.mapbox.com/directions/v5/mapbox/walking/${position.longitude},${position.latitude};${widget.longitude},${widget.latitude}?geometries=geojson&access_token=$accessToken';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final geometry =
            decoded['routes'][0]['geometry']['coordinates'] as List<dynamic>;

        for (final coord in geometry) {
          routeCoordinates.add(LatLng(coord[1], coord[0]));
        }

        final routes = decoded['routes'] as List<dynamic>;

        if (routes.isNotEmpty) {
          final route = routes[0] as Map<String, dynamic>;

          final durationSeconds = route['duration'] as double;
          final distanceMeters = route['distance'] as double;
          int averageSpeedKmh = 13; // Bus speed in km/h

          // Calculate total duration in minutes based on average speed
          int totalDurationInMinutes =
              (distanceMeters / (averageSpeedKmh * 1000 / 60)).ceil();

          // Convert total duration to hours and minutes
          int hours = totalDurationInMinutes ~/ 60;
          int minutes = totalDurationInMinutes % 60;
          double totalDistanceKm = distanceMeters / 1000;
          totalPriceUSD = totalDistanceKm * fixedRatePerKilometer;

          // Calculate the total price in NPR
          totalPriceNPR = (totalPriceUSD! * exchangeRateUSDToNPR);
          String formattedTotalDistanceKm = totalDistanceKm.toStringAsFixed(6);
          formattedDuration = '';

          if (hours > 0) {
            formattedDuration += '$hours hr ';
          }
          if (minutes > 0) {
            formattedDuration += '$minutes min';
          }
          if (totalPriceNPR! <= 100) {
            setState(() {
              totalPriceNPR = 100;
            });
          }

          dd.log('Total distance in meters: $distanceMeters');
          dd.log('Total duration: $formattedDuration');
          dd.log('Total price: $totalPriceNPR NPR'); // Add this line
          dd.log('Total distance by bus: $formattedTotalDistanceKm km');
        }
      } else {
        final responseBody = response.body;
        final responseJson = jsonDecode(responseBody);
        final message = responseJson['message'];

        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error...',
            text: message,
            onConfirmBtnTap: () {
              normalNav(context, const SetLocation());
            },
            confirmBtnColor: AppColorConst.kappprimaryColorRed);

        dd.log('Failed to fetch route. Status code: ${response.statusCode}');
        dd.log('Response body: $responseBody');
        throw Exception('Failed to fetch route');
      }
    } catch (e) {
      dd.log('Error fetching route: $e');
      throw Exception('Failed to fetch route');
    }
  }

  void loadSharedPrefsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    add = AddressClassModel(address: prefs.getString('currentAddress'));
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
      await getRouteCoordinates(
          LatLng(currentLocation!.latitude, currentLocation!.longitude),
          LatLng(widget.latitude, widget.longitude));

      setState(() {
        // Update the initialZoom based on the route's bounds
        initialZoom = determineZoomLevel(routeCoordinates);
        isLocationLoaded = true;
      });
    }
  }

  double determineZoomLevel(List<LatLng> coordinates) {
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLng = double.infinity;
    double maxLng = -double.infinity;

    for (final coord in coordinates) {
      if (coord.latitude < minLat) minLat = coord.latitude;
      if (coord.latitude > maxLat) maxLat = coord.latitude;
      if (coord.longitude < minLng) minLng = coord.longitude;
      if (coord.longitude > maxLng) maxLng = coord.longitude;
    }

    double latDiff = maxLat - minLat;
    double lngDiff = maxLng - minLng;

    double latZoom = log(360.0 / latDiff) / ln2;
    double lngZoom = log(360.0 / lngDiff) / ln2;

    return min(latZoom, lngZoom);
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
    }
  }

  final panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Get to Home',
          style: TextStyle(
            fontSize: AppDimensions.body_16,
            letterSpacing: 0.06.dp,
            fontFamily: AppFont.lProductsanfont,
            fontWeight: AppDimensions.fontMediumNormal,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
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
      ),
      body: isLocationLoaded
          ? SlidingUpPanel(
              borderRadius: BorderRadius.circular(16),
              panel: Column(
                children: [
                  const Icon(
                    Icons.horizontal_rule_outlined,
                    size: 34,
                    color: AppColorConst.kappscafoldbggrey,
                  ),
                  Container(
                    color: CupertinoColors.systemGrey6,
                    height: 10.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: AppDimensions.paddingDEFAULT,
                        ),
                        Image.asset(
                          AppImagesConst.appCar,
                          height: 2.8.h,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          width: AppDimensions.paddingSMALL,
                        ),
                        Text(
                          AppConst.kCar,
                          style: const TextStyle(
                              fontSize: AppDimensions.body_13,
                              letterSpacing: 0.35,
                              color: AppColorConst.kappsecondaryColorBlack,
                              fontWeight: AppDimensions.fontMedium,
                              fontFamily: AppFont.lProductsanfont),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "रु",
                                style: TextStyle(
                                    fontSize: AppDimensions.body_15,
                                    color:
                                        AppColorConst.kappsecondaryColorBlack,
                                    fontWeight: AppDimensions.fontNormal,
                                    fontFamily: AppFont.lProductsanfont),
                              ),
                              Text(
                                "${totalPriceNPR!.toInt()}",
                                style: const TextStyle(
                                    height: 1.8,
                                    fontSize: AppDimensions.body_13,
                                    color:
                                        AppColorConst.kappsecondaryColorBlack,
                                    fontWeight: AppDimensions.fontBold,
                                    fontFamily: AppFont.lProductsanfont),
                              ),
                              const SizedBox(
                                width: AppDimensions.paddingDEFAULT,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppDimensions.paddingDEFAULT,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: AppDimensions.paddingDEFAULT,
                      ),
                      Text(
                        AppConst.kDiscount,
                        style: const TextStyle(
                            fontSize: AppDimensions.body_13,
                            letterSpacing: 0.65,
                            color: AppColorConst.kappsecondaryColorBlack,
                            fontWeight: AppDimensions.fontMediumNormal,
                            fontFamily: AppFont.lProductsanfont),
                      ),
                    ],
                  ),
                  Container(
                    width: 95.w,
                    height: 7.h,
                    padding: const EdgeInsets.only(left: 4, right: 4, top: 18),
                    child: TextFormField(
                      cursorColor: AppColorConst.kappprimaryColorRed,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 12),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          child: const Icon(
                            Icons.clear_outlined,
                            size: 20,
                            color: CupertinoColors.darkBackgroundGray,
                          ),
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
                        hintText: AppConst.kDiscount,
                        hintStyle:
                            const TextStyle(fontSize: 12, letterSpacing: 0.35),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppDimensions.paddingDEFAULT,
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: ContinuousRectangleBorder(
                                side: const BorderSide(
                                  width: 0.8,
                                  color: AppColorConst.kappprimaryColorRed,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: AppColorConst.kappprimaryColorRed,
                            elevation: 0,
                            fixedSize: Size(92.5.w, 6.h)),
                        onPressed: () {},
                        child: Text(
                          AppConst.kFind,
                          style: TextStyle(
                              letterSpacing: 0.02.dp,
                              fontFamily: AppFont.lProductsanfont,
                              fontWeight: AppDimensions.fontMedium,
                              color: AppColorConst.kappWhiteColor),
                        )),
                  ),
                ],
              ),
              minHeight: 300,
              maxHeight: 300,
              body: FlutterMap(
                options: MapOptions(
                  rotation: 0.0,
                  center: currentLocation ?? const LatLng(0, 0),
                  zoom: initialZoom,
                  minZoom: minZoom,
                  maxZoom: maxZoom,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routeCoordinates,
                        color: CupertinoColors.systemGrey,
                        strokeWidth: 2.6,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      if (currentLocation != null)
                        Marker(
                          width: 170,
                          height: 85,
                          point: currentLocation!,
                          builder: (ctx) => Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                bottom: 58,
                                child: Container(
                                  height: 20,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      color: AppColorConst.kappWhiteColor,
                                      borderRadius:
                                          BorderRadius.circular(4.25)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          width:
                                              AppDimensions.paddingEXTRASMALL,
                                        ),
                                        Text(
                                          add!.address.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 9,
                                            color: AppColorConst
                                                .kappsecondaryColorBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          width:
                                              AppDimensions.paddingEXTRASMALL,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.person_pin_circle_outlined,
                                size: 7.8.w,
                                color: AppColorConst.kappsecondaryColorBlack,
                              ),
                            ],
                          ),
                        ),
                      Marker(
                        width: 170,
                        height: 110,
                        point: LatLng(widget.latitude, widget.longitude),
                        builder: (ctx) => Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom: 73,
                              child: Container(
                                height: 35,
                                width: 170,
                                decoration: BoxDecoration(
                                    color: AppColorConst.kappWhiteColor,
                                    borderRadius: BorderRadius.circular(4.25)),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: AppDimensions.paddingEXTRASMALL,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Reach in $formattedDuration',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 8,
                                              color: CupertinoColors.systemGrey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            "Home",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 9,
                                              height: 2.1,
                                              color: AppColorConst
                                                  .kappsecondaryColorBlack,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: AppDimensions.paddingEXTRASMALL,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              AppImagesConst.appPicker,
                              width: 7.w,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
