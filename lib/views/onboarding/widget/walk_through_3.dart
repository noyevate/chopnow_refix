
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
      color: Tcolor.White,
      child: SingleChildScrollView(
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
                          alignment: Alignment.center,
                          child: Image.asset(
                              "assets/img/Online_delivery.png",
                              height: 750.h),
                        ),
                        Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReuseableText(
                        title: "Order Easy,",
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontSize: 90.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      ReuseableText(
                        title: "Eat Fast",
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
                        title: "Chop Now delivers fresh, piping hot food straight",
                        style: TextStyle(
                            color: Tcolor.TEXT_Body,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.5.sp),
                      ),
                      ReuseableText(
                        title: "to your door, satisfying your cravings in a flash!",
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