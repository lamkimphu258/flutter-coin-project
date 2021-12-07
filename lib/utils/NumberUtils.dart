import 'package:intl/intl.dart';

class NumberUtils {
  static String convertNumberToHumanReadable(dynamic number) {
    return NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '',
    ).format(number);
  }
}
