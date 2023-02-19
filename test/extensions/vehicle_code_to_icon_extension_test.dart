import 'package:flutter_test/flutter_test.dart';
import 'package:lao_roadtax_esticker/src/extensions/extensions.dart';
import 'package:lao_roadtax_esticker/src/icon/road_tax_icons_icons.dart';

void main() {
  test(
    "convert vehicle code to icon data",
    () {
      expect("01".toIcon(), equals(RoadTaxIcons.motorcycle));
      expect("02".toIcon(), equals(RoadTaxIcons.suv));
      expect("03".toIcon(), equals(RoadTaxIcons.passenger));
      expect("04".toIcon(), equals(RoadTaxIcons.pickup));
      expect("05".toIcon(), equals(RoadTaxIcons.truck));
      expect("06".toIcon(), equals(RoadTaxIcons.trailer_truck));
    },
  );
}
