
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';

import '../../env/utils/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          if (index == 0) {
            return buildNavItem(index, context);
          } else {
            return buildNavItem(index, context);
          }
        }),
      ),
    );
  }

  Widget buildNavItem(int index, BuildContext context) {
    bool isSelected = index == selectedIndex;
    return InkWell(
        onTap: () {
          if (index == 0) {
            Future.delayed(const Duration(milliseconds: 300), () {
              Scaffold.of(context).openDrawer();
            });
          } else {
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
                duration: const Duration(milliseconds: 300),
                width: isSelected ? 72.61 : 40,
                height: isSelected ? 72.61 : 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white : Colors.transparent,
                ),
                alignment: Alignment((index - 1) * 2.0, 0.0),
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      _getIconPath(index),
                      color: isSelected ? AppColors.primaryButtonColor : Colors.white,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(height: 4),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        color: isSelected ? AppColors.tedPurpleText : AppColors.white,
                        fontSize: 12.sp
                      ),
                      child: Text(
                        _getLabelText(index),
                      ),
                    ),
                  ],
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
      default:
        return AssetResources.bottomNavInvestIcon;
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
      default:
        return 'Invest';
    }
  }
}
