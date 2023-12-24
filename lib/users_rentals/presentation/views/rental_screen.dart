import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/commons/custom_button.dart';
import 'package:sajilo_yatra/commons/custom_form.dart';
import 'package:sajilo_yatra/commons/custom_primary_button.dart';
import 'package:sajilo_yatra/commons/custom_secondary_button.dart';
import 'package:sajilo_yatra/commons/custom_third_button.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';
import 'package:sajilo_yatra/const/app_images_const.dart';
import 'package:sajilo_yatra/users_edit%20profile/data/models/edit_profile_request_model.dart';
import 'package:sajilo_yatra/help/help.dart';
import 'package:sajilo_yatra/offers/offers.dart';
import 'package:sajilo_yatra/users_profile/data/models/profile_params_model.dart';
import 'package:sajilo_yatra/users_profile/presentation/controllers/profile_controller.dart';
import 'package:sajilo_yatra/users_profile/presentation/views/profile_screen.dart';
import 'package:sajilo_yatra/users_rentals/data/models/rental_request_model.dart';

import 'package:sajilo_yatra/users_rentals/presentation/views/rental_leaving_screen.dart';
import 'package:sajilo_yatra/users_tickets/presentation/views/going_screen.dart';
import 'package:sajilo_yatra/users_tickets/presentation/views/leaving_screen.dart';
import 'package:sajilo_yatra/utils/bottom_bar/bottom_bar.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:sajilo_yatra/utils/form_validation/form_validation_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:logger/logger.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

import '../controllers/rental_controller.dart';

