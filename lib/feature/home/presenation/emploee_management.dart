import 'dart:ui';

import 'package:cafe_app/core/app_colors.dart';
import 'package:cafe_app/feature/home/presenation/widgets/personnel_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/constantw.dart';

class OurTeamList extends StatelessWidget {
  const OurTeamList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 0.95,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return PersonnelCard(name: 'Mahdi Daneshfar', avatarUrl: AppConstants.img, onTap: () {
                Get.to(StaffProfilePage());
              },);
            },
          ),
        ),
      ),
    );
  }
}



class StaffProfilePage extends StatefulWidget {
  const StaffProfilePage({super.key});

  @override
  State<StaffProfilePage> createState() => _StaffProfilePageState();
}

class _StaffProfilePageState extends State<StaffProfilePage> with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;
  late final AnimationController _animController;

  final String profileImage = AppConstants.img;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // helper for glass card
  Widget glassCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color.fromRGBO(61, 44, 42, 0.35),
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  // small timeline item
  Widget timelineItem(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFD4BBA5).withOpacity(0.6),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.brown[900],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color:  Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color:const Color(0xFFD4BBA5),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // calendar grid (simple)
  Widget calendarGrid() {
    // we'll show a cropped month like the HTML
    List<int?> days = [
      29, 30, 1, 2, 3, 4, 5, // first row
      6, 7, 8, 9, 10, 11, 12,
      13, 14, 15, 16, 17, 18, 19,
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('S', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('M', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('T', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('W', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('T', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('F', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('S', style: TextStyle(color: const Color(0xFFD4BBA5))),
          ],
        ),
        const SizedBox(height: 10),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: days.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
          ),
          itemBuilder: (context, idx) {
            final val = days[idx];
            // mark special days 3,9,10,16 like screenshot
            final isCircle = val == 3 || val == 9 || val == 16;
            final isPrimary = val == 10;
            final textColor = Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.brown[900];
            if (val == null) {
              return const SizedBox();
            }
            if (isPrimary) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD47311), // primary orange
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  '$val',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              );
            } else if (isCircle) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD4BBA5).withOpacity(0.45),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$val',
                  style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                ),
              );
            } else {
              return Center(
                child: Text('$val', style: TextStyle(color: textColor)),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('پروفایل کاربر'),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: true,
        child: FadeTransition(
          opacity: _animController.drive(CurveTween(curve: Curves.easeOut)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 6),
                  // Profile picture and name
                  Column(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: NetworkImage(profileImage),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Alex Doe',
                        style: TextStyle( fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text('Head Barista', style: TextStyle( fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Segmented control
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.brown.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      children: [
                        _segmentButton(0, 'اطلاعات'),
                        _segmentButton(1, 'مسئولیت ها'),
                        _segmentButton(2, 'یادداشت'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Info Tab content (we'll show only Info like screenshot)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: _selectedTabIndex == 0
                        ? Column(
                            key: const ValueKey('info'),
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Personal Details Card
                              glassCard(
                                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'اطلاعات شخصی',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    _twoColumnRow(
                                      'تلفن',
                                      '09125554477',
                                    ),
                                    const Divider(color: Color(0xFFBBAA99), height: 18),
                                    _twoColumnRow(
                                      'ایمیل',
                                      'test@example.com',
                                    ),
                                    const Divider(color: Color(0xFFBBAA99), height: 18),
                                    _twoColumnRow('سن', '28',),
                                    const Divider(color: Color(0xFFBBAA99), height: 18),
                                    _twoColumnRow(
                                      'روز آف',
                                      'یکشنبه',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              // Work History timeline card
                              glassCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'تاریخچه فعالیت',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    // vertical line + items
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // timeline line
                                        Column(
                                          children: [
                                            Container(width: 2, height: 8, color: Colors.transparent),
                                            Container(
                                              width: 2,
                                              height: 60,
                                              color: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              timelineItem(Icons.flag, 'استخدام', '15 مرداد 1402'),
                                              const SizedBox(height: 12),
                                              timelineItem(
                                                Icons.star,
                                                'ارتقا به سرپرست باریستا',
                                                '10 اردیبهشت 1404',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              // Off-Days calendar card
                              glassCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Off-Days',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          'October 2024',
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    calendarGrid(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 90),
                            ],
                          )
                        : _selectedTabIndex == 1
                        ? Container(
                            key: const ValueKey('resp'),
                            padding: const EdgeInsets.all(30),
                            child: Center(
                              child: Text(
                                'Responsibilities (placeholder)',
                              ),
                            ),
                          )
                        : Container(
                            key: const ValueKey('notes'),
                            padding: const EdgeInsets.all(30),
                            child: Center(
                              child: Text('Notes (placeholder)', ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _segmentButton(int idx, String title) {
    final active = _selectedTabIndex == idx;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = idx;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 44,
          decoration: BoxDecoration(
            color: active
                ? (
                       const Color(0xFFD4BBA5).withOpacity(0.18))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: active
                  ? (Colors.white)
                  : (const Color(0xFFD4BBA5)),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _twoColumnRow(String left, String right,) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(left, style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          Text(
            right,
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
