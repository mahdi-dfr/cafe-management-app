import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../core/app_colors.dart';
import '../core/assets_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _logoController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _logoScale;
  late Animation<double> _logoGlow;

  final String _fullText = "Caffe And Friends\nAre The Perfect Blend";
  String _visibleText = "";

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _setupAnimations();
    _startSequence();
  }

  void _setupAnimations() {
    // Fade in background
    _fadeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    // Logo bounce + glow
    _logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoGlow = Tween<double>(begin: 0.0, end: 15.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );
  }

  void _startSequence() async {
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    _animateText();
  }

  /// text animation
  void _animateText() {
    int index = 0;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (index < _fullText.length) {
        setState(() {
          _visibleText += _fullText[index];
        });
        index++;
      } else {
        timer.cancel();

        Future.delayed(const Duration(microseconds: 10), _navigateToHome);
      }
    });
  }

  void _navigateToHome() {
    Get.offAllNamed('/main');
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
              colors: [
                AppColors.backgroundColor,
                AppColors.tertiaryColor.withOpacity(0.9),
                AppColors.primaryColor.withOpacity(0.6),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _logoScale.value,
                      child: Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor
                                  .withOpacity(0.5 + (_logoGlow.value / 30)),
                              blurRadius: _logoGlow.value,
                              spreadRadius: _logoGlow.value / 3,
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          AssetsRoute.mainLogo,
                          width: 90,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                SvgPicture.asset(AssetsRoute.shookaLogo, width: 95, color: Colors.white,),
                const SizedBox(height: 25),
                AnimatedOpacity(
                  opacity: _visibleText.isNotEmpty ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    _visibleText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.primaryColor.withOpacity(0.9),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                if (_visibleText.length < _fullText.length)
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                    strokeWidth: 3,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
