import 'package:flutter/material.dart';

import '../resource/app_colors.dart';

class ItemTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? trailing;
  final bool switchButton;
  final bool isDestructive;
  final Function() onTap;

  const ItemTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailing,
    this.switchButton = false,
    this.isDestructive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        hoverColor: AppColors.secondaryColor.withOpacity(0.1),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: isDestructive ? AppColors.secondaryColor : AppColors.secondaryColor, size: 26),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isDestructive ? AppColors.secondaryColor : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle.isNotEmpty)
                      Text(subtitle, style: TextStyle(color: AppColors.secondaryColor, fontSize: 13)),
                  ],
                ),
              ),
              if (trailing != null)
                Text(
                  trailing!,
                  style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.w600),
                ),
              if (switchButton)
                Switch(value: true, onChanged: (_) {}, activeColor: AppColors.secondaryColor),
            ],
          ),
        ),
      ),
    );
  }

}