import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.btnWidth,
    this.btnHeight,
    this.btnColor,
    this.raduis,
    required this.title,
    this.textColor,
    this.fontSize,
    required this.showArrow,
    this.arrowColor,
    this.border,
    this.backgroundBlendMode,
    this.boxShadow,
    this.gradient,
  });

  final void Function()? onTap;
  final double? btnWidth;
  final double? btnHeight;
  final Color? btnColor;
  final double? raduis;
  final String title;
  final Color? textColor;
  final double? fontSize;
  final bool showArrow;
  final Color? arrowColor;
  final BoxBorder? border;
  final BlendMode? backgroundBlendMode;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: btnWidth ?? width,
      height: btnHeight ?? 56.h,
      decoration: BoxDecoration(
        color: btnColor ?? Tcolor.Primary,
        borderRadius: BorderRadius.circular(raduis ?? 18.r),
        border: border,
        backgroundBlendMode: backgroundBlendMode,
        gradient: gradient,
        boxShadow: boxShadow,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(raduis ?? 18.r),
        splashColor: Color.fromARGB(255, 97, 97, 97).withOpacity(0.2), // Black shade when tapped
        onTap: onTap,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReuseableText(
                title: title,
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (showArrow)
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Icon(
                    Icons.arrow_forward,
                    color: arrowColor ?? Colors.white,
                    size: 24.sp,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
