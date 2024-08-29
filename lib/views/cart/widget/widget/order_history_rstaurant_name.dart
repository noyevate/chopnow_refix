import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/hooks/fetch_restaurant_byId.dart';
import 'package:chopnow/models/order_new_model.dart';
import 'package:chopnow/models/single_restaurant_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderRestaurantName extends HookWidget {
  const OrderRestaurantName({
    super.key,
    this.order,
    required this.onRestaurantFetched,
  });

  final OrderModel? order;
  final Function(SingleRestaurantModel) onRestaurantFetched;

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchRestaurantById(order!.restaurantId);
    final SingleRestaurantModel? restaurant = hookResult.data;
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;

    if (restaurant != null) {
      onRestaurantFetched(restaurant);
    }

    return isLoading
        ? Container(
            color: Tcolor.White,
          )
        : restaurant == null
            ? Container(
                color: Tcolor.White,
                child: Center(
                    child: ReuseableText(
                  title: 'No restaurant logo available',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: Tcolor.Text_Secondary,
                  ),
                )),
              )
            : Column(
                children: [
                  ReuseableText(
                    title: restaurant.title,
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                        color: Tcolor.Text),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 0,
                          right: 10.h,
                        ),
                        child: Wrap(
                          spacing: 10.w,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runSpacing: 5.h,
                          children: [
                            ReuseableText(
                              title:
                                  "${order!.orderItems[0].additives.length} Items",
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400,
                                color: Tcolor.TEXT_Label,
                              ),
                            ),
                            Container(
                              width: 10.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                color: Tcolor.BORDER_Light,
                                shape: BoxShape.circle,
                              ),
                            ),
                            ReuseableText(
                              title: order!.grandTotal.toString(),
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400,
                                color: Tcolor.TEXT_Label,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
  }
}
