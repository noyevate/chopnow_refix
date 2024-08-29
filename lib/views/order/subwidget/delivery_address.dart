import 'dart:convert';

import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/common/size.dart';
import 'package:chopnow/controllers/address_controller.dart';
import 'package:chopnow/hooks/fetch_address.dart';
import 'package:chopnow/models/address_model.dart';
import 'package:chopnow/models/address_response_model.dart';
import 'package:chopnow/views/auth/widget/field_widget.dart';
import 'package:chopnow/views/profile/widget/addresslist_widget.dart';
import 'package:chopnow/views/shimmer/food_tile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:http/http.dart' as http;

class DeliverAddress extends StatefulHookWidget {
  const DeliverAddress({
    super.key,
    this.refetch,
  });

  @override
  State<DeliverAddress> createState() => _DeliverAddressState();

  final Function()? refetch;
}

class _DeliverAddressState extends State<DeliverAddress> {
  final TextEditingController _searchController = TextEditingController();

  List<dynamic> _placeList = [];

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
      setState(() {
        _placeList = [];
      });
    }
  }

  Future _getPlaceDetails(String placeId) async {
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

      if (mounted) {
        setState(() {
          address = addressLine;
          postalCode = postal_code.isNotEmpty ? postal_code : 'N/A';
          latitude = lat;
          longitude = lng;
        });
      }

      print(address);
      print("postal code: $postalCode");
      print("lat: $lat");
      print("lng: $lng");
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final addressController = Get.put(AddressController());

    final hookResult = useFetchAllAddress();

    final List<AddressResponseModel> addresses = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;
    final refetch = hookResult.refetch;
    bool isSearching = _searchController.text.isNotEmpty;

    return PopScope(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(250.h),
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReuseableText(
                      title: "Delivery address",
                      style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w700,
                          color: Tcolor.Text),
                    ),
                    Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: Tcolor.BACKGROUND_Dark,
                        borderRadius: BorderRadius.circular(60.r),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                HeroiconsOutline.xMark,
                                color: Tcolor.Text,
                                size: 32.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
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
              ],
            ),
          ),
        ),
        body: Container(
          color: Tcolor.White,
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
          child: isSearching
              ? _placeList.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      itemCount: _placeList.length,
                      itemBuilder: (context, index) {
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
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
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
                            onTap: () async {
                              await _getPlaceDetails(
                                  _placeList[index]["place_id"]);

                              var model = AddressModel(
                                  addressLine1: address,
                                  postalCode: postalCode.isNotEmpty
                                      ? postalCode
                                      : 'N/A',
                                  addressModelDefault: true,
                                  deliveryInstructions: "",
                                  latitude: latitude,
                                  longitude: longitude);
                              box.write(
                                  "latitude", latitude);
                              box.write(
                                  "longitude", longitude);

                              print("your posta_code: ${model.postalCode}");

                              String data = addressModelToJson(model);
                              print("Sending Data: $data");
                              // Update the selected address in the controller
                              addressController.updateSelectedAddress(address);
                              addressController.addAddressProfile(
                                  data, refetch!, context);
                            },
                          ),
                        );
                      },
                    )
              : isLoading
                  ? const ShimmerFoodTile()
                  : AddressListWidget(
                      addresses: addresses,
                      refetch: refetch,
                    ),
        ),
      ),
    );
  }
}
