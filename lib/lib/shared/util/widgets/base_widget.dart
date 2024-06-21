import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:tedfinance_mobile/core/env/utils/size_utils.dart';
import 'package:tedfinance_mobile/theme/custom_text_style.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    //   return Scaffold(
    //     body: SafeArea(
    //       child: Column(
    //         children: [

    //           Visibility(
    //             visible: Provider.of<InternetConnectionStatus>(context) ==
    //                 InternetConnectionStatus.disconnected,
    //             child: const InternetNotAvailable(),
    //           ),
    //           //  InternetNotAvailable(),
    //           Expanded(child: child),
    //           // PersistentWsidget(),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    // printty("yeeeeeeee");
    // if (InternetConnectionStatus == InternetConnectionStatus.connected) {
    //   Provider.of<ChatProvider>(context, listen: false).joinAllRooms(context);
    //   printty("connected to the internet");
    // }

    return Scaffold(
      body: Column(
        children: [
          Visibility(
            visible: Provider.of<InternetConnectionStatus>(context) ==
                InternetConnectionStatus.disconnected,
            child: Column(
              children: [
                SizedBox(height: 60.h),
                const InternetNotAvailable(),
              ],
            ),
          ),
          //  InternetNotAvailable(),
          Expanded(child: child),
          // PersistentWsidget(),
        ],
      ),
    );
  }
}

class InternetNotAvailable extends StatelessWidget {
  const InternetNotAvailable({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
      child: Center(
        child: Text('No Internet Connection!!!',
            style: CustomTextStyles.titleMediumWhite16),
      ),
    );
  }
}
