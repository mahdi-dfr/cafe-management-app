import 'package:cafe_app/core/widgets/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/resource/app_colors.dart';
import 'group_charter.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('منو', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                ItemTile(
                  title: 'تنظیمات عمومی',
                  subtitle: 'تم برنامه، نوتیفیکیشن ها ...',
                  icon: Icons.settings,
                  onTap: () {},
                ),
                SizedBox(height: 14),
                ItemTile(
                  title: 'لیست آف پرسنل',
                  subtitle: 'نمایش جامع وضعیت آف پرسنل',
                  icon: Icons.person,
                  onTap: () {},
                ),
                SizedBox(height: 14),
                ItemTile(
                  title: 'منشور مجموعه',
                  subtitle: 'قوانین و مقررات رفتاری محموعه',
                  icon: Icons.rule,
                  onTap: () {
                    Get.to(GroupCharter());
                  },
                ),
                SizedBox(height: 14),
                ItemTile(
                  title: 'درباره ما',
                  subtitle: 'هر آنچه از ما لازم است بدانید!',
                  icon: Icons.info,
                  onTap: () {},
                ),
                SizedBox(height: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
