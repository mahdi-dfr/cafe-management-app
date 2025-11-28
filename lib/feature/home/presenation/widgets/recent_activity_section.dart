import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/resource/app_colors.dart';
import '../../../../core/resource/assets_route.dart';
import 'activity_card.dart';
import '../../../../models/transaction_model.dart';

/// Recent activity section widget
class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'فعالیت‌های اخیر',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 15),
        const ActivityCard(
          title: 'خرید قهوه',
          subtitle: '۲ کاپوچینو',
          amount: '12500 تومان',
          date: 'دیروز',
          status: TransactionStatus.completed,
        ),
        const SizedBox(height: 12),
        const ActivityCard(
          title: 'سفارش شیرینی',
          subtitle: 'کروسان و مافین',
          amount: '8990 تومان',
          date: '۳ روز پیش',
          status: TransactionStatus.completed,
        ),
      ],
    );
  }
}

class PromoSlider extends StatefulWidget {
  const PromoSlider({super.key});

  @override
  State<PromoSlider> createState() => _PromoSliderState();
}

class _PromoSliderState extends State<PromoSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> promos = [
    {
      'image': AssetsRoute.mainLogo,
      'title': 'افزودن منوی دیجیتال',
      'subtitle': 'به زودی منوی آنلاین با سفارش لحظه‌ای اضافه میشه!',
    },
    {
      'image': AssetsRoute.shookaLogo,
      'title': 'باشگاه مشتریان',
      'subtitle': 'با هر خرید امتیاز بگیر و تخفیف ویژه بگیر!',
    },
    {
      'image': AssetsRoute.shookaLogo,
      'title': 'ارسال سریع و هوشمند',
      'subtitle': 'سرویس ارسال قهوه در کمتر از ۳۰ دقیقه به زودی!',
    },
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < promos.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primaryColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: PageView.builder(
        controller: _pageController,
        itemCount: promos.length,
        itemBuilder: (context, index) {
          final promo = promos[index];
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: Container(
              key: ValueKey(promo['title']),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: SvgPicture.asset(
                        promo['image'],
                        height: 30,
                        fit: BoxFit.contain,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          promo['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          promo['subtitle'],
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



