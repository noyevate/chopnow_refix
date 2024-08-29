
import 'package:chopnow/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  final FoodModel food;
  var count = 1.obs;
  var packCount = 1.obs;
  var additiveCounts = <String, int>{}.obs;
  var isChecked = <String, bool>{}.obs;
  var selectedItems = <SelectedItem>[].obs; // List to store selected items

  FoodController(this.food);

  @override
  void onInit() {
    super.onInit();
    initializeAdditiveCounts();
  }

  void initializeAdditiveCounts() {
    for (var additive in food.additive) {
      for (var option in additive.options) {
        additiveCounts["${additive.title}-${option.name}"] = 1;
        isChecked["${additive.title}-${option.name}"] = false;
      }
    }
  }

  void increment() {
    count++;
    updateTotalPrice();
    updateSelectedItems(); // Update selected items list
  }

  void decrement() {
    if (count > 1) {
      count--;
      updateTotalPrice();
      updateSelectedItems(); // Update selected items list
    }
  }

  void packIncrement() {
    packCount++;
    updateTotalPrice();
    updateSelectedItems(); // Update selected items list
  }

  void packDecrement() {
    if (packCount > 1) {
      packCount--;
      updateTotalPrice();
      updateSelectedItems(); // Update selected items list
    }
  }

  void incrementOption(String key) {
    additiveCounts[key] = (additiveCounts[key] ?? 1) + 1;
    updateTotalPrice();
    updateSelectedItems(); // Update selected items list
  }

  void decrementOption(String key) {
    if (additiveCounts[key]! > 1) {
      additiveCounts[key] = additiveCounts[key]! - 1;
      updateTotalPrice();
      updateSelectedItems(); // Update selected items list
    }
  }

  int getOptionCount(String key) {
    return additiveCounts[key] ?? 1;
  }

  void toggleCheckbox(String key, bool? value) {
    // Check if the key is part of the first additive group
    if (key.startsWith("${food.additive.first.title}-")) {
      // Uncheck all other checkboxes in the same group
      isChecked.updateAll((k, v) {
        if (k.startsWith("${food.additive.first.title}-")) {
          return k == key ? (value ?? false) : false;
        }
        return v;
      });
    } else {
      // For other groups, just update the checkbox state
      isChecked[key] = value ?? false;
    }

    // Update the additive counts and total price if the checkbox is unchecked
    if (!isChecked[key]!) {
      additiveCounts[key] = 1; // Reset the count if unchecked
    }

    updateTotalPrice();
    updateSelectedItems(); // Update the selected items list
  }

  int getOptionTotalPrice(String key) {
    for (var additive in food.additive) {
      for (var option in additive.options) {
        if ("${additive.title}-${option.name}" == key) {
          return (additiveCounts[key] ?? 0) * option.price;
        }
      }
    }
    return 0;
  }

  int get totalPrice {
    var total = food.price * count.value;
    for (var key in additiveCounts.keys) {
      if (isChecked[key]!) {
        total += getOptionTotalPrice(key);
      }
    }
    return  total;
  }

  void updateTotalPrice() {
    // Trigger a reactive update
    totalPrice;
  }

  void updateSelectedItems() {
    selectedItems.clear();
    for (var key in additiveCounts.keys) {
      if (isChecked[key]!) {
        for (var additive in food.additive) {
          for (var option in additive.options) {
            if ("${additive.title}-${option.name}" == key) {
              selectedItems.add(SelectedItem(
                foodTitle: food.title, // Include food title
                foodPrice: food.price * count.value, // Include total price
                foodCount: count.value,
                name: option.name,
                price: option.price,
                quantity: additiveCounts[key]!,
                packCount: packCount.value
              ));
            }
          }
        }
      }
    }
  }


  

  bool isAnyOptionChecked() {
    return isChecked.values.any((value) => value);
  }

  void checkSelectionAndShowSnackbar() {
    // Check if any option in the first additive is selected
    bool isAnyOptionSelected = isChecked.entries
        .where((entry) => entry.key.startsWith("${food.additive.first.title}-"))
        .any((entry) => entry.value);

    if (!isAnyOptionSelected) {
      // Show Snackbar if no option is selected in the first index
      Get.snackbar(
        'Selection Error',
        'Please select at least one option packages to package your food.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void resetSelections() {
    for (var key in isChecked.keys) {
      isChecked[key] = false;
    }
    for (var key in additiveCounts.keys) {
      additiveCounts[key] = 1;
    }
    selectedItems.clear();
    count.value = 1;
    updateTotalPrice();
  }
  
  
}


class SelectedItem {
  final String foodTitle; // New field
  final int foodPrice;
  final int foodCount;
  final String name;
  final int price;
  final int quantity;
  final int packCount;


  SelectedItem( {
    required this.foodTitle, // New field
    required this.foodPrice, // New field
    required this.foodCount,
    required this.name,
    required this.price,
    required this.quantity,
    required this.packCount
  });

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'foodTitle': foodTitle,
      'foodPrice': foodPrice,
      'foodCount': foodCount,
      'name': name,
      'price': price,
      'quantity': quantity,
      'packCount': packCount
    };
  }
}


