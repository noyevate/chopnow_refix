import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/custom_button.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/common/size.dart';
import 'package:chopnow/controllers/rating_controller.dart';
import 'package:chopnow/enty_point.dart';
import 'package:chopnow/models/order_new_model.dart';
import 'package:chopnow/models/single_restaurant_model.dart';
import 'package:chopnow/views/cart/widget/widget/order_status.dart';
import 'package:chopnow/views/cart/widget/widget/order_tracking_images.dart';
import 'package:chopnow/views/order/order_tracking_widgets/subwidget/restaurant_logo_call.dart';
import 'package:chopnow/views/order/widget/handed_to_rider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:intl/intl.dart';

import '../order_tracking_widgets/subwidget/note_to_vendors.dart';
import '../order_tracking_widgets/subwidget/order_id_and_time.dart';
import '../order_tracking_widgets/subwidget/textn_price_widget.dart';
import '../subwidget/rating_button.dart';

String formatDate(String dateStr) {
  DateTime dateTime = DateTime.parse(dateStr).toLocal();
  DateFormat outputFormat = DateFormat('EEE, d MMM yyyy, h:mm a', 'en_US');
  return outputFormat.format(dateTime);
}

String hourTime(String dateStr) {
  DateTime dateTime = DateTime.parse(dateStr).toLocal();
  DateFormat outputFormat = DateFormat('h:mm a', 'en_US');
  return outputFormat.format(dateTime);
}

class ProcessingOrder extends HookWidget {
  const ProcessingOrder({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final restaurant = useState<SingleRestaurantModel?>(null);
    final controller = Get.put(RatingController());

    return Container(
      // padding: EdgeInsets.only(left: 30.w, right: 30.w),
      height: height,
      width: width,
      color: Tcolor.BACKGROUND_Regaular,

      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return controller.showRatingSubmitted.value
                  ? Container(
                      color: Tcolor.SUCCESS_Light_2,
                      width: double.infinity,
                      height: 120.h,
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Row(
                        children: [
                          Icon(
                            HeroiconsSolid.checkCircle,
                            color: Tcolor.SUCCESS_Reg,
                            size: 32.sp,
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReuseableText(
                                  title: "Rating submitted",
                                  style: TextStyle(
                                      color: Tcolor.SUCCESS_Reg,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w400),
                                ), 
                                GestureDetector(onTap: (){controller.showRatingSubmitted.value = false;}, child: Icon(HeroiconsOutline.xMark, color: Tcolor.TEXT_Placeholder, size: 40.sp,))
                              ],
                            ),
                          )
                        ],
                      ))
                  : const SizedBox.shrink(); // Empty widget if not shown
            }),
            Container(
              color: Tcolor.White,
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                    height: 64.h,
                    width: 64.h,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(32.h), // Updated radius
                        color: Tcolor.BACKGROUND_Regaular),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        HeroiconsOutline.arrowLeft,
                        color: Tcolor.Text,
                        size: 32.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  OrderStatus(
                    order: order,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ReuseableText(
                    title: formatDate("${order.createdAt}"),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28.sp,
                        color: Tcolor.TEXT_Label),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  OrderTrackingImages(
                    order: order,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  if (order.orderStatus == "Delivered")
                    RatingButton(
                      order: order,
                    ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              color: Tcolor.White,
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  RestaurantLogoCall(
                    order: order,
                    onRestaurantFetched: (fetchedRestaurant) {
                      WidgetsBinding.instance.addPostFrameCallback((__) {
                        restaurant.value = fetchedRestaurant;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(
                    color: Tcolor.BORDER_Light,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  RiderDetails(
                    order: order,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              color: Tcolor.White,
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: NoteToVendors(
                title1: order.orderItems[0].instruction.isEmpty
                    ? "no note to Restaurant.."
                    : order.orderItems[0].instruction,
                title2:
                    order.notes.isEmpty ? "no note to Rider.." : order.notes,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              color: Tcolor.White,
              padding: EdgeInsets.only(left: 30.w, right: 7.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OrderIdAndTime(
                    title1: "Order ID: ",
                    title2: order.id,
                  ),
                  OrderIdAndTime(
                      fontWeight: FontWeight.w400,
                      title1: "Order time: ",
                      title2: hourTime(order.createdAt.toString()))
                ],
              ),
            ),
            Container(
              color: Tcolor.White,
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  ReuseableText(
                    title: "ORDER DETAILS",
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Tcolor.Text),
                  ),
                  for (int i = 0; i < order.orderItems[0].numberOfPack; i++)
                    Container(
                      key: ValueKey(i),
                      // padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReuseableText(
                                title: "Pack ${i + 1}",
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Tcolor.TEXT_Body,
                                ),
                              ),
                              ReuseableText(
                                title: order.orderTotal.toString(),
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Tcolor.TEXT_Body,
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: order.orderItems.length,
                              itemBuilder: (context, index) {
                                final orderItem = order.orderItems[index];
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ReuseableText(
                                          title: order.orderItems[0]
                                              .additives[0].foodTitle,
                                          style: TextStyle(
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Tcolor.TEXT_Body,
                                          ),
                                        ),
                                        ReuseableText(
                                          title:
                                              "x${order.orderItems[0].additives[0].foodCount}",
                                          style: TextStyle(
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Tcolor.TEXT_Body,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: orderItem.additives.length,
                                        itemBuilder: (context, additiveIndex) {
                                          final additive = orderItem
                                              .additives[additiveIndex];
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ReuseableText(
                                                      title: additive.name,
                                                      style: TextStyle(
                                                        fontSize: 28.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Tcolor.TEXT_Body,
                                                      ),
                                                    ),
                                                    ReuseableText(
                                                      title:
                                                          "x${additive.quantity}",
                                                      style: TextStyle(
                                                        fontSize: 28.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Tcolor.TEXT_Body,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                );
                              }),
                          Divider(
                            thickness: 2,
                            color: Tcolor.BACKGROUND_Regaular,
                          ),
                        ],
                      ),
                    ),
                  TextnPriceWidget(
                    title: 'Subtotal',
                    title1: "${order.orderTotal}",
                  ),
                  SizedBox(height: 30.h),
                  TextnPriceWidget(
                    title: 'Service fee',
                    title1: "${((order.orderTotal) * 0.12).round()}",
                  ),
                  SizedBox(height: 30.h),
                  TextnPriceWidget(
                    title: 'Delivery Fee',
                    title1: "${order.deliveryFee}",
                  ),
                  SizedBox(height: 30.h),
                  TextnPriceWidget(
                    title: 'Total',
                    title1: "${order.grandTotal}",
                    fontWeight: FontWeight.w500,
                    fontWeight2: FontWeight.w500,
                    fontSize1: 32.sp,
                    fontSize: 32.sp,
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
