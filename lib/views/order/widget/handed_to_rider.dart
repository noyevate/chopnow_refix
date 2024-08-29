import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/models/order_new_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class RiderDetails extends StatelessWidget {
  const RiderDetails({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                height: 70.h,
                width: 70.w,
                decoration: BoxDecoration(
                    gradient: Tcolor.SECONDARY_Button_gradient,
                    borderRadius: BorderRadius.circular(100.r)),
                child: Icon(
                  HeroiconsSolid.computerDesktop,
                  size: 32.sp,
                  color: Tcolor.White,
                )),
            SizedBox(
              width: 20.w,
            ),

            if(order.orderStatus == "Placed")
            Container(
              color: Tcolor.BORDER_Light,
              height: 5.h,
              width: 30.w,
            ),

            if(order.orderStatus != "Placed")
            SizedBox(
              child: ReuseableText(
                title: "Daniel Adedayo",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 32.sp,
                    color: Tcolor.Text),
              ),
            ),
          ],
        ),
        Container(
          height: 64.h,
          width: 64.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.h),
              border: Border.all(color: Tcolor.BORDER_Light), // Updated radius
              color: Tcolor.White),
          child: Icon(
            HeroiconsSolid.phone,
            color: Tcolor.TEXT_Placeholder,
            size: 32.sp,
          ),
        ),
      ],
    );
  }
}
