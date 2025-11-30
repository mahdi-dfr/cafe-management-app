import 'dart:async';
import 'package:cafe_app/core/resource/route_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/assets_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _logoController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _logoScale;
  late Animation<double> _logoGlow;

  // final String _fullText = "Caffe And Friends\nAre The Perfect Blend";

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _setupAnimations();
    _startSequence();
  }

  void _setupAnimations() {
    // Fade in background
    _fadeController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    // Logo bounce + glow
    _logoController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _logoScale = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.elasticOut));
    _logoGlow = Tween<double>(
      begin: 0.0,
      end: 15.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeInOut));
  }

  void _startSequence() async {
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    // _animateText();
    await Future.delayed(const Duration(seconds: 2));
    _navigateToHome();
  }

  /// text animation
  // void _animateText() {
  //   int index = 0;
  //   Timer.periodic(const Duration(milliseconds: 50), (timer) {
  //     if (index < _fullText.length) {
  //       setState(() {
  //         _visibleText += _fullText[index];
  //       });
  //       index++;
  //     } else {
  //       timer.cancel();
  //
  //       Future.delayed(const Duration(microseconds: 10), _navigateToHome);
  //     }
  //   });
  // }

  void _navigateToHome() {
    Get.offAllNamed(RouteManagement.login);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _logoController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.splashBackground, AppColors.splashBackground2],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoScale.value,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            padding: const EdgeInsets.all(60),
                            decoration: BoxDecoration(
                              color: AppColors.splashForeground,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withValues(alpha: 0.3),
                                  blurRadius: _logoGlow.value,
                                  spreadRadius: _logoGlow.value / 3,
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              AssetsRoute.mainLogo,
                              width: 80,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40,),
                  SvgPicture.asset(
                    AssetsRoute.shookaLogo,
                    width: 140,
                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  // AnimatedOpacity(
                  //   opacity: _visibleText.isNotEmpty ? 1 : 0,
                  //   duration: const Duration(milliseconds: 500),
                  //   child: Text(
                  //     _visibleText,
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //       color: AppColors.primaryColor.withOpacity(0.9),
                  //       fontWeight: FontWeight.bold,
                  //       letterSpacing: 1.2,
                  //       height: 1.4,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 85),
                  LoadingAnimationWidget.threeRotatingDots(color: AppColors.secondaryColor, size: 50)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
