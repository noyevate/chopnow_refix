
import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/controllers/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IconNameIcon1 extends StatelessWidget {
  const IconNameIcon1({
    super.key, required this.name, required this.icon, required this.icon2, this.color,
    
  });

  final String name;
  final IconData icon;
  final IconData icon2;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = Get.put(CheckoutController());
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 40.sp,
              color: Tcolor.TEXT_Label,
            ),
            SizedBox(width: 20.w,),
            ReuseableText(
              title: name,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
                color: Tcolor.Text,
              ),
            ),         
          ],
        ),
        Row(
          children: [
            if (controller.riderNote.value.isNotEmpty) ...[
              SizedBox(height: 10.h),
              SizedBox(
                width: 250.w,
                child: ReuseableText(
                  title: controller.riderNote.value,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w400,
                    color: Tcolor.TEXT_Label,
                  ),
                ),
              ),
            ],
            SizedBox(width: 10.w,),
            Icon(icon2, size: 32.sp, color: color ?? Tcolor.Primary_New,),
          ],
        )
      ],
    )
    );
  }
}
