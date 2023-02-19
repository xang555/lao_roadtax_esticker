import 'package:flutter/widgets.dart';

import 'const.dart';
import 'data/road_tax_model.dart';
import 'drawer/drawer.dart';
import 'utils.dart';

class ToadTaxStickerWidget extends StatelessWidget {
  const ToadTaxStickerWidget({
    super.key,
    required this.data,
    this.size,
  });

  final Size? size;

  final RoadTaxData data;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ToadTaxPainter(data),
      size: size ?? const Size(baseTemplateImageWidth, baseTemplateImageHight),
    );
  }
}

/// road tax painter
class ToadTaxPainter extends CustomPainter {
  ToadTaxPainter(this.data);

  final RoadTaxData data;

  @override
  void paint(Canvas canvas, Size size) async {
    try {
      // draw sticker
      final RoadTaxDrawer drawSticker = DrawRoadTaxSticker(
        canvas: canvas,
        refactorX:
            calRefactor(newVal: size.width, originVal: baseTemplateImageWidth),
        refactorY:
            calRefactor(newVal: size.height, originVal: baseTemplateImageHight),
      );

      // draw background image
      await drawSticker.drawBackgroundImage();

      // ------- column 1 ------- //
      drawSticker.drawVehicleName(data.vehicleName);
      drawSticker.drawLicensePlate(
        licenseNumber: data.licensePlateNumber,
        provinceName: data.province,
      );
      drawSticker.drawLicenseType(data.licenseTypeName);
      drawSticker.drawTxDate(data.time);
      drawSticker.drawAmount(data.amount);

      // ------- column 2 ------- //
      drawSticker.drawYear(data.year);
      drawSticker.drawVehicleIcon(data.vehicleCode);
      drawSticker.drawEngineDisplacement(data.engineDisplacement);
      drawSticker.drawChassisNumber(data.chassisNumber);

      // ------- column 3 ------- //
      await drawSticker.drawQRcode(data.barcode);
      await drawSticker.drawBarcode(data.barcode);
    } catch (e) {
      print("error -------> $e");
      final textPaint = TextPainter(
        text: TextSpan(
          text: "Error $e",
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPaint.layout(maxWidth: size.width);
      textPaint.paint(canvas, Offset(size.width / 2, size.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
