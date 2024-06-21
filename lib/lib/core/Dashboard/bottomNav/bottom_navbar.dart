
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';

import '../../env/utils/colors.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          bool isSelected = index == selectedIndex;
          return buildNavItem(index, isSelected);
        }),
      ),
    );
  }

  Widget buildNavItem(int index, bool isSelected) {
    String text = _getLabelText(index);
    String displayText = isSelected && text.length > 5 ? text.substring(0, 5) : text;
    return GestureDetector(
      onTap: () {
        if (index >= 0 && index < 5) {
          onItemSelected(index);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                width: isSelected ? 80.w : 60.w,
                height: isSelected ? 80.h : 60.h,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 100),
                padding: isSelected
                    ? const EdgeInsets.all(12.0) // increase padding when selected
                    : const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white : Colors.transparent,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    _getIconPath(index),
                    color: isSelected ? AppColors.primaryButtonColor : Colors.white,
                    height: index==2 ? 25 : null,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: isSelected ? 50.h : 50.h),
                child: AnimatedDefaultTextStyle(
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 100),
                  style: TextStyle(
                    color: isSelected ? AppColors.primaryButtonColor : Colors.white,
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      displayText,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getIconPath(int index) {
    switch (index) {
      case 0:
        return AssetResources.bottomNavMenuIcon;
      case 1:
        return AssetResources.bottomNavMultiAccountIcon;
      case 2:
        return AssetResources.bottomNavHomeIcon;
      case 3:
        return AssetResources.bottomNavSendIcon;
      case 4:
        return AssetResources.bottomNavInvestIcon;
      default:
        return '';
    }
  }

  String _getLabelText(int index) {
    switch (index) {
      case 0:
        return 'Overview';
      case 1:
        return 'Multi Account';
      case 2:
        return 'Home';
      case 3:
        return 'Send Money';
      case 4:
        return 'Invest';
      default:
        return '';
    }
  }
}


