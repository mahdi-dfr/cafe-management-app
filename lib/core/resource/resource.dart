import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

dynamic appDialog({
  required title,
  required content,
  required cancelText,
  required confirmText,
  required onConfirm,
}) {
  return Get.defaultDialog(
    title: title,
    titleStyle: TextStyle(color: AppColors.secondaryColor),
    middleText: content,
    textCancel: cancelText,
    backgroundColor: AppColors.backgroundColor,
    textConfirm: confirmText,
    confirmTextColor: Colors.white,
    onConfirm: onConfirm,
  );
}
