import 'package:intl/intl.dart';

/// number formate extension
extension NumberExtension on String {
  /// formate amount
  String toAmount([String pattern = '#,##0', String? locale]) {
    var f = NumberFormat(pattern, locale);
    final amountNumber = double.tryParse(this) ?? 0.0;
    return f.format(amountNumber);
  }

  /// Format license plate number from `aa1111` to `aa 1111`.
  String toLicensePlateNumber() {
    var licensePlateNumber = this;
    licensePlateNumber = licensePlateNumber.replaceAll(" ", "");
    if (licensePlateNumber.length < 2) return licensePlateNumber;
    return "${licensePlateNumber.substring(0, 2)} ${licensePlateNumber.substring(2)}";
  }
}
