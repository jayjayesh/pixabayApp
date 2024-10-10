import 'package:intl/intl.dart';

class AppUtility {
  static String formatNumberToCompactNumber(int views) {
    final formatter = NumberFormat.compact();
    return formatter.format(views);
  }
}