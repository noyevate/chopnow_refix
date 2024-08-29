
import 'dart:convert';


import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/size.dart';
import 'package:chopnow/models/api_error.dart';
import 'package:chopnow/models/order_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController{
  final box = GetStorage();
  // ignore: prefer_final_fields
  RxBool _isLoading = false.obs;

  bool get isLoading =>_isLoading.value;

  set setLoading(bool value) {
    _isLoading.value = value;
  }


   Future<void> addToOrder(String data, OrderRequest item ) async{
    setLoading = true;
    String accessToken = box.read("token");

    var url = Uri.parse("$appBaseUrl/api/order");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 201) {
        setLoading = false;
        Get.snackbar("Order Created Successfully",
            "Bon appétit! Get ready to savor tasty treats with us.",
            colorText: Tcolor.Text,
            duration: const Duration(seconds: 2),
            backgroundColor: Tcolor.Primary,
            icon: const Icon(Ionicons.fast_food_outline));

          // Get.to(() => const PaymentPage());
          
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar("Creating Order Unsuccessful", error.message,
            colorText: Tcolor.White,
            duration: const Duration(seconds: 3),
            
            backgroundColor: Tcolor.ERROR_Light_1,
            icon: const Icon(Icons.error_outline));
            print(error.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
      
    }
  }

  Future<String?> makePayment({
    required String amount,
    required String currency,
    required String email,
  }) async {
    const String url =
        'https://flutterwave-test-production-d203.up.railway.app/payment';
    final Map<String, dynamic> body = {
      'amount': amount,
      'currency': currency,
      'email': email,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        final responseData = jsonDecode(response.body);
        final paymentLink = responseData['data']
            ['link']; // Adjust this according to your response structure

        return paymentLink;
        // Get.to(() => PaymentWebViewPage(paymentLink: paymentLink));
        // Redirect user to payment link
        //  if (await canLaunchUrl(Uri.parse(paymentLink))) {
        //   await launchUrl(Uri.parse(paymentLink));
      } else {
        // Handle errors
        Get.snackbar(
            'Error', 'Payment failed with status: ${response.statusCode}');
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      // Handle exceptions
      Get.snackbar('Error', 'An error occurred: $e');
      print("   catch error: ${e.toString()}");
    }
    return null;
  }
}