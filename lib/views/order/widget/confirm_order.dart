import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/custom_button.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/common/size.dart';
import 'package:chopnow/controllers/checkout_controller.dart';
import 'package:chopnow/controllers/food_controller.dart';
import 'package:chopnow/controllers/order_controller.dart';
import 'package:chopnow/models/distance_time.dart';
import 'package:chopnow/models/food_model.dart';
import 'package:chopnow/models/order_request.dart';
import 'package:chopnow/models/single_restaurant_model.dart';
import 'package:chopnow/services/distance.dart';
import 'package:chopnow/views/order/subwidget/paymebt_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import '../subwidget/order_summary_widget.dart';

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({
    super.key,
    required this.foodTitle,
    required this.foodCount,
    required this.foodprice,
    required this.selectedItems,
    this.food,
    required this.totalPrice,
    required this.restaurant,
    required this.item,
  });

  final String foodTitle;
  final int foodCount;
  final int foodprice;
  final List<SelectedItem> selectedItems;
  final FoodModel? food;
  final int totalPrice;
  final SingleRestaurantModel? restaurant;
  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    // final PaymentController paymentController = Get.put(PaymentController());
    final box = GetStorage();
    final email = box.read("email");
    final userId = box.read("userId");
    final longitude = box.read("longitude");
    final latitude = box.read("latitude");
    final firstName = box.read("first_name");
    final phone = box.read("phone");

    // var latitude = 8.9668961;
    // var longitude = 4.3874051;

    final distanceCalculator = Distance();
    // LoginResponseModel? user;

    // Dummy values for speed and price per km
    double speedKmPerHr = 30.0;
    double pricePerKm = 350.0;
    String paymentMethod = "Card";
    // final controller = Get.put(OrderController());

    DistanceTime? distanceTime;
    if (restaurant != null) {
      distanceTime = distanceCalculator.calculateDistanceTimePrice(
          restaurant!.coords.latitude,
          restaurant!.coords.longitude,
          latitude,
          longitude,
          speedKmPerHr,
          pricePerKm);
    }
    int estimatedDeliveryFee = distanceTime!.price.round();

    final CheckoutController controller = Get.put(CheckoutController());
    final orderController = Get.put(OrderController());
    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.h),
        child: Container(
          color: Tcolor.White,
        ),
      ),
      body: Container(
        height: height,
        width: width,
        color: Tcolor.BACKGROUND_Regaular,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100.h,
              color: Tcolor.White,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: Tcolor.BACKGROUND_Dark,
                        borderRadius: BorderRadius.circular(60.r),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            HeroiconsOutline.arrowLeft,
                            color: Tcolor.Text,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: ReuseableText(
                      title: "Confirm order",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 36.sp,
                        color: Tcolor.Text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  ReuseableText(
                    title: "Order summary",
                    style: TextStyle(
                        fontSize: 28.sp,
                        color: Tcolor.Text,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
            Container(
              height: 320.h,
              width: width,
              color: Tcolor.White,
              child: Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    OrderSummaryWidget(
                      title: 'Subtotal (${selectedItems.length + 1} items)',
                      price: '$totalPrice',
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    OrderSummaryWidget(
                        title: "Service fee",
                        price: "${(totalPrice * 0.12).round()}"),
                    SizedBox(
                      height: 40.h,
                    ),
                    OrderSummaryWidget(
                        title: "Delivery fee",
                        price: "${estimatedDeliveryFee}"),
                    SizedBox(
                      height: 40.h,
                    ),
                    OrderSummaryWidget(
                        color: Tcolor.Text,
                        title: "Total",
                        price:
                            "${estimatedDeliveryFee + totalPrice + (totalPrice * 0.12).round()}"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: ReuseableText(
                title: "Payment methods",
                style: TextStyle(
                    color: Tcolor.Text,
                    fontWeight: FontWeight.w500,
                    fontSize: 28.sp),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              height: 200.h,
              width: width,
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              color: Tcolor.White,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            HeroiconsOutline.globeAlt,
                            size: 40.sp,
                            color: Tcolor.Text,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          ReuseableText(
                            title: "Pay online",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 28.sp,
                                color: Tcolor.Text),
                          )
                        ],
                      ),
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Tcolor.TEXT_Label),
                            borderRadius: BorderRadius.circular(50.r)),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
              color: Tcolor.White,
              height: 140.h,
              width: width,
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    onTap: () async {
                      print(item.additives);

                      final grandTotal = estimatedDeliveryFee +
                          totalPrice +
                          ((totalPrice * 0.12).round());

                      OrderRequest order = OrderRequest(
                        userId: userId,
                        orderItems: [item],
                        orderTotal: totalPrice,
                        deliveryFee: estimatedDeliveryFee,
                        grandTotal: grandTotal,
                        deliveryAddress: "667e27ffce593ee0ff41da6b",
                        restaurantAddress: restaurant!.coords.address,
                        paymentMethod: paymentMethod,
                        paymentStatus: "Completed",
                        orderStatus: "Placed",
                        restaurantId: restaurant!.id,
                        restaurantCoords: [
                          restaurant!.coords.latitude,
                          restaurant!.coords.longitude
                        ],
                        recipientCoords: [latitude, longitude],
                        driverId: "driverId",
                        rating: restaurant!.rating.toInt(),
                        feedback: "feedback",
                        promoCode: "promoCode",
                        discountAmount: 50,
                        notes: controller.noteToRider.text,
                        customerName: controller.fullname.text == "" ? firstName : controller.fullname.text,
                        customerPhone: controller.phone.text == "" ? phone : controller.fullname.text,
                      );
                      String data = orderRequestToJson(order);

                      final paymentLink = await orderController.makePayment(
                        amount:
                            "${estimatedDeliveryFee + totalPrice + (totalPrice * 0.12).round()}",
                        currency: 'NGN', // or other currency
                        email: "$email", // replace with actual customer email
                      );
                      if (paymentLink != null) {
                        Get.to(() => PaymentWebViewPage(
                              paymentLink: paymentLink,
                              orderData: data,
                              item: order,
                            ));
                      }
                    },
                    title: "Make payment",
                    showArrow: false,
                    btnWidth: width,
                    btnHeight: 96.h,
                    raduis: 120.r,
                    fontSize: 28.sp,
                    textColor: Tcolor.Text,
                    gradient: Tcolor.Primary_button,
                    boxShadow: [
                      BoxShadow(
                          color: Tcolor.PRIMARY_Button_Inner_Shadow,
                          offset: const Offset(0, -1),
                          blurRadius: 1,
                          spreadRadius: 0)
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
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
