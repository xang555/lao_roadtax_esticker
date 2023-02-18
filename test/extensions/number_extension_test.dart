import 'package:flutter_test/flutter_test.dart';
import 'package:lao_roadtax_esticker/src/extensions/extensions.dart';
import 'package:lao_roadtax_esticker/src/utils.dart';

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
    "calculate refactor",
    () {
      double width = 1063;
      double hight = 531;

      double xwidth = 540;
      double yhight = 271;

      // final xrefactor = calRefactor(width: width, hight: hight);
      // final yrefactor = calRefactor(width: hight, hight: width);
      // print("refactor------> $refactor");
      print("xwidth-----------> ${32 * (xwidth / width)}");
      print("ywidth-----------> ${175 * (yhight / hight)}");
    },
  );
}
