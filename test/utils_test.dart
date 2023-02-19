import 'package:flutter_test/flutter_test.dart';
import 'package:lao_roadtax_esticker/src/utils.dart';

void main() {
  test(
    "calc scale factor",
    () {
      expect(calRefactor(newVal: 10, originVal: 2), 5.0);
    },
  );

  test("calc scale value by factor", () {
    expect(calScaleValue(x: 5, refactor: 2), 10);
  });

  test(
    "calc dx. dy center",
    () {
      expect(
        dXCenter(dx: 2, maxLayoutWidth: 10, paintWidth: 5),
        equals(4.5),
      );

      expect(
        dYCenter(dy: 2, maxLayoutHight: 10, paintHight: 5),
        equals(4.5),
      );
    },
  );

  test(
    "calculate offset conner point of rect",
    () {
      expect(
        offsetConnerRect(center: const Offset(5, 10), width: 100, hight: 50),
        equals(const Offset(-45, -15)),
      );
    },
  );
}
