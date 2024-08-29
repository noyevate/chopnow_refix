
import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalkThrough3 extends StatelessWidget {
  const WalkThrough3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Tcolor.SECONDARY_S4,
      child: SingleChildScrollView(
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
                        color: Tcolor.Secondary_Base),
                    
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  ReuseableText(
                    title: "Order Easy,",
                    style: TextStyle(
                      color: Tcolor.Primary_New,
                      fontSize: 90.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  ReuseableText(
                    title: "Eat Fast",
                    style: TextStyle(
                      color: Tcolor.Primary_New,
                      fontSize: 90.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  ReuseableText(
                    title: "Chop Now delivers fresh, piping hot food",
                    style: TextStyle(
                        color: Tcolor.Primary_New,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.5.sp),
                  ),
                  ReuseableText(
                    title: "straight to your door, satisfying your cravings",
                    style: TextStyle(
                        color: Tcolor.Primary_New,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.5.sp),
                  ),
                  ReuseableText(
                    title: "in a flash!",
                    style: TextStyle(
                        color: Tcolor.Primary_New,
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