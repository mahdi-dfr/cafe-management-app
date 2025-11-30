import 'dart:ui';

import 'package:cafe_app/muck_models/personnle_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../screen/personnle/personnle_management.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key, required this.personnel});

  final PersonnelModel personnel;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('info'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// PERSONAL INFO
        GlassCard(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('اطلاعات شخصی', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              TwoColumnRow('تلفن', personnel.phoneNumber!),
              const Divider(color: Color(0xFFBBAA99), height: 18),
              TwoColumnRow('ایمیل', personnel.email!),
              const Divider(color: Color(0xFFBBAA99), height: 18),
              TwoColumnRow('سن', personnel.age!.toString()),
              const Divider(color: Color(0xFFBBAA99), height: 18),
              TwoColumnRow('روز آف', convertDayOff[personnel.offDay]),
            ],
          ),
        ),
        const SizedBox(height: 14),

        GlassCard(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('مهارت‌های شاخص', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const [
                  TagChip(label: 'لته آرت'),
                  TagChip(label: 'مدیریت مشتریان'),
                  TagChip(label: 'کنترل انبار'),
                  TagChip(label: 'رهبری تیم'),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        /// TIMELINE
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('تاریخچه فعالیت', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
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
                        TimelineItem(Icons.star, 'ارتقا به سرپرست باریستا', '10 اردیبهشت 1404'),
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
                  Text('Off-Days', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
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
    );
  }
}

class UserResponsibilitiesWidget extends StatelessWidget {
  UserResponsibilitiesWidget({super.key});

  final List<ResponsibilityItem> _responsibilities = [
    ResponsibilityItem(
      icon: Icons.local_cafe,
      title: 'سرپرستی سالن',
      subtitle: 'تنظیم شیفت‌ها و هماهنگی بین باریستاها در ساعات پر تردد.',
      accent: AppColors.primaryColor,
    ),
    ResponsibilityItem(
      icon: Icons.inventory_2_rounded,
      title: 'کنترل موجودی',
      subtitle: 'بررسی روزانه مواد اولیه و ثبت سفارش‌های تکمیلی.',
      accent: AppColors.secondaryColor,
    ),
    ResponsibilityItem(
      icon: Icons.handshake,
      title: 'آموزش نیروهای جدید',
      subtitle: 'برگزاری جلسات آموزشی و ارزیابی پیشرفت ماهانه.',
      accent: AppColors.info,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const ValueKey('resp'),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GlassCard(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'مسئولیت‌های روزانه',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _responsibilities.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return ResponsibilityTile(
                        icon: _responsibilities[index].icon,
                        title: _responsibilities[index].title,
                        subtitle: _responsibilities[index].subtitle,
                        accent: _responsibilities[index].accent,
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: AppColors.secondaryColor,
            icon: Icon(Icons.add, color: AppColors.backgroundColor),
            label: Text(
              'مسئولیت جدید',
              style: TextStyle(color: AppColors.backgroundColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class UserNoteWidget extends StatelessWidget {
  UserNoteWidget({super.key});

  final List<NoteItem> _notes = [
    NoteItem(
      title: 'بازخورد مشتریان',
      description: 'پس از اضافه شدن نوشیدنی جدید، ۸۵٪ بازخورد مثبت ثبت شد.',
      timestamp: '۲۴ آبان ۱۴۰۴',
    ),
    NoteItem(
      title: 'جلسه تیمی',
      description: 'نیاز به دوره‌ی مهارت فروش برای نیروهای شیفت عصر احساس شد.',
      timestamp: '۱۸ آبان ۱۴۰۴',
    ),
    NoteItem(
      title: 'چک لیست بهداشت',
      description: 'تمام موارد مطابق استاندارد بود، اما نیاز به اسپری ضدعفونی جدید داریم.',
      timestamp: '۱۲ آبان ۱۴۰۴',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const ValueKey('notes'),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GlassCard(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('یادداشت‌های اخیر', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _notes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final note = _notes[index];
                      return NoteCard(note: note);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: AppColors.secondaryColor,
            icon: Icon(Icons.note_add, color: AppColors.backgroundColor),
            label: Text(
              'یادداشت جدید',
              style: TextStyle(color: AppColors.backgroundColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
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

class ResponsibilityItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  const ResponsibilityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });
}

class ResponsibilityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  const ResponsibilityTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.cardBackground.withOpacity(0.65),
        border: Border.all(color: accent.withOpacity(0.35)),
        boxShadow: [BoxShadow(color: AppColors.shadowColor, blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(subtitle, style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  final String label;

  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.5)),
        color: AppColors.tertiaryColor.withOpacity(0.7),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }
}

class NoteItem {
  final String title;
  final String description;
  final String timestamp;

  const NoteItem({required this.title, required this.description, required this.timestamp});
}

class NoteCard extends StatelessWidget {
  final NoteItem note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [AppColors.tertiaryColor.withOpacity(0.85), AppColors.cardBackground.withOpacity(0.95)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.35)),
        boxShadow: [BoxShadow(color: AppColors.shadowColor, blurRadius: 10, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.sticky_note_2_outlined, color: Colors.white70),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  note.title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Text(note.timestamp, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          Text(note.description, style: TextStyle(color: AppColors.textPrimary, fontSize: 13.5, height: 1.4)),
        ],
      ),
    );
  }
}
