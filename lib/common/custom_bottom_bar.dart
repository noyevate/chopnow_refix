import 'package:chopnow/common/color_extension.dart';
import 'package:chopnow/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

enum IconType { svg, image }

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    this.color,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final Color? color;
  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Tcolor.BACKGROUND_Dark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavItem(
              context,
              iconData: HeroiconsOutline.home,
              label: 'Home',
              index: 0,
              onPressed: () => onItemTapped(0),
            ),
            _buildNavItem(
              context,
              iconData: HeroiconsMini.magnifyingGlass,
              label: 'Search',
              index: 1,
              onPressed: () => onItemTapped(1),
            ),
            SizedBox(width: 30.w), // Space for FloatingActionButton
            _buildNavItem(
              context,
              iconData: HeroiconsOutline.users,
              label: 'Support',
              index: 3,
              onPressed: () => onItemTapped(3),
            ),
            _buildNavItem(
              context,
              iconPath: "assets/img/bottombar_profile.png",
              iconType: IconType.image,
              label: 'Profile',
              index: 4,
              onPressed: () => onItemTapped(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    String? iconPath,
    IconData? iconData,
    required String label,
    IconType? iconType,
    required int index,
    required VoidCallback onPressed,
  }) {
    assert(iconPath != null || iconData != null,
        'Either iconPath or iconData must be provided');
    assert(iconType != null || iconData != null,
        'iconType must be provided if using iconPath');

    bool isSelected = selectedIndex == index;
    Color itemColor = isSelected ? Tcolor.Primary : Tcolor.TEXT_Label;

    Widget iconWidget;
    if (iconPath != null && iconType != null) {
      switch (iconType) {
        case IconType.svg:
          iconWidget = SvgPicture.asset(
            iconPath,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
          );
          break;
        case IconType.image:
          iconWidget = Image.asset(
            iconPath,
            width: 30.w,
            height: 30.h,
            color: itemColor,
          );
          break;
      }
    } else {
      iconWidget = Icon(
        iconData,
        color: itemColor,
        size: 30.sp,
      );
    }

    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            child: FittedBox(
              fit: BoxFit.contain,
              child: iconWidget,
              
            ),
          ),
          const SizedBox(height: 4),
          ReuseableText(
            title: label,
            style: TextStyle(
              fontSize: 20.sp,
              color: itemColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
