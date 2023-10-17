import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';
import 'package:sajilo_yatra/dashboard/presentation/views/dashboard_screen.dart';
import 'package:sajilo_yatra/ride/presentation/views/set_home_location.dart';
import 'package:sajilo_yatra/ride/presentation/views/set_location.dart';
import 'package:sajilo_yatra/ride/presentation/views/set_work_location.dart';
import 'package:sajilo_yatra/utils/bottom_bar/bottom_bar.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkAddress extends ConsumerStatefulWidget {
  const WorkAddress({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<WorkAddress> {
  bool searching = false;
  final FocusNode _searchFocusNode = FocusNode();
  List<String> _places = [];
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();

  final TextEditingController _textEditingController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorConst.kappWhiteColor,
        title: Text(
          'Set work address',
          style: TextStyle(
              fontSize: AppDimensions.body_16,
              letterSpacing: 0.06.dp,
              fontFamily: AppFont.lProductsanfont,
              fontWeight: AppDimensions.fontMediumNormal,
              color: AppColorConst.kappsecondaryColorBlack),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColorConst.kappscafoldbggrey,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 105.w,
            height: 0.98.h,
            color: CupertinoColors.systemGrey6,
          ),
          Container(
            alignment: Alignment.center,
            width: 95.w,
            height: 6.h,
            margin: const EdgeInsets.only(top: 12, left: 18, right: 18),
            child: TextFormField(
              cursorColor: AppColorConst.kappprimaryColorRed,
              maxLines: 1,
              controller: _textEditingController,
              focusNode: _searchFocusNode,
              onEditingComplete: () {
                setState(() {
                  searching = false;
                  _searchFocusNode.unfocus();
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setString(
                        'work1', _textEditingController.text.toString());
                  });
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setDouble(
                        'lat2', double.parse(_textEditingController2.text));
                  });
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setDouble(
                        'long2', double.parse(_textEditingController3.text));
                  });
                  normalNav(context, const BottomBar());
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
                  CupertinoIcons.home,
                  size: 4.85.w,
                  color: AppColorConst.kappprimaryColorRed,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
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
                hintText: 'Set work address',
                hintStyle: const TextStyle(fontSize: 12, letterSpacing: 0.65),
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
              : Container(),
          const SizedBox(
            height: AppDimensions.paddingDEFAULT,
          ),
          Container(
            width: 105.w,
            height: 0.98.h,
            color: CupertinoColors.systemGrey6,
          ),
          InkWell(
            onTap: () {
              normalNav(context, const SetWorkLocation());
            },
            child: SizedBox(
              height: 10.h,
              child: Row(
                children: [
                  Container(
                      height: 4.2.h,
                      width: 8.w,
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          color: AppColorConst.kappscafoldbggrey,
                          borderRadius: BorderRadius.circular(50)),
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
                        fontWeight: AppDimensions.fontMediumNormal,
                        fontFamily: AppFont.lProductsanfont),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 105.w,
            height: 2.h,
            color: CupertinoColors.systemGrey6,
          ),
        ],
      ),
    );
  }
}
