import 'dart:ui';

import 'package:cafe_app/core/app_colors.dart';
import 'package:cafe_app/feature/home/presenation/add_user_screen.dart';
import 'package:cafe_app/feature/home/presenation/widgets/personnel_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/constantw.dart';

class OurTeamList extends StatefulWidget {
  const OurTeamList({super.key});

  @override
  State<OurTeamList> createState() => _OurTeamListState();
}

class _OurTeamListState extends State<OurTeamList>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  double lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isScrollingDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FadeTransition(
        opacity: _controller,
        child: ScaleTransition(
          scale: _controller,
          child: FloatingActionButton(
            onPressed: () {Get.to(AddUserScreen());},
            backgroundColor: AppColors.secondaryColor,
            child: Icon(Icons.add, color: AppColors.backgroundColor),
          ),
        ),
      ),

      backgroundColor: AppColors.backgroundColor,

      body: SafeArea(
        bottom: false,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notif) {
            final currentOffset = notif.metrics.pixels;

            if (currentOffset > lastOffset) {
              if (!isScrollingDown) {
                isScrollingDown = true;
                _controller.reverse();
              }
            } else if (currentOffset < lastOffset) {
              if (isScrollingDown) {
                isScrollingDown = false;
                _controller.forward();
              }
            }

            lastOffset = currentOffset;
            return true;
          },

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
                return PersonnelCard(
                  name: 'Mahdi Daneshfar',
                  avatarUrl: AppConstants.img,
                  onTap: () => Get.to(const StaffProfilePage()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}


// ===========================================================
// STAFF PROFILE PAGE
// ===========================================================

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(title: const Text('پروفایل کاربر'), centerTitle: true),
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

                  /// PROFILE HEADER
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
                      const Text(
                        'Mahdi Daneshfar',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      const Text('Head Barista', style: TextStyle(fontSize: 15)),
                    ],
                  ),

                  const SizedBox(height: 18),

                  /// SEGMENTED CONTROL
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.brown.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      children: [
                        SegmentButton(
                          index: 0,
                          currentIndex: _selectedTabIndex,
                          title: 'اطلاعات',
                          onTap: () => setState(() => _selectedTabIndex = 0),
                        ),
                        SegmentButton(
                          index: 1,
                          currentIndex: _selectedTabIndex,
                          title: 'مسئولیت ها',
                          onTap: () => setState(() => _selectedTabIndex = 1),
                        ),
                        SegmentButton(
                          index: 2,
                          currentIndex: _selectedTabIndex,
                          title: 'یادداشت',
                          onTap: () => setState(() => _selectedTabIndex = 2),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: _selectedTabIndex == 0
                        ? Column(
                            key: const ValueKey('info'),
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              /// PERSONAL INFO
                              GlassCard(
                                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'اطلاعات شخصی',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(height: 12),
                                    const TwoColumnRow('تلفن', '09125554477'),
                                    const Divider(color: Color(0xFFBBAA99), height: 18),
                                    const TwoColumnRow('ایمیل', 'test@example.com'),
                                    const Divider(color: Color(0xFFBBAA99), height: 18),
                                    const TwoColumnRow('سن', '28'),
                                    const Divider(color: Color(0xFFBBAA99), height: 18),
                                    const TwoColumnRow('روز آف', 'یکشنبه'),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 14),

                              /// TIMELINE
                              GlassCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'تاریخچه فعالیت',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(width: 2, height: 8, color: Colors.transparent),
                                            Container(width: 2, height: 60, color: AppColors.primaryColor),
                                          ],
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            children: const [
                                              TimelineItem(Icons.flag, 'استخدام', '15 مرداد 1402'),
                                              SizedBox(height: 12),
                                              TimelineItem(
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

                              /// CALENDAR
                              GlassCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Off-Days',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                                        ),
                                        Text('October 2024', style: TextStyle(fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    CalendarGrid(),
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
                            child: const Center(child: Text('Responsibilities (placeholder)')),
                          )
                        : Container(
                            key: const ValueKey('notes'),
                            padding: const EdgeInsets.all(30),
                            child: const Center(child: Text('Notes (placeholder)')),
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
}

// =====================================================================
// CLASS-BASED WIDGETS
// =====================================================================

/// GLASS CARD
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const GlassCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color.fromRGBO(61, 44, 42, 0.35)),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// TIMELINE ITEM
class TimelineItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const TimelineItem(this.icon, this.title, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: const Color(0xFFD4BBA5).withOpacity(0.6), shape: BoxShape.circle),
          child: Icon(icon, color: Colors.brown[900]),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Color(0xFFD4BBA5), fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
}

/// TWO COLUMN ROW
class TwoColumnRow extends StatelessWidget {
  final String left;
  final String right;

  const TwoColumnRow(this.left, this.right, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(left, style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
          Text(
            right,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// SEGMENT BUTTON
class SegmentButton extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String title;
  final VoidCallback onTap;

  const SegmentButton({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = index == currentIndex;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 44,
          decoration: BoxDecoration(
            color: active ? const Color(0xFFD4BBA5).withOpacity(0.18) : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: active ? Colors.white : const Color(0xFFD4BBA5),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

/// CALENDAR GRID
class CalendarGrid extends StatelessWidget {
  const CalendarGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<int?> days = [29, 30, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('S', style: TextStyle(color: Color(0xFFD4BBA5))),
            Text('M', style: TextStyle(color: Color(0xFFD4BBA5))),
            Text('T', style: TextStyle(color: Color(0xFFD4BBA5))),
            Text('W', style: TextStyle(color: Color(0xFFD4BBA5))),
            Text('T', style: TextStyle(color: Color(0xFFD4BBA5))),
            Text('F', style: TextStyle(color: Color(0xFFD4BBA5))),
            Text('S', style: TextStyle(color: Color(0xFFD4BBA5))),
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
            final isCircle = val == 3 || val == 9 || val == 16;
            final isPrimary = val == 10;
            final textColor = Colors.white;

            if (val == null) return const SizedBox();

            if (isPrimary) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD47311),
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
}
