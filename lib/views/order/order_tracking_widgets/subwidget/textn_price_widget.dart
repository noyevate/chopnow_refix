
import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextnPriceWidget extends StatelessWidget {
  const TextnPriceWidget({
    super.key, required this.title, required this.title1, this.fontSize, this.fontSize1, this.fontWeight, this.fontWeight2,
  });
  final String title;
  final String title1;
  final double? fontSize;
  final double? fontSize1;
  final FontWeight? fontWeight;
  final FontWeight? fontWeight2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      ReuseableText(
        title: title,
        style: TextStyle(
            fontSize: fontSize1 ?? 28.sp,
            color: Tcolor.TEXT_Body,
            fontWeight:fontWeight ?? FontWeight.w400),
      ), 
      ReuseableText(
        title: title1,
        style: TextStyle(
            fontSize: fontSize ?? 28.sp,
            color: Tcolor.Text,
            fontWeight:fontWeight2 ?? FontWeight.w400),
      ), 
    
    ],
    );
  }
}
