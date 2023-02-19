import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:lao_roadtax_eticker/lao_roadtax_eticker.dart';

void main(List<String> args) async {
  try {
    final LaoRoadTaxSticker createSticker = CreateLaoRoadTaxSticker();
    final stickerByte = await createSticker.createSticker(
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

    if (stickerByte != null) {
      final imagePath = File('example_roadTaxSticker.png');
      if (!(await imagePath.exists())) {
        await imagePath.create();
      }
      // write to temporary directory
      await imagePath.writeAsBytes(stickerByte.buffer.asUint8List());
    }
  } catch (e) {
    debugPrint("error --------> $e");
  }
}
