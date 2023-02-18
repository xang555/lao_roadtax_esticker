import 'package:flutter_test/flutter_test.dart';
import 'package:lao_roadtax_esticker/lao_roadtax_eticker.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    "create road tax sticker",
    () async {
      try {
        final LaoRoadTaxSticker createSticker = CreateLaoRoadTaxSticker();
        final sticker = await createSticker.createSticker(
          RoadTaxData(
            vehicleCode: "01",
            vehicleName: "ລົດຈັກ",
            licensePlateNumber: "ຍຫ 5578",
            licenseTypeName: "ເອກະຊົນ",
            province: "ກຳແພງນະຄອນ",
            chassisNumber: "RLHHC1207BY468177",
            engineDisplacement: "200",
            barcode: "M191090001020",
            amount: "1000",
            year: "2023",
            time: DateTime.now(),
          ),
        );

        expect(sticker, isNotNull);
      } catch (e) {
        rethrow;
      }
    },
  );
}
