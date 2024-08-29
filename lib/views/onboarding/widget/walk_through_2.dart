
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
        color: Tcolor.Primary,
        child: Column(
          children: [
            SizedBox(
              height: 110.h,
            ),
            Padding(
              padding: EdgeInsets.all(40.sp),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 620.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        color: Tcolor.Primary_14),
                    
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  ReuseableText(
                    title: "Discover New",
                    style: TextStyle(
                      color: Tcolor.SECONDARY_S3,
                      fontSize: 90.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  ReuseableText(
                    title: "Cravings!",
                    style: TextStyle(
                      color: Tcolor.SECONDARY_S3,
                      fontSize: 90.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  ReuseableText(
                    title: "Explore our wide range of restaurants and ",
                    style: TextStyle(
                        color: Tcolor.SECONDARY_S3,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.5.sp),
                  ),
                  ReuseableText(
                    title: "cuisines to find exactly what your taste buds",
                    style: TextStyle(
                        color: Tcolor.SECONDARY_S3,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.5.sp),
                  ),
                  ReuseableText(
                    title: "are calling for.",
                    style: TextStyle(
                        color: Tcolor.SECONDARY_S3,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.5.sp),
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