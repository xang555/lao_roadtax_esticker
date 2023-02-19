import 'package:flutter_test/flutter_test.dart';
import 'package:lao_roadtax_eticker/src/extensions/extensions.dart';

void main() {
  test(
    "formate amount",
    () {
      expect("100".toAmount(), equals("100"));
      expect("1000".toAmount(), equals("1,000"));
      expect("590000".toAmount(), equals("590,000"));
      expect("1000000".toAmount(), equals("1,000,000"));
      expect("59000.90".toAmount(), equals("59,001"));
    },
  );

  test(
    "formate string license number",
    () {
      expect("ກຍ5678".toLicensePlateNumber(), equals("ກຍ 5678"));
      expect("ກຍ 5678".toLicensePlateNumber(), equals("ກຍ 5678"));
      expect("ກຍ           5678".toLicensePlateNumber(), equals("ກຍ 5678"));
    },
  );
}
