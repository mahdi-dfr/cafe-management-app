
import 'package:cafe_app/core/app_colors.dart';
import 'package:cafe_app/core/assets_route.dart';
import 'package:cafe_app/feature/home/presenation/widgets/personnel_item.dart';
import 'package:cafe_app/feature/home/presenation/widgets/user_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constantw.dart';
import 'add_user_screen.dart';

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
            onPressed: () {
              Get.to(AddUserScreen());
            },
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
                  avatarUrl: AssetsRoute.img,
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

class _StaffProfilePageState extends State<StaffProfilePage>
    with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;
  late final AnimationController _animController;

  final String profileImage = AppConstants.img;




  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
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
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Head Barista',
                        style: TextStyle(fontSize: 15),
                      ),
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
                        ? UserInfoWidget()
                        : _selectedTabIndex == 1
                        ? UserResponsibilitiesWidget()
                        : UserNoteWidget() ,
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

