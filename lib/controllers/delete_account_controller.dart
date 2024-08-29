
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DeleteAccountController extends GetxController {
  final box = GetStorage();

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  set setLoading(bool value) {
    _isLoading.value = value;
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

  Future<void> submitPin() async {
    if (pin.value.length == 4) {
      // PIN is complete, handle the submission
      print("Submitted PIN: ${pin.value}");
      // Get.offAll(() => const Location(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 700));

      // Perform your submission logic here, e.g., API call or navigation
    }
  }
}
