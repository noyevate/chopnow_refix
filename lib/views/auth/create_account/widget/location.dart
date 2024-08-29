// ignore_for_file: non_constant_identifier_names, prefer_final_fields, annotate_overrides

import 'dart:convert';

import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/common/size.dart';
import 'package:chopnow/controllers/address_controller.dart';
import 'package:chopnow/controllers/user_location_controller.dart';
import 'package:chopnow/enty_point.dart';
import 'package:chopnow/models/address_model.dart';
import 'package:chopnow/views/auth/widget/field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:http/http.dart' as http;

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  void initState() {
    super.initState();
    _determinePosition();
  }
  
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _placeList = [];
  List<dynamic> _selectedPlace = [];

  var address = "";
  var postalCode = "";
  var latitude = 0.0;
  var longitude = 0.0;

  _onSeachedChanged(String searchQuery) async {
    if (searchQuery.isNotEmpty) {
      final url = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchQuery&key=$googleApiKey");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      }
    } else {
      _placeList = [];
    }
  }

  void _getPlaceDetails(String placeId) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final location = json.decode(response.body);
      final lat = location['result']['geometry']['location']['lat'] as double;
      final lng = location['result']['geometry']['location']['lng'] as double;
      final addressLine = location['result']['formatted_address'];

      String postal_code = '';
      final addressComponents = location['result']['address_components'];
      for (var component in addressComponents) {
        if (component['types'].contains('postal_code')) {
          postal_code = component['long_name'];
          break;
        }
      }

      setState(() {
        address = addressLine;
        postalCode = postal_code;
        latitude = lat;
        longitude = lng;
      });

      print(address);
      print("postal code: $postalCode");
      print("lat: $lat");
      print("lng: $lng");

    
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserLocationController());
    final addressController = Get.put(AddressController());

    return Scaffold(
      backgroundColor: Tcolor.White,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReuseableText(
                  title: "Delivery address",
                  style: TextStyle(
                      color: Tcolor.Text,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w700,
                      wordSpacing: 2.sp),
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAll(() => const MainScreen(),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 700));
                  },
                  child: IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(
                      "assets/img/cancle.svg",
                    ),
                  ),
                )
              ],
            ),
            FieldWidget(
              prefixIcon: const Icon(Icons.search),
              hintText: "Enter your address",
              hintColor: Tcolor.TEXT_Placeholder,
              hintFontSize: 30.sp,
              hintFontWeight: FontWeight.w600,
              cursorHeight: 30.sp,
              cursorColor: Tcolor.Primary,
              controller: _searchController,
              onChanged: _onSeachedChanged,
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () async {
                print("Current address is: ${controller.address}");
                print("Latitude: ${controller.position.latitude}");
                print("Longitude: ${controller.position.longitude}");
                print("postal code: ${controller.postalCode}");
              },
              child: FieldWidget(
                prefixIcon: IconButton(
                  onPressed: () {
                    // var model = AddressModel(
                    //     addressLine1: controller.address,
                    //     postalCode: postalCode,
                    //     addressModelDefault: true,
                    //     deliveryInstructions: "",
                    //     latitude: latitude,
                    //     longitude: longitude);
                    // String data = addressModelToJson(model);
                    // addressController.addAddress(data);
                  },
                  icon: SvgPicture.asset(
                    "assets/img/paper_airplane_up.svg",
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
                hintText: "Use my current location",
                hintColor: Tcolor.Text,
                hintFontSize: 30.sp,
                hintFontWeight: FontWeight.w400,
                cursorHeight: 30.sp,
                cursorColor: Tcolor.Primary,
                fillColor: Tcolor.PRIMARY_T5,
                enabled: false,
              ),
            ),
            // SizedBox(
            //   height: 20.h,
            // ),
            _placeList.isEmpty
                ? const SizedBox.shrink()
                : Expanded(
                    child: ListView(
                      children: List.generate(_placeList.length, (index) {
                        return Container(
                          color: Tcolor.White,
                          child: ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Row(
                              children: [
                                Icon(
                                  HeroiconsOutline.mapPin,
                                  size: 40.sp,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: width / 1.5,
                                  child: ReuseableText(
                                    title: _placeList[index]['description'],
                                    style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Tcolor.Text,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              _getPlaceDetails(_placeList[index]["place_id"]);
                              _selectedPlace.add(_placeList[index]);

                              var model = AddressModel(
                                  addressLine1: address,
                                  postalCode: postalCode,
                                  addressModelDefault: true,
                                  deliveryInstructions: "",
                                  latitude: latitude,
                                  longitude: longitude);

                              print("your posta_code: ${model.postalCode}");

                              String data = addressModelToJson(model);
                              addressController.addAddress(data);
                            },
                          ),
                        );
                      }),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final controller = Get.put(UserLocationController());
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    LatLng currentLocation = LatLng(position.latitude, position.longitude);
    controller.setPosition(currentLocation);
    controller.getUserAddress(currentLocation);
    
    

  }
}
