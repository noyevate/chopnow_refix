
import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/custom_button.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/common/size.dart';
import 'package:chopnow/views/order/order_tracking_widgets/processing_order.dart';
import 'package:chopnow/views/order/subwidget/success_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class CompletedPayment extends StatelessWidget {
  const CompletedPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.h),
        child: Container(
          color: Tcolor.White,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: 100.h,
              color: Tcolor.White,
              child: Row(
                children: [
                  Container(
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
                ],
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Container(
              height: 500.h,
              width: 500.w,
              color: Tcolor.White,
              child: const SuccessLottieWidget(),
            ),
            SizedBox(
              height: 100.h,
            ),
            ReuseableText(
              title: "Payment successful",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40.sp,
                  color: Colors.black),
            ),
            ReuseableText(
              title: "Your order has been received and is now ",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 28.sp,
                  color: Tcolor.TEXT_Body),
            ),
            ReuseableText(
              title: "processing. You can track the progress of",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 28.sp,
                  color: Tcolor.TEXT_Body),
            ),
            ReuseableText(
              title: "your order.",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 28.sp,
                  color: Tcolor.TEXT_Body),
            ),

            const Spacer(),
            
                  Padding(
                    padding: EdgeInsets.only( bottom: 30.h),
                    child: CustomButton(
                      onTap: (){
                        Get.off(() => const TrackingProcessingOrder());
                       
                      },
                      title: "View order",
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
                          spreadRadius: 0
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
