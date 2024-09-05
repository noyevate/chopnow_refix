import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/custom_circular_checkbox.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/common/row_icon.dart';
import 'package:chopnow/controllers/cart_controller.dart';
import 'package:chopnow/controllers/food_controller.dart';
import 'package:chopnow/models/cart_request.dart';
import 'package:chopnow/models/food_model.dart';
import 'package:chopnow/views/order/widget/checkout_page.dart';

import 'package:chopnow/models/cart_request.dart'
    as cart;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key, this.food});

  final FoodModel? food;

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final Map<String, bool> _isChecked = {};

  get food => null;

  @override
  void initState() {
    super.initState();
    // Initialize the checked state map with default values
    widget.food?.additive.forEach((additive) {
      additive.options.forEach((option) {
        _isChecked[option.name] = false; // Default to false
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController(widget.food!));
    final cartController = Get.put(CartController());
    // print(controller.totalPrice);
    // print(controller.isChecked.values);

    return Scaffold(
      backgroundColor: const Color.fromARGB(31, 246, 243, 243),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.r),
            topRight: Radius.circular(60.r),
          ),
          color: Tcolor.White,
        ),
        child: Column(
          children: [
            // Image section
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60.r),
                topRight: Radius.circular(60.r),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: 400.h,
                    width: double.infinity,
                    child: PageView.builder(
                      itemCount: widget.food!.imageUrl.length,
                      itemBuilder: (context, i) {
                        return Container(
                          color: Tcolor.White,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.food!.imageUrl[i],
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.h, right: 30.w),
                      child: GestureDetector(
                        onTap: () {
                          controller.resetSelections();
                          Get.back();
                        },
                        child: Container(
                            height: 70.h,
                            width: 70.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                color: Tcolor.BACKGROUND_Dark),
                            child: Icon(HeroiconsOutline.xMark,
                                color: Tcolor.Text, size: 24.sp)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            // Scrollable section
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReuseableText(
                        title: widget.food!.title,
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontWeight: FontWeight.w500,
                          fontSize: 36.sp,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      ReuseableText(
                        title: "NGN ${widget.food!.price.toString()}",
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontWeight: FontWeight.w400,
                          fontSize: 28.sp,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      ReuseableText(
                        title: widget.food!.description,
                        style: TextStyle(
                          color: Tcolor.TEXT_Label,
                          fontWeight: FontWeight.w400,
                          fontSize: 28.sp,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Divider(
                        thickness: 2.w,
                        color: Tcolor.BORDER_Light,
                      ),
                      SizedBox(height: 10.h),
                      ReuseableText(
                        title: "MAIN",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                          color: Tcolor.TEXT_Label,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReuseableText(
                            title: "Required",
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                              color: Tcolor.ERROR_Reg,
                            ),
                          ),
                          ReuseableText(
                            title: "Add up to 5",
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                              color: Tcolor.TEXT_Label,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    RowIcon(
      title: widget.food!.title,
      style: TextStyle(
        fontSize: 34.sp,
        fontWeight: FontWeight.w400,
        color: Tcolor.Text,
      ),
    ),
    
    SizedBox(
      width: 300.w, // Adjust to fit all controls
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              controller.decrement();
            },
            child: Icon(
              AntDesign.minuscircleo,
              size: 36.sp,
              color: Tcolor.TEXT_Placeholder,
            ),
          ),
          SizedBox(
            width: 60.w, // Fixed width for the count display area
            child: Center(
              child: Obx(
                () => ReuseableText(
                  title: "${controller.count.value}",
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w400,
                    color: Tcolor.TEXT_Body,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.increment();
            },
            child: Icon(
              AntDesign.pluscircleo,
              size: 36.sp,
              color: Tcolor.TEXT_Body,
            ),
          ),
          Spacer(), // This keeps the price aligned to the right
          Obx(
            () => ReuseableText(
              title: "NGN ${widget.food!.price * controller.count.value}",
              style: TextStyle(
                color: Tcolor.TEXT_Label,
                fontWeight: FontWeight.w400,
                fontSize: 28.sp,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    ),
  ],
),


                      SizedBox(height: 25.h),
                      Divider(
                        thickness: 2.w,
                        color: Tcolor.BORDER_Light,
                      ),
                      // SizedBox(height: 10.h),
                      Column(
                        children: List.generate(
                          widget.food!.additive.length,
                          (index) {
                            final additive = widget.food!.additive[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: 25.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReuseableText(
                                      title: additive.title.toUpperCase(),
                                      style: TextStyle(
                                        color: Tcolor.TEXT_Label,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 28.sp,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (index == 0)
                                          ReuseableText(
                                            title: "Required",
                                            style: TextStyle(
                                              color: Tcolor.ERROR_Reg,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 24.sp,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        if (index != 0)
                                          ReuseableText(
                                            title: "Optional",
                                            style: TextStyle(
                                              color: Tcolor.TEXT_Label,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 24.sp,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        if (index == 0)
                                          ReuseableText(
                                            title: "choose a package",
                                            style: TextStyle(
                                              color: Tcolor.TEXT_Label,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 28.sp,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        if (index != 0)
                                          ReuseableText(
                                            title:
                                                "Choose at least 1 and add up to 5",
                                            style: TextStyle(
                                              color: Tcolor.TEXT_Label,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 28.sp,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
                                  child: Column(
                                    children: List.generate(
                                      additive.options.length,
                                      (optionIndex) {
                                        final option =
                                            additive.options[optionIndex];
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.h, bottom: 10.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CustomCircularCheckbox(
                                                          value: controller
                                                                      .isChecked[
                                                                  "${additive.title}-${option.name}"] ??
                                                              false,
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              _isChecked[option
                                                                      .name] =
                                                                  value ??
                                                                      false;
                                                            });
                                                            controller
                                                                .toggleCheckbox(
                                                                    "${additive.title}-${option.name}",
                                                                    value);
                                                          }),
                                                      SizedBox(width: 10.w),
                                                      SizedBox(
                                                        width: 200.w,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.w,
                                                                  right: 10.w),
                                                          child: ReuseableText(
                                                            title: option.name,
                                                            style: TextStyle(
                                                              color: Tcolor
                                                                  .TEXT_Label,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 28.sp,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  if (index !=
                                                      0) // Hide increment and decrement options for the first object
                                                    SizedBox(
                                                      width: 300.w,
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: _isChecked[option
                                                                        .name] ==
                                                                    true
                                                                ? () {
                                                                    controller
                                                                        .decrementOption(
                                                                            "${additive.title}-${option.name}");
                                                                  }
                                                                : null,
                                                            child: Icon(
                                                              AntDesign
                                                                  .minuscircleo,
                                                              size: 36.sp,
                                                              color: _isChecked[option
                                                                          .name] ==
                                                                      true
                                                                  ? Tcolor
                                                                      .TEXT_Placeholder
                                                                  : Tcolor.TEXT_Placeholder
                                                                      .withOpacity(
                                                                          0.5),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 60.w,
                                                            child: Center(
                                                              child: Obx(
                                                                () => ReuseableText(
                                                                  title:
                                                                      "${controller.getOptionCount("${additive.title}-${option.name}")}",
                                                                  style: TextStyle(
                                                                    fontSize: 30.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Tcolor
                                                                        .TEXT_Body,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: _isChecked[option
                                                                        .name] ==
                                                                    true
                                                                ? () {
                                                                    controller
                                                                        .incrementOption(
                                                                            "${additive.title}-${option.name}");
                                                                  }
                                                                : null,
                                                            child: Icon(
                                                              AntDesign
                                                                  .pluscircleo,
                                                              size: 36.sp,
                                                              color: _isChecked[option
                                                                          .name] ==
                                                                      true
                                                                  ? Tcolor
                                                                      .TEXT_Body
                                                                  : Tcolor.TEXT_Placeholder
                                                                      .withOpacity(
                                                                          0.5),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          if (index != 0)
                                                    _isChecked[option
                                                                .name] ==
                                                            true
                                                        ? Obx(
                                                            () =>
                                                                ReuseableText(
                                                              title:
                                                                  "NGN ${controller.getOptionTotalPrice("${additive.title}-${option.name}")}",
                                                              style:
                                                                  TextStyle(
                                                                color: Tcolor
                                                                    .TEXT_Label,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    28.sp,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                              ),
                                                            ),
                                                          )
                                                        : ReuseableText(
                                                            title:
                                                                "NGN ${option.price}",
                                                            style: TextStyle(
                                                              color: Tcolor
                                                                  .TEXT_Label,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 28.sp,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                            ),
                                                          ),
                                                  // if(index == 0)
                                                  
                                                        ],
                                                      ),
                                                    ),
                                                    if (index == 0)
                                                    ReuseableText(
                                                      title:
                                                          "NGN ${option.price.toString()}",
                                                      style: TextStyle(
                                                        fontSize: 28.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Tcolor.TEXT_Label,
                                                      ),
                                                    ),
                                                  
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Divider(
                                  thickness: 2.w,
                                  color: Tcolor.BORDER_Light,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
              decoration: BoxDecoration(
                color: Tcolor.White,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      var cartRequest = cart.CartRequest(
                        productId: widget.food!.id,
                        totalPrice: controller.totalPrice.toInt(),
                        additives: controller.selectedItems
                            .map(
                              (item) => cart.Additive(
                                  foodTitle:
                                      controller.selectedItems[0].foodTitle,
                                  foodPrice:
                                      controller.selectedItems[0].foodPrice,
                                  foodCount:
                                      controller.selectedItems[0].foodCount,
                                  name: item.name,
                                  price: item.price,
                                  quantity: item.quantity,
                                  packCount: item.packCount),
                            )
                            .toList(),
                            
                      );
                      // Print for debugging
                      print("cart tp:${cartRequest.totalPrice}, ${controller.totalPrice}");


                      String cartRequest1 = cart.cartRequestToJson(cartRequest);
                      print("cart request sent to the backend: ${cartRequest1}");

                      cartController.addToCart(cartRequest1);

                      controller.checkSelectionAndShowSnackbar();
                      if (controller.isAnyOptionChecked()) {
                        Get.to(
                          () => CheckoutPage(
                            food: controller.food,
                            selectedItems: controller.selectedItems,
                          ),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 500),
                          arguments: controller.selectedItems,
                        );
                      } else {}
                    },
                    child: Container(
                      height: 90.h,
                      width: 400.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          gradient: Tcolor.Primary_button,
                          boxShadow: [
                            BoxShadow(
                                color: Tcolor.PRIMARY_Button_Inner_Shadow,
                                offset: const Offset(0, -1),
                                blurRadius: 1.r,
                                spreadRadius: 0)
                          ]),
                      child: Center(
                        child: Obx(
                          () => ReuseableText(
                            title:
                                "NGN ${controller.totalPrice} | Add to cart ",
                            style: TextStyle(
                              color: Tcolor.Text,
                              fontWeight: FontWeight.w500,
                              fontSize: 28.sp,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
