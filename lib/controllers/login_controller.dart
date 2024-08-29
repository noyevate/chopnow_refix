
import 'dart:convert';
import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/size.dart';
import 'package:chopnow/enty_point.dart';
import 'package:chopnow/models/api_error.dart';
import 'package:chopnow/models/login_response_model.dart';
import 'package:chopnow/views/auth/login/login_page_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  
   set setLoading(bool newState) {
    _isLoading.value = newState;
  }
  // Text Controllers


  
  final TextEditingController phoneNumberController = TextEditingController();
  

  // Observables
  var isFormFilled = false.obs;

  // Dispose controllers
  @override
  void onClose() {
    
    phoneNumberController.dispose();
    
    super.onClose();
  }

  // Validate form
  void validateForm() {
    if (
        phoneNumberController.text.isNotEmpty
        ) {
      isFormFilled.value = true;
    } else {
      isFormFilled.value = false;
    }
  }

  var pin = ''.obs;

  void handleKeyPress(String value) {
    if (pin.value.length < 4) {
      pin.value += value;
      if (pin.value.length == 4) {
        submitPin(); // Automatically submit when 4 digits are entered
      }
    }
  }

  void clearPin() {
    pin.value = '';
  }

  void submitPin() async {
    if (pin.value.length == 4) {
      // PIN is complete, handle the submission
      var phone = phoneNumberController.text;
      // print("Submitted PIN: ${pin.value}/ phoneNumber: $phone");
            // Get.offAll(() => NextScreen(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 700));
      
      setLoading = true;

      Uri url = Uri.parse("$appBaseUrl/login/$phone/${pin.value}");

      Map<String, String> headers = {'Content-Type': 'application/json'};

      try {
        var response = await http.post(url, headers: headers,);
        print(response.body);
        if (response.statusCode == 200) {
          LoginResponsModel data = loginResponsModelFromJson(response.body);
          
          String userId = data.id;
          String userData = jsonEncode(data);

          box.write(userId, userData);
          box.write("token", data.token);
          box.write("userId", data.id);
          box.write("verification", data.phoneVerification);
          box.write("first_name", data.firstName);
          box.write("last_name", data.lastName);
          box.write("phone", data.phone);
          box.write("email", data.email);
          setLoading = false;
          
          Get.offAll(() => const MainScreen(), transition: Transition.fadeIn, duration:  const Duration(milliseconds: 700));
        } else {
          
          var error = apiErrorFromJson(response.body);
          
          
          Get.defaultDialog(
            backgroundColor: Tcolor.White,
            title: "Login Failed",
            titleStyle: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
                color: Tcolor.TEXT_Placeholder),
            middleText: error.message,
            middleTextStyle: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: Tcolor.TEXT_Label),
            textConfirm: "OK",
            onConfirm: () {
              Get.back();
            },
            barrierDismissible: false,
            confirmTextColor: Tcolor.Text,
            buttonColor: Tcolor.TEXT_Label,
          );
          clearPin();
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void logout() {
    box.erase();
    
    Get.offAll(() => const LoginPageView());
  }


  LoginResponsModel? getUserInfo()
  {
    String? userId = box.read('userId');
    String? data;
    if (userId != null) {
      data = box.read(userId.toString());
    }

    if (data != null) {
      return loginResponsModelFromJson(data);
    }
    return null;
  }
}
