
import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalkThrough2 extends StatelessWidget {
  const WalkThrough2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: height,
        width: width,
        color: Tcolor.White,
        child: Column(
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
                        title: "Discover New",
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontSize: 90.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      ReuseableText(
                        title: "Cravings!",
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
                        title: "Explore our wide range of restaurants and",
                        style: TextStyle(
                            color: Tcolor.TEXT_Body,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.5.sp),
                      ),
                      ReuseableText(
                        title: "cuisines to find exactly what your taste buds are",
                        style: TextStyle(
                            color: Tcolor.TEXT_Body,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.5.sp),
                      ),
                      ReuseableText(
                        title: "calling for.",
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
      ),
    );
  }
}