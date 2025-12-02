import 'package:cafe_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInfoCard extends StatelessWidget {
  final String? heroTag;

  final IconData icon;
  final Color iconColor;

  final String title;
  final String? subtitle;
  final String? caption;

  final String? trailingText;
  final String? statusText;
  final Color? statusColor;

  final Function()? onTap;

  const CustomInfoCard({
    super.key,
    this.heroTag,

    required this.icon,
    required this.iconColor,

    required this.title,
    this.subtitle,
    this.caption,

    this.trailingText,
    this.statusText,
    this.statusColor,

    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Material(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.transparent,
        hoverColor: AppColors.secondaryColor.withOpacity(0.1),
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(width: 1, color: statusColor ?? AppColors.cardBackground)
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),

              const SizedBox(width: 15),

              // Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                    if (caption != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        caption!,
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ],
                ),
              ),

              // Right side
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (trailingText != null)
                    Text(
                      trailingText!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: statusColor ?? Colors.black,
                      ),
                      textDirection: TextDirection.rtl,
                    ),

                  if (statusText != null && statusColor != null) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor!.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        statusText!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: statusColor!,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ]
                ],
              )
            ],
          ),
        ),
      ),
    );

    // Wrap with hero if needed
    if (heroTag != null) {
      return Hero(tag: heroTag!, child: card);
    }

    return card;
  }
}
