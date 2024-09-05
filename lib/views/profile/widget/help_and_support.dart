
import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:chopnow/views/profile/widget/faq.dart';
import 'package:chopnow/views/profile/widget/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

void showCustomBottomSheet(
    BuildContext context, Widget content, double height) {
  showModalBottomSheet(
    backgroundColor: Tcolor.White,
    context: context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
    ),
    builder: (context) => Container(
      constraints: BoxConstraints(
        maxHeight: height,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: content,
      ),
    ),
  );
}

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(10.h), child: Container()),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Column(
            children: [
              Row(
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
                  Padding(
                    padding: EdgeInsets.only(left: 30.w),
                    child: ReuseableText(
                      title: "Help and support",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 32.sp,
                          color: Tcolor.Text),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => FAQPage(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 700));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileTile(
                      title: "FAQs",
                      icon: HeroiconsOutline.questionMarkCircle,
                      onTap: () {
                        Get.to(() => FAQPage(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 700));
                      },
                    ),
                    Icon(
                      HeroiconsOutline.chevronRight,
                      size: 32.sp,
                      color: Tcolor.TEXT_Label,
                    )
                  ],
                ),
              ),
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileTile(
                      title: "Email",
                      icon: HeroiconsOutline.envelope,
                      onTap: () {},
                    ),
                    Icon(
                      HeroiconsOutline.chevronRight,
                      size: 32.sp,
                      color: Tcolor.TEXT_Label,
                    )
                  ],
                ),
              ),
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileTile(
                      title: "Phone",
                      icon: HeroiconsOutline.phone,
                      onTap: () {},
                    ),
                    Icon(
                      HeroiconsOutline.chevronRight,
                      size: 32.sp,
                      color: Tcolor.TEXT_Label,
                    )
                  ],
                ),
              ),
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ProfileTile(
                          title: "whatsapp",
                          icon: FontAwesome.whatsapp,
                          onTap: () {},
                        ),
                      ],
                    ),
                    Icon(
                      HeroiconsOutline.chevronRight,
                      size: 32.sp,
                      color: Tcolor.TEXT_Label,
                    )
                  ],
                ),
              ),
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ProfileTile(
                          title: "Facebook",
                          icon: FontAwesome.facebook_square,
                          onTap: () {},
                        ),
                      ],
                    ),
                    Icon(
                      HeroiconsOutline.chevronRight,
                      size: 32.sp,
                      color: Tcolor.TEXT_Label,
                    )
                  ],
                ),
              ),
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ProfileTile(
                          title: "Instagram",
                          icon: FontAwesome.instagram,
                          onTap: () {},
                        ),
                      ],
                    ),
                    Icon(
                      HeroiconsOutline.chevronRight,
                      size: 32.sp,
                      color: Tcolor.TEXT_Label,
                    )
                  ],
                ),
              ),
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ProfileTile(
                          title: "Twitter (X)",
                          icon: FontAwesome.twitter_square,
                          onTap: () {},
                        ),
                      ],
                    ),
                    Icon(
                      HeroiconsOutline.chevronRight,
                      size: 32.sp,
                      color: Tcolor.TEXT_Label,
                    )
                  ],
                ),
              ),
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ProfileTile(
                          title: "Phone",
                          icon: FontAwesome.whatsapp,
                          onTap: () {},
                        ),
                      ],
                    ),
                    Icon(
                      HeroiconsOutline.chevronRight,
                      size: 32.sp,
                      color: Tcolor.TEXT_Label,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
