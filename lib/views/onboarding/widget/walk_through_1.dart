import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/common/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalkThrough1 extends StatelessWidget {
  const WalkThrough1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Tcolor.White,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: 110.h,
            // ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    // height: 1200.h,
                    child: Column(
                      children: [
                        SizedBox(height: 100.h,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                              "assets/img/fast_food_illustration.png",
                              height: 750.h),
                        ),
                        Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReuseableText(
                        title: "Welcome to",
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontSize: 90.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      ReuseableText(
                        title: "ChopNow!",
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontSize: 90.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ReuseableText(
                        title: "We connect you with your favorite restaurants",
                        style: TextStyle(
                            color: Tcolor.TEXT_Body,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.5.sp),
                      ),
                      ReuseableText(
                        title: "so you can enjoy a wide variety of meals",
                        style: TextStyle(
                            color: Tcolor.TEXT_Body,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.5.sp),
                      ),
                      ReuseableText(
                        title: "without ever leaving your couch.",
                        style: TextStyle(
                            color: Tcolor.TEXT_Body,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.5.sp),
                      ),
                    ],
                  ),
                ),
                      ],
                    )),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
