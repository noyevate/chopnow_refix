
import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/views/onboarding/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Get.off(() => const NextScreen(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 700));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.Primary_New,
      body: Center(
        child: Container(
          height: 150.h,
          width: 150.w,
          decoration: BoxDecoration(
            
            color: Tcolor.SECONDARY_S4,
            borderRadius: BorderRadius.circular(100.r)

          ),
        ),
      ),
    );
  }
}