import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';
import 'package:sajilo_yatra/users_tickets/presentation/views/ticket_screen.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoingScreen extends ConsumerStatefulWidget {
  const GoingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<GoingScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();
  List<String> _places = [];

  Future<void> searchPlacesInNepal() async {
    final query = _textEditingController.text;
    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?country=np&access_token=pk.eyJ1IjoiZGdkb24tMTIzIiwiYSI6ImNsbGFlandwcjFxNGMzcm8xbGJjNTY4bmgifQ.dGSMw7Ai7BpXWW4qQRcLgA';

    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);

      final features = data['features'] as List<dynamic>;
      final places = <String>[];

      for (final feature in features) {
        final placeTypes = feature['place_type'] as List<dynamic>;
        if (placeTypes.contains('district') ||
            placeTypes.contains('place') ||
            placeTypes.contains('locality')) {
          final placeName = feature['place_name'] as String;
          places.add(placeName);
        }
      }

      if (places.isEmpty) {
        places.add('No results found');
      }

      setState(() => _places = places);
    } catch (e) {
      print('Failed to get search results from Mapbox: $e');
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppConst.kGoing,
          style: TextStyle(
              fontSize: AppDimensions.body_16,
              letterSpacing: 0.06.dp,
              fontFamily: AppFont.kProductsanfont,
              fontWeight: AppDimensions.fontMedium,
              color: AppColorConst.kappWhiteColor),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: AppColorConst.kappWhiteColor,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: AppColorConst.kappprimaryColorRed,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 12.25.h,
              color: AppColorConst.kappprimaryColorRed,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        width: 92.5.w,
                        child: TextFormField(
                          controller: _textEditingController,
                          maxLines: 1,
                          cursorColor: const Color(0xFF222222),
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) => searchPlacesInNepal(),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            suffixIcon: InkWell(
                              onTap: () {
                                _textEditingController.text = '';
                              },
                              child: const Icon(
                                Icons.close,
                                size: 28,
                                color: Color(0xFF222222),
                              ),
                            ),
                            prefixIcon: const Icon(
                              CupertinoIcons.search,
                              size: 28,
                              color: Color(0xFF222222),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFFFFFF),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(9),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFFFFFF),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(9),
                              ),
                            ),
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                              height: 1,
                              fontFamily: AppFont.kProductsanfont,
                              color: Color(0xFF222222),
                              fontSize: 16,
                            ),
                            suffixIconColor:
                                const Color.fromARGB(255, 255, 0, 0),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: AppFont.kProductsanfont,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Going field cannot be empty';
                            } else if (_places.isEmpty) {
                              return 'No matching places found';
                            }
                            return null;
                          },
                          onEditingComplete: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString(
                                'going', _textEditingController.text);
                            normalNav(context, const TicketScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _places.length,
                itemBuilder: (BuildContext context, int index) {
                  final place = _places[index];
                  return ListTile(
                    title:
                        place == 'No results found' ? Text(place) : Text(place),
                    onTap: () {
                      if (place != 'No results found') {
                        _textEditingController.text = place;
                        setState(() => _places.clear());
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
