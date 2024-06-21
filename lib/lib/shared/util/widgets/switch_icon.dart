import 'package:flutter/cupertino.dart';

import '../../../core/env/utils/colors.dart';
import '../../../core/env/utils/string_resources.dart';
import '../asset_images.dart';
import 'custom_list_tile.dart';


class ModeSwitchTile extends StatelessWidget {
  final bool isRideMode;
  final Function(bool) onToggle;

  const ModeSwitchTile({
    Key? key,
    required this.isRideMode,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      svgIcon: isRideMode
          ? AssetResources.lockIcon
          : AssetResources.faceIdIcon,
      title: isRideMode
          ? StringResources.face_id
          : StringResources.face_id,
      subtitle: isRideMode
          ? StringResources.manage_device_security
          : StringResources.manage_device_security,
      trailingWidget: CupertinoSwitch(
        value: isRideMode,
        onChanged: onToggle,
        activeColor:
        isRideMode ? AppColors.primaryColor : AppColors.tedButtonGrey,
        trackColor:
        isRideMode ? AppColors.primaryColor : AppColors.grey[24],
        thumbColor: isRideMode ? AppColors.tedDeepPurple : AppColors.tedButtonGrey,
      ),
      onTap: () {
        // Add onTap logic if needed
      },
    );
  }
}