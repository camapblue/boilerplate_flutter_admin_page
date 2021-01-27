import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_admin_page/constants/app_colors.dart';

enum ToastType { success, failure, announcement }

extension ToastTypeExtension on ToastType {
  Color toBackgroundColor() {
    switch (this) {
      case ToastType.success:
        return const Color(0xff0d7d4e);
      case ToastType.failure:
        return const Color(0xffffbdce);
      case ToastType.announcement:
        return AppColors.accentOri;
    }

    return AppColors.accentOri;
  }

  Color toTextColor() {
    switch (this) {
      case ToastType.success:
      case ToastType.announcement:
        return Colors.white;
      case ToastType.failure:
        return Colors.black87;
    }
    return Colors.white;
  }
}
