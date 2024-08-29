// ignore_for_file: avoid_print


import 'package:chopnow/common/size.dart';
import 'package:chopnow/models/api_error.dart';
import 'package:chopnow/models/hooks_model/hook_result.dart';
import 'package:chopnow/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchPopularRestaurants() {
  final restaurants = useState<List<RestaurantModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      final url = Uri.parse("$appBaseUrl/api/restaurant/popular");

      final response = await http.get(url);
      print("useFetchPopularRestairants : ${response.statusCode}");
      

      if (response.statusCode == 200) {
        restaurants.value = restaurantModelFromJson(response.body);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      error.value = e as Exception;
      // error.value = e;  // Correctly set the error state
      debugPrint('Error occurred: $e');  // Print the correct error
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: restaurants.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
