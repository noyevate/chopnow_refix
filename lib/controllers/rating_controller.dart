// ignore_for_file: use_build_context_synchronously

import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/size.dart';
import 'package:chopnow/models/api_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RatingController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;
  final RxBool showRatingSubmitted = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value) {
    _isLoading.value = value;
  }

  void addRating(String data, BuildContext context) async {
    setLoading = true;
    String accessToken = box.read("token");

    var url = Uri.parse("$appBaseUrl/api/rating");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 201) {
        setLoading = false;
        Get.snackbar(
          "Rating submitted Successfully",
          "Bon appétit! Get ready to savor tasty treats with us.",
          colorText: Tcolor.Text,
          duration: const Duration(seconds: 2),
          backgroundColor: Tcolor.Primary_New,
          icon: const Icon(Ionicons.fast_food_outline),
        );

        showRatingSubmitted.value = true;
        Navigator.of(context).pop();
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar("Process Unsuccessful", error.message,
            colorText: Tcolor.White,
            duration: const Duration(seconds: 2),
            backgroundColor: Tcolor.ERROR_Reg,
            icon: const Icon(Icons.error_outline));
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
    }
  }
}