class RentalScreen extends ConsumerStatefulWidget {
  const RentalScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<RentalScreen> {
  String token = "";
  String veh = 'Bus';
  TextEditingController vehTypeController = TextEditingController();
  var vehicle = ['Bus', 'Jeep', 'MicroBus', 'Taxi', 'Others'];
  final GlobalKey<FormState> registerSignKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController date2 = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String? dob;
  String? leaving;
  String? going;
  String? vehicle2;
  var parsedToken = 0;
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  void initState() {
    super.initState();
    loadData(); // Preload the data when the widget is built.
  }

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('tokens') ?? "";
      logger.d(token);
      parsedToken = int.tryParse(token) ?? 0;
      logger.d(parsedToken);
      leaving = prefs.getString('rentalleaving') ?? "Enter City";
      dob = prefs.getString('rentaldob') ?? "Hire Till";
      vehicle2 = prefs.getString('rentaltype') ?? "Vehicle Type";
      vehTypeController.text = vehicle2 ?? "";
      location.text = leaving ?? "";
      dobController.text = dob ?? "";
    });
  }

  appLogin() async {
    RentalRequestModel loginRequestModel = RentalRequestModel(
      dob: dobController.text,
      vehicletype: vehTypeController.text,
      city: location.text,
    );
    if (registerSignKey.currentState!.validate()) {
      await ref.read(rentalControllerProvider.notifier).getRentalDetails(
          context: context, registerRequestModel: loginRequestModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Search for Vehicle Rentals",
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
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
// Remove data for the 'counter' key.
                await prefs.remove('rentalleaving');

                await prefs.remove('rentaldob');
                await prefs.remove('rentaltype');
                pushAndRemoveUntil(context, const BottomBar());
              },
            );
          },
        ),
        backgroundColor: AppColorConst.kappprimaryColorRed,
      ),
      body: Form(
        key: registerSignKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: CurvedBottomClipper(),
                    child: Container(
                      height: 27.h,
                      color: AppColorConst.kappprimaryColorRed,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 80.w,
                      margin: const EdgeInsets.only(top: 138),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(0, 0),
                            blurRadius: 4.0,
                            spreadRadius:
                                1.0, // Adjust the spreadRadius value as desired
                          ),
                          //BoxShadow
                          //BoxShadow
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: AppDimensions.paddingSMALL,
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: TextFormField(
                                readOnly: true,
                                controller: vehTypeController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    CupertinoIcons.bus,
                                    color: Color(0xFF222222),
                                  ),
                                  hintText: vehicle2 ?? AppConst.kvehicleType,
                                  hintStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                      color:
                                          AppColorConst.kappsecondaryColorBlack,
                                      fontFamily: AppFont.lProductsanfont),
                                  border: InputBorder
                                      .none, // Remove underline border
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappWhiteColor,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappWhiteColor,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappWhiteColor,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappWhiteColor,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                validator: (input) =>
                                    input!.isVehicleTypeValidate(input),
                                onTap: () async {
                                  final type = await showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Select Vehicle Type'),
                                        titleTextStyle: TextStyle(
                                            fontSize: AppDimensions.body_16,
                                            letterSpacing: 0.06.dp,
                                            fontFamily: AppFont.kProductsanfont,
                                            fontWeight:
                                                AppDimensions.fontMedium,
                                            color: AppColorConst
                                                .kappprimaryColorRed),
                                        content: Container(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child:
                                              DropdownButtonFormField<String>(
                                            isExpanded: true,

                                            value: veh,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                veh = newValue!;
                                                vehTypeController.text =
                                                    newValue;
                                              });
                                              Navigator.of(context)
                                                  .pop(newValue);
                                            },
                                            items: vehicle.map((String item) {
                                              return DropdownMenuItem<String>(
                                                value: item,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left:
                                                          6), // Add left padding for "Male" option
                                                  child: Text(item),
                                                ),
                                              );
                                            }).toList(),
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: const BorderSide(
                                                  color: AppColorConst
                                                      .kappprimaryColorRed, // Change the underline color here
                                                  width: 2.4,
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: const BorderSide(
                                                  color: AppColorConst
                                                      .kappprimaryColorRed, // Change the underline color here
                                                  width: 2.4,
                                                ),
                                              ),
                                            ),
                                            selectedItemBuilder:
                                                (BuildContext context) {
                                              return vehicle
                                                  .map<Widget>((String item) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left:
                                                          6), // Add left padding for selected item
                                                  child: Text(item),
                                                );
                                              }).toList();
                                            },
                                            dropdownColor: Colors
                                                .white, // Set the background color of the dropdown list
                                            icon: const Icon(Icons
                                                .arrow_drop_down), // Custom icon for the dropdown
                                            iconSize: 24,
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  if (type != null) {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    setState(() {
                                      vehTypeController.text = type;
                                      prefs.setString(
                                          'rentaltype', vehTypeController.text);

                                      logger.d(vehTypeController);
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: TextFormField(
                              controller: location,
                              onTap: () {
                                normalNav(context, const RentalLeavingScreen());
                              },
                              readOnly: true,
                              validator: (input) =>
                                  input!.isAddressValid(input),
                              cursorColor: AppColorConst.kappscafoldbggrey,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.near_me_rounded,
                                  color: Color(0xFF222222),
                                ),
                                hintText: leaving ?? 'Enter City',
                                hintStyle: const TextStyle(
                                    fontSize: 17,
                                    color:
                                        AppColorConst.kappsecondaryColorBlack,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    fontFamily: AppFont.lProductsanfont),
                                border:
                                    InputBorder.none, // Remove underline border
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1.1,
                                    color: AppColorConst.kappWhiteColor,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1.1,
                                    color: AppColorConst.kappWhiteColor,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1.1,
                                    color: AppColorConst.kappWhiteColor,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1.1,
                                    color: AppColorConst.kappWhiteColor,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: TextFormField(
                                readOnly: true,
                                controller: dobController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    CupertinoIcons.calendar,
                                    color: Color(0xFF222222),
                                  ),
                                  hintText: dob ?? "Hire Till",
                                  hintStyle: const TextStyle(
                                      fontSize: 17,
                                      color:
                                          AppColorConst.kappsecondaryColorBlack,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                      fontFamily: AppFont.lProductsanfont),
                                  border: InputBorder
                                      .none, // Remove underline border
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappWhiteColor,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappWhiteColor,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappWhiteColor,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappWhiteColor,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                validator: (input) =>
                                    input!.isVehicleTypeValidate(input),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  final DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          // Change the colors here
                                          primaryColor: AppColorConst
                                              .kappprimaryColorRed, // Header background color

                                          colorScheme: const ColorScheme.light(
                                            primary: AppColorConst
                                                .kappprimaryColorRed, // Selected day background color
                                            onPrimary: Colors
                                                .white, // Selected day text color
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (date != null) {
                                    dobController.text =
                                        DateFormat("yyyy-MM-dd").format(date);
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString(
                                        'rentaldob', dob.toString());
                                    dob = date.toString();
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 355),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: ContinuousRectangleBorder(
                                  side: const BorderSide(
                                    width: 0.8,
                                    color: AppColorConst.kappprimaryColorRed,
                                  ),
                                  borderRadius: BorderRadius.circular(22)),
                              backgroundColor:
                                  AppColorConst.kappprimaryColorRed,
                              elevation: 0,
                              fixedSize: Size(40.w, 6.h)),
                          onPressed: () => appLogin(),
                          child: const Text(
                            "Search",
                            style: TextStyle(
                                letterSpacing: 0.8,
                                fontSize: AppDimensions.body_16,
                                fontFamily: AppFont.oProductsanfont,
                                fontWeight: AppDimensions.fontMedium,
                                color: AppColorConst.kappWhiteColor),
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              ClipPath(
                clipper: CurvedBottomClipper2(),
                child: Container(
                  height: 27.h,
                  color: AppColorConst.kappprimaryColorRed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
