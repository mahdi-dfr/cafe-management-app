import 'package:cafe_app/muck_models/personnle_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/resource/app_colors.dart';
import '../../home/presenation/widgets/personnle/user_management.dart';
import 'create_charter.dart';

class GroupCharter extends StatefulWidget {
  const GroupCharter({super.key});

  @override
  State<GroupCharter> createState() => _GroupCharterState();
}

class _GroupCharterState extends State<GroupCharter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double lastOffset = 0;
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200), value: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FadeTransition(
        opacity: _controller,
        child: ScaleTransition(
          scale: _controller,
          child: FloatingActionButton(
            onPressed: () {
              Get.to(CreateCharter());
            },
            backgroundColor: AppColors.secondaryColor,
            child: Icon(Icons.add, color: AppColors.backgroundColor),
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('منشور مجموعه', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: NotificationListener<ScrollNotification>(
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ResponsibilityTile(
                  icon: Icons.warning_amber_outlined,
                  title: 'قوانین مجموعه',
                  subtitle: charter[index],
                  accent: AppColors.secondaryColor,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 12);
              },
              itemCount: charter.length,
            ),
          ),
        ),
      ),
    );
  }
}
