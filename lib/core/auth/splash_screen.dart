import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tedfinance_mobile/core/auth/white_splash-screen.dart';

import '../../shared/navigations/routes/navigation_service.dart';
import '../../shared/util/asset_images.dart';
import '../env/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;
  late bool isFirstTime;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 4));

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);


    _positionAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(1.0, 1.0)).animate(_animationController);

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WhiteSplashScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _opacityAnimation,
        child: SlideTransition(
        position: _positionAnimation,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(child: SvgPicture.asset(AssetResources.splashLogo)),
      ),
    )
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

}
