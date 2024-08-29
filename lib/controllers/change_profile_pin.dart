
import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/views/profile/widget/confim_profile_pin.dart';
import 'package:chopnow/views/profile/widget/profile_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChangeProfilePin extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool newState) {
    _isLoading.value = newState;
  }

  var pin1 = ''.obs;
  var pin2 = ''.obs;
  var pin = ''.obs;

  void handleKeyPress(String value, BuildContext context) {
    if (pin.value.length < 4) {
      pin.value += value;
      if (pin.value.length == 4) {
        submitPin(context); // Pass context to submitPin1
      }
    }
  }

  void handleKeyPress1(String value, BuildContext context) {
    if (pin1.value.length < 4) {
      pin1.value += value;
      if (pin1.value.length == 4) {
        submitPin1(context); // Pass context to submitPin1
      }
    }
  }

  void handleKeyPress2(String value) {
    if (pin2.value.length < 4) {
      pin2.value += value;
      if (pin1.value.length == 4) {
        submitPin2();
      }
    }
  }

  void clearPin() {
    pin.value = '';
  }

  void clearPin1() {
    pin1.value = '';
  }

  void clearPin2() {
    pin2.value = '';
  }

  void submitPin(BuildContext context) async {
    if (pin.value.length == 4) {
      showModalBottomSheet(
        backgroundColor: Tcolor.White,
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        ), 
        builder: (BuildContext context) => const EditProfilePin(),
      );
    }
  }

  void submitPin1(BuildContext context) async {
    if (pin1.value.length == 4) {
      showModalBottomSheet(
        backgroundColor: Tcolor.White,
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        ), 
        builder: (BuildContext context) => const ConfirmProfilePage(),
      );
    }
  }

  void submitPin2() async {
    // Handle PIN 2 submission logic here
  }
}
