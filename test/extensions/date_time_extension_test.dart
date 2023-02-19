import 'package:flutter_test/flutter_test.dart';
import 'package:lao_roadtax_esticker/src/extensions/extensions.dart';

void main() {
  test(
    "formate date time extension",
    () {
      expect(DateTime.tryParse("2023-01-02")?.format(), equals("02/01/2023"));
      expect(
        DateTime.tryParse("2022-12-20T16:12:49+07:00")?.format(),
        equals("20/12/2022"),
      );
    },
  );
}
