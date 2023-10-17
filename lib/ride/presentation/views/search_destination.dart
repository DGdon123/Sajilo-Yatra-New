import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/ride/presentation/views/set_location.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:http/http.dart' as http;
import '../../../const/app_const.dart';
import '../../../const/app_dimension.dart';
import '../../../const/app_fonts.dart';

class Destination extends ConsumerStatefulWidget {
  const Destination({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<Destination> {
  LatLng? currentLocation2;
  LatLng? currentLocation;
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? currentAddress;
  bool isLocationLoaded = false;
  bool searching = false;
  List<String> _places = [];
  final FocusNode _searchFocusNode = FocusNode();

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
          places.add(placeName);
        }
      } else {
        places.add('No results found');
      }

      setState(() => _places = places);
    } catch (e) {
      print('Failed to get search results from Mapbox: $e');
    }
  }

  LatLng? editingLocation; // Store the location being edited
  bool isEditingLocation = false;
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
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
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            AppConst.kTrip,
            style: TextStyle(
              fontSize: AppDimensions.body_16,
              letterSpacing: 0.06.dp,
              fontFamily: AppFont.lProductsanfont,
              fontWeight: AppDimensions.fontMediumNormal,
              color: AppColorConst.kappWhiteColor,
            ),
          ),
        ),
      ),
      body: isLocationLoaded
          ? SlidingUpPanel(
              borderRadius: BorderRadius.circular(16),
              panel: Column(
                children: [
                  Container(
                    width: 95.w,
                    height: 7.h,
                    padding: const EdgeInsets.only(left: 4, right: 4, top: 18),
                    child: TextFormField(
                      cursorColor: AppColorConst.kappprimaryColorRed,
                      maxLines: 1,
                      controller: emailController,
                      style: const TextStyle(fontSize: 12),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          CupertinoIcons.person,
                          size: 5.w,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappprimaryColorRed,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappprimaryColorRed,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappprimaryColorRed,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappprimaryColorRed,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5)),
                        border: InputBorder.none,
                        fillColor: const Color(0xffF9F9FC),
                        filled: true,
                        hintText: currentAddress ?? "Search PickUp",
                        hintStyle:
                            const TextStyle(fontSize: 12, letterSpacing: 0.35),
                      ),
                    ),
                  ),
                  Container(
                    width: 95.w,
                    height: 7.h,
                    padding: const EdgeInsets.only(left: 4, right: 4, top: 18),
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
                  const SizedBox(
                    height: AppDimensions.paddingDEFAULT,
                  ),
                  Container(
                    width: 105.w,
                    height: 1.2.h,
                    color: CupertinoColors.systemGrey6,
                  ),
                  searching
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: _places.length,
                            itemBuilder: (BuildContext context, int index) {
                              final place = _places[index];
                              return ListTile(
                                title: place == 'No results found'
                                    ? Text(place)
                                    : Text(place),
                                onTap: () {
                                  if (place != 'No results found') {
                                    _textEditingController.text = place;
                                    setState(() => _places.clear());
                                  }
                                },
                              );
                            },
                          ),
                        )
                      : GestureDetector(
                          child: Container(
                            width: 100.w,
                            height: 8.h,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                    height: 4.2.h,
                                    width: 8.w,
                                    margin: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        color: AppColorConst.kappscafoldbggrey,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      CupertinoIcons.map_pin,
                                      size: 4.w,
                                      color: CupertinoColors.darkBackgroundGray,
                                    )),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  AppConst.kMap,
                                  style: const TextStyle(
                                      fontSize: AppDimensions.body_13,
                                      letterSpacing: 0.35,
                                      fontWeight:
                                          AppDimensions.fontMediumNormal,
                                      fontFamily: AppFont.lProductsanfont),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            normalNav(context, const SetLocation());
                          }),
                  Container(
                    width: 105.w,
                    height: 1.2.h,
                    color: CupertinoColors.systemGrey6,
                  ),
                  const SizedBox(
                    height: AppDimensions.paddingDEFAULT,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 4.2.h,
                        width: 8.w,
                        margin: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            color: AppColorConst.kappscafoldbggrey,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(CupertinoIcons.home,
                            size: 4.w,
                            color: CupertinoColors.darkBackgroundGray),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConst.kappBarHome,
                            style: TextStyle(
                                fontSize: AppDimensions.body_12,
                                letterSpacing: 0.06.dp,
                                fontFamily: AppFont.lProductsanfont,
                                fontWeight: AppDimensions.fontBold,
                                color: AppColorConst.kappsecondaryColorBlack),
                          ),
                          const SizedBox(
                              height: AppDimensions.paddingEXTRASMALL),
                          const Text(
                            "Set home address",
                            style: TextStyle(
                                fontSize: AppDimensions.body_11,
                                fontFamily: AppFont.lProductsanfont,
                                fontWeight: AppDimensions.fontMediumNormal,
                                color: AppColorConst.kappscafoldbggrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppDimensions.paddingDEFAULT,
                  ),
                  Container(
                    width: 105.w,
                    height: 0.2.h,
                    color: CupertinoColors.systemGrey6,
                  ),
                  const SizedBox(
                    height: AppDimensions.paddingDEFAULT,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 4.2.h,
                        width: 8.w,
                        margin: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            color: AppColorConst.kappscafoldbggrey,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(Icons.business_center_rounded,
                            size: 4.w,
                            color: CupertinoColors.darkBackgroundGray),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConst.kWork,
                            style: TextStyle(
                                fontSize: AppDimensions.body_12,
                                letterSpacing: 0.06.dp,
                                fontFamily: AppFont.lProductsanfont,
                                fontWeight: AppDimensions.fontBold,
                                color: AppColorConst.kappsecondaryColorBlack),
                          ),
                          const SizedBox(
                              height: AppDimensions.paddingEXTRASMALL),
                          const Text(
                            "Set work address",
                            style: TextStyle(
                                fontSize: AppDimensions.body_11,
                                fontFamily: AppFont.lProductsanfont,
                                fontWeight: AppDimensions.fontMediumNormal,
                                color: AppColorConst.kappscafoldbggrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppDimensions.paddingDEFAULT,
                  ),
                  Container(
                    width: 105.w,
                    height: 1.2.h,
                    color: CupertinoColors.systemGrey6,
                  ),
                ],
              ),
              minHeight: 215,
              maxHeight: 480,
              body: FlutterMap(
                options: MapOptions(
                    center: currentLocation ?? const LatLng(0, 0),
                    zoom: 18.0,
                    maxZoom: 18.0,
                    rotation: 0.0,
                    minZoom: 5.0),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      if (currentLocation != null)
                        Marker(
                          width: 30.0,
                          height: 30.0,
                          point: currentLocation!,
                          builder: (ctx) => Icon(
                            CupertinoIcons.location_solid,
                            size: 5.95.w,
                            color: AppColorConst.kappprimaryColorRed,
                          ),
                        ),
                      if (editingLocation != null)
                        Marker(
                          width: 30.0,
                          height: 30.0,
                          point: editingLocation!,
                          builder: (ctx) => GestureDetector(
                            // Gesture detector to handle dragging
                            onPanUpdate: (details) {
                              setState(() {
                                editingLocation = LatLng(
                                  editingLocation!.latitude +
                                      details.delta
                                          .dy, // Use details.delta.dy for latitude
                                  editingLocation!.longitude + details.delta.dx,
                                );
                              });
                            },
                            child: const Icon(
                              CupertinoIcons.add,
                              size: 30,
                              color: AppColorConst.kappprimaryColorRed,
                            ),
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
