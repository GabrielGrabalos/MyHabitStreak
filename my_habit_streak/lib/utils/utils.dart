import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatTime(BuildContext context, DateTime time) {
    // Ensure the DateTime is in the device local timezone
    final localTime = time.toLocal();

    // Get locale and 24h preference from the device
    final locale = Localizations.localeOf(context).toString();
    final use24Hour = MediaQuery.of(context).alwaysUse24HourFormat;

    // Use intl for reliable locale-aware formatting.
    // DateFormat.Hm -> 24-hour like "18:30"
    // DateFormat.jm -> 12-hour like "6:30 PM"
    final formatter = use24Hour ? DateFormat.Hm(locale) : DateFormat.jm(locale);
    return formatter.format(localTime);
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
}
