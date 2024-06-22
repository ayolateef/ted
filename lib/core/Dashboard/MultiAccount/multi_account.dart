import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/shared/util/asset_images.dart';

class MultiAccountPage extends StatefulWidget {
  const MultiAccountPage({super.key});

  @override
  State<MultiAccountPage> createState() => _MultiAccountPageState();
}

class _MultiAccountPageState extends State<MultiAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AssetResources.investmentImage2)
      ],
    );
  }
}
