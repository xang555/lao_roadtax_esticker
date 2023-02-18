import 'package:flutter_test/flutter_test.dart';
import 'package:lao_roadtax_esticker/src/extensions/extensions.dart';

void main() {
  test(
    "formate amount",
    () {
      expect("1000".toAmount(), equals("1,000"));
    },
  );
}
