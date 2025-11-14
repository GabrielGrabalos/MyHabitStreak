import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatTime(BuildContext context, DateTime time) {
    if (shouldUseAMPM()) {
      final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
      final ampm = time.hour >= 12 ? 'pm' : 'am';
      final minute = time.minute.toString().padLeft(2, '0');
      return '$hour:$minute$ampm';
    }

    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static // Ugly, but works for now:
      String formatDate(String dateKey, {DateTime? dateTime}) {
    final date = dateTime ?? DateTime.parse(dateKey);

    // Try to get the current locale (e.g., "en_US", "en_GB", "fr_FR", etc.)
    final locale = Platform.localeName;
    final region = locale.split('_').length > 1 ? locale.split('_')[1] : 'US';

    // Decide format pattern based on region
    String pattern;
    switch (region.toUpperCase()) {
      case 'US': // 🇺🇸
        pattern = 'MM/dd/yyyy';
        break;
      case 'GB': // 🇬🇧
      case 'FR': // 🇫🇷
      case 'DE': // 🇩🇪
      case 'ES': // 🇪🇸
      case 'IT': // 🇮🇹
      case 'NL': // 🇳🇱
      case 'SE': // 🇸🇪
      case 'NO': // 🇳🇴
      case 'DK': // 🇩🇰
      case 'FI': // 🇫🇮
        pattern = 'dd/MM/yyyy';
        break;
      case 'JP': // 🇯🇵
      case 'KR': // 🇰🇷
      case 'CN': // 🇨🇳
        pattern = 'yyyy/MM/dd';
        break;
      default: // fallback
        pattern = 'dd/MM/yyyy';
    }

    return DateFormat(pattern).format(date);
  }

  static bool shouldUseAMPM() {
    // Simple check based on the current locale
    final locale = Platform.localeName;
    final region = locale.split('_').length > 1 ? locale.split('_')[1] : 'US';

    // Regions that typically use AM/PM
    const ampmRegions = {'US', 'PH', 'CA', 'AU', 'NZ'};

    return ampmRegions.contains(region.toUpperCase());
  }
}
