import 'package:intl/intl.dart';

/// number formate extension
extension NumberExtension on String {
  /// formate amount
  String toAmount([String pattern = '#,##0', String locale = "lo_LA"]) {
    var f = NumberFormat(pattern, locale);
    return f.format(this);
  }

  /// Format license plate number from `aa1111` to `aa 1111`.
  String toLicensePlateNumber() {
    var licensePlateNumber = this;
    licensePlateNumber = licensePlateNumber.replaceAll(" ", "");
    if (licensePlateNumber.length < 2) return licensePlateNumber;
    return "${licensePlateNumber.substring(0, 2)} ${licensePlateNumber.substring(2)}";
  }
}
