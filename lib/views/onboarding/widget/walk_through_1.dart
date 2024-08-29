
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
      color: Tcolor.Primary,
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
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ReuseableText(
                            title: "A friendly illustration of a hand holding a ",
                            style: TextStyle(
                                color: Tcolor.White,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.justify,
                          ),
                          ReuseableText(
                            title: "phone with the Chop Now app open,",
                            style: TextStyle(
                                color: Tcolor.White,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.justify,
                          ),
                          ReuseableText(
                            title: "with various restaurant logos popping",
                            style: TextStyle(
                                color: Tcolor.White,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.justify,
                          ),
                          ReuseableText(
                            title: "out around them..",
                            style: TextStyle(
                                color: Tcolor.White,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
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
        ),
      ),
    );
  }
}
