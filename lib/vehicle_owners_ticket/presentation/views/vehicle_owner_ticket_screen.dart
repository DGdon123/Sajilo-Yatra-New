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
import 'package:sajilo_yatra/users_tickets/data/models/ticket_model_request.dart';
import 'package:sajilo_yatra/users_tickets/presentation/views/going_screen.dart';
import 'package:sajilo_yatra/users_tickets/presentation/views/leaving_screen.dart';
import 'package:sajilo_yatra/utils/bottom_bar/bottom_bar.dart';
import 'package:sajilo_yatra/utils/bottom_bar/vehicle_bottom_bar.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:sajilo_yatra/utils/form_validation/form_validation_extension.dart';
import 'package:sajilo_yatra/vehicle_owners_ticket/data/models/vehicle_owner_ticket_request_model.dart';
import 'package:sajilo_yatra/vehicle_owners_ticket/presentation/views/vehicle_owners_leaving_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:logger/logger.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

import '../../../auth/presentation/login/controllers/login_controllers/auth_state_helper.dart';
import '../../../users_tickets/presentation/controllers/ticket_controller.dart';
import '../controllers/vehicle_owner_ticket_controller.dart';
import 'vehicle_owners_going_screen.dart';

class VehicleOwnerTicketScreen extends ConsumerStatefulWidget {
  const VehicleOwnerTicketScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<VehicleOwnerTicketScreen> {
  String token = "";
  String veh = 'Bus';
  TextEditingController vehTypeController = TextEditingController();
  var vehicle = ['Bus', 'Jeep', 'MicroBus', 'Taxi', 'Others'];
  final GlobalKey<FormState> registerSignKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController location1 = TextEditingController();
  TextEditingController date2 = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController meetController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String? dob;
  final TextEditingController _timeController2 = TextEditingController();
  String? leaving;
  String? price;
  String? vehname;
  String? going;
  String? meeting;
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay _selectedTime2 = TimeOfDay.now();
  String? depart;
  String? arrive;
  String? vehicle2;
  var parsedToken = 0;
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the colors here
            primaryColor:
                AppColorConst.kappprimaryColorRed, // Header background color

            colorScheme: const ColorScheme.light(
              primary: AppColorConst
                  .kappprimaryColorRed, // Selected day background color
              onPrimary: Colors.white, // Selected day text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  Future<void> _selectTime2(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime2,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the colors here
            primaryColor:
                AppColorConst.kappprimaryColorRed, // Header background color

            colorScheme: const ColorScheme.light(
              primary: AppColorConst
                  .kappprimaryColorRed, // Selected day background color
              onPrimary: Colors.white, // Selected day text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null && pickedTime != _selectedTime2) {
      setState(() {
        _selectedTime2 = pickedTime;
        _timeController2.text = pickedTime.format(context);
      });
    }
  }

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
      leaving = prefs.getString('vehicleownerleaving') ?? "Leaving From";
      going = prefs.getString('vehicleownergoing') ?? "Going To";
      dob = prefs.getString('vehicledob') ?? "Departure Date";
      depart = prefs.getString('depart_time') ?? "Departing Time";
      arrive = prefs.getString('arrive_time') ?? "Arriving Time";

      vehTypeController.text = vehicle2 ?? "";
      location.text = leaving ?? "";
      location1.text = going ?? "";
      dobController.text = dob ?? "";
      _timeController.text = depart ?? "";
      _timeController2.text = arrive ?? "";
    });
  }

  appLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
// Remove data for the 'counter' key.
    await prefs.remove('vehicleownerleaving');
    await prefs.remove('vehicleownergoing');
    VehicleOwnerTicketRequestModel loginRequestModel =
        VehicleOwnerTicketRequestModel(
      departure: location.text,
      arrival: location1.text,
      departTime: _timeController.text,
      arrivalTime: _timeController2.text,
      meet: meetController.text,
      price: priceController.text,
      ddob: dobController.text,
    );
    if (registerSignKey.currentState!.validate()) {
      await ref
          .read(vehticketControllerProvider.notifier)
          .getvehicleTicketDetails(
              context: context, ticketRequestModel: loginRequestModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Vehicle Availability",
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
                // Obtain shared preferences.
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
// Remove data for the 'counter' key.
                await prefs.remove('vehicleownerleaving');
                await prefs.remove('vehicleownergoing');
                await prefs.remove('depart_time');
                await prefs.remove('arrive_time');
                await prefs.remove('vehicledob');

                pushAndRemoveUntil(context, const VehicleBottomBar());
              },
            );
          },
        ),
        backgroundColor: AppColorConst.kappprimaryColorRed,
      ),
      body: SingleChildScrollView(
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
                    margin: const EdgeInsets.only(top: 35),
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
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Form(
                      key: registerSignKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: AppDimensions.paddingSMALL,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: TextFormField(
                              controller: location,
                              onTap: () {
                                normalNav(
                                    context, const VehicleOwnerLeavingScreen());
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
                                hintText: leaving ?? 'Leaving From',
                                hintStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        AppColorConst.kappsecondaryColorBlack,
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
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: TextFormField(
                              controller: location1,
                              readOnly: true,
                              onTap: () {
                                normalNav(
                                    context, const VehicleOwnerGoingScreen());
                              },
                              validator: (input) =>
                                  input!.isAddressValid(input),
                              cursorColor: AppColorConst.kappscafoldbggrey,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.location_on_rounded,
                                  color: Color(0xFF222222),
                                ),
                                hintText: going ?? 'Going To',
                                hintStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        AppColorConst.kappsecondaryColorBlack,
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
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: TextFormField(
                              controller: _timeController,
                              readOnly: true,
                              onChanged: (String val) async {
                                depart = val;
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                setState(() {
                                  prefs.setString(
                                      'depart_time', depart.toString());
                                  logger.d(depart);
                                });
                              },
                              onTap: () => _selectTime(context),
                              validator: (input) =>
                                  input!.isDepartingTime(input),
                              cursorColor: AppColorConst.kappscafoldbggrey,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.access_time_filled_rounded,
                                  color: Color(0xFF222222),
                                ),
                                hintText: depart ?? 'Departing Time',
                                hintStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        AppColorConst.kappsecondaryColorBlack,
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
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: TextFormField(
                              controller: _timeController2,
                              readOnly: true,
                              onChanged: (String val) async {
                                arrive = val;
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                setState(() {
                                  prefs.setString(
                                      'arrive_time', arrive.toString());
                                  logger.d(arrive);
                                });
                              },
                              onTap: () => _selectTime2(context),
                              validator: (input) =>
                                  input!.isArrivingTime(input),
                              cursorColor: AppColorConst.kappscafoldbggrey,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.access_time_filled_rounded,
                                  color: Color(0xFF222222),
                                ),
                                hintText: arrive ?? 'Arriving Time',
                                hintStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        AppColorConst.kappsecondaryColorBlack,
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
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: TextFormField(
                              controller: meetController,
                              validator: (input) => input!.isMeetValid(input),
                              cursorColor: AppColorConst.kappscafoldbggrey,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.location_on_rounded,
                                  color: Color(0xFF222222),
                                ),
                                hintText: meeting ?? 'Meeting Location',
                                hintStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        AppColorConst.kappsecondaryColorBlack,
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
                                  hintText: dob ?? "Departure Date",
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
                                validator: (input) => input!.isDepartDOB(input),
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
                                        'vehicledob', dob.toString());
                                    dob = date.toString();
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: TextFormField(
                              controller: priceController,
                              validator: (input) => input!.isPrice(input),
                              cursorColor: AppColorConst.kappscafoldbggrey,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.currency_rupee_rounded,
                                  color: Color(0xFF222222),
                                ),
                                hintText: price ?? 'Enter Price',
                                hintStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        AppColorConst.kappsecondaryColorBlack,
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
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 512),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: ContinuousRectangleBorder(
                                side: const BorderSide(
                                  width: 0.8,
                                  color: AppColorConst.kappprimaryColorRed,
                                ),
                                borderRadius: BorderRadius.circular(22)),
                            backgroundColor: AppColorConst.kappprimaryColorRed,
                            elevation: 0,
                            fixedSize: Size(33.w, 6.h)),
                        onPressed: () => appLogin(),
                        child: const Text(
                          "Post",
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
              height: 25,
            ),
            ClipPath(
              clipper: CurvedBottomClipper2(),
              child: Container(
                height: 18.h,
                color: AppColorConst.kappprimaryColorRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
