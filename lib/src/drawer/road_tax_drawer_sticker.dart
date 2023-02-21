import 'dart:ui' as ui;

import 'package:barcode_image/barcode_image.dart' as barcode_img;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:qr_flutter/qr_flutter.dart';

import '../const.dart';
import '../extensions/extensions.dart';
import '../utils.dart';
import 'road_tax_drawer.dart';

class DrawRoadTaxSticker extends RoadTaxDrawer {
  /// canvas to draw
  final Canvas canvas;

  /// scale refactor X
  final double refactorX;
  final double refactorY;

  /// implement draw road tax sticker
  ///
  /// [canvas] is canvas to draw
  /// [refactor] is refactor number
  DrawRoadTaxSticker({
    required this.canvas,
    required this.refactorX,
    required this.refactorY,
  })  : _rectWidth = calScaleValue(x: 265, refactor: refactorX),
        _reactHight = calScaleValue(x: 126, refactor: refactorY),
        _normalFont = calScaleValue(x: 30, refactor: refactorY),
        _maxWidthTxDateAndAmount = calScaleValue(x: 400, refactor: refactorX);

  // rect conner point when draw license plate
  late Offset _rectConner;

  final double _rectWidth;

  final double _reactHight;

  final double _normalFont;

  final double _maxWidthTxDateAndAmount;

  /// load image from assets
  ///
  /// throw Exception
  Future<ui.Image> _loadImage<T>(T image) async {
    try {
      ByteData data;

      if (image is String) {
        data = await rootBundle.load(image);
      } else if (image is ByteData) {
        data = image;
      } else {
        throw Exception(
          "image data type support two types byeData and string asset path",
        );
      }

      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      var frame = await codec.getNextFrame();
      return frame.image;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void drawAmount(String amount) {
    final amountTextPainter = TextPainter(
      text: TextSpan(
        text: 'ຈຳນວນເງິນ: ${amount.toAmount()} ກີບ',
        style: textStyle.copyWith(
          fontSize: _normalFont,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    amountTextPainter.layout(
      minWidth: 0,
      maxWidth: _maxWidthTxDateAndAmount,
    );
    amountTextPainter.paint(
      canvas,
      Offset(
        calScaleValue(x: 59, refactor: refactorX),
        calScaleValue(x: (370 + 42 * 2), refactor: refactorY),
      ),
    );
  }

  @override
  Future<void> drawBackgroundImage([ByteData? byteData]) async {
    try {
      ui.Image baseImage;
      if (byteData != null) {
        baseImage = await _loadImage<ByteData>(byteData);
      } else {
        baseImage = await _loadImage<String>(
          "packages/lao_roadtax_eticker/assets/stiker_tamplete.png",
        );
      }
      canvas.drawImage(baseImage, const Offset(0.0, 0.0), Paint());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> drawBarcode(String data) async {
    try {
      final barcodeWidth = calScaleValue(x: 282, refactor: refactorX).toInt();
      final barcodeHight = calScaleValue(x: 70, refactor: refactorY).toInt();

      final image = img.Image(barcodeWidth, barcodeHight);

      img.fill(image, img.getColor(0, 0, 0, 0));

      barcode_img.drawBarcode(
        image,
        barcode_img.Barcode.code128(),
        data,
      );

      final codec = await ui.instantiateImageCodec(
        Uint8List.fromList(
          img.encodePng(image),
        ),
      );

      final dxBarcode = calScaleValue(x: 727, refactor: refactorX);
      final dyBarcode =
          ((calScaleValue(x: 124, refactor: refactorY) + _rectConner.dy) +
              calScaleValue(x: 24, refactor: refactorY));

      var frame = await codec.getNextFrame();
      canvas.drawImage(
        frame.image,
        Offset(
          dxBarcode,
          dyBarcode,
        ),
        Paint(),
      );

      // draw barcode text
      final barcodeTextPainter = TextPainter(
        text: TextSpan(
          text: data,
          style: textStyle.copyWith(
            fontSize: _normalFont,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      barcodeTextPainter.layout(minWidth: 0, maxWidth: barcodeWidth.toDouble());
      barcodeTextPainter.paint(
        canvas,
        Offset(
          dXCenter(
            dx: dxBarcode,
            maxLayoutWidth: barcodeWidth.toDouble(),
            paintWidth: barcodeTextPainter.width,
          ),
          dyBarcode + calScaleValue(x: 70, refactor: refactorY),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void drawChassisNumber(String chassisNumber) {
    final maxLayoutWidth = calScaleValue(x: 336, refactor: refactorX);

    final chassisNumberTextPainter = TextPainter(
      text: TextSpan(
        text: 'ເລກຖັງ: $chassisNumber',
        style: textStyle.copyWith(
          fontSize: _normalFont - calScaleValue(x: 5, refactor: refactorY),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    chassisNumberTextPainter.layout(minWidth: 0, maxWidth: maxLayoutWidth);
    chassisNumberTextPainter.paint(
      canvas,
      Offset(
        dXCenter(
          dx: calScaleValue(x: 377, refactor: refactorX),
          maxLayoutWidth: maxLayoutWidth,
          paintWidth: chassisNumberTextPainter.width,
        ),
        calScaleValue(x: ((332 + 75) + 50), refactor: refactorY),
      ),
    );
  }

  @override
  void drawEngineDisplacement(String engineDisplacement) {
    final maxWidthLayout = calScaleValue(x: 307, refactor: refactorX);

    final engineDisplacementTextPainter = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: engineDisplacement,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: ' CC',
          ),
        ],
        style: textStyle.copyWith(
          fontSize: _normalFont,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    engineDisplacementTextPainter.layout(
      minWidth: 0,
      maxWidth: maxWidthLayout,
    );
    engineDisplacementTextPainter.paint(
      canvas,
      Offset(
        dXCenter(
          dx: calScaleValue(x: 490, refactor: refactorX),
          maxLayoutWidth: maxWidthLayout,
          paintWidth: engineDisplacementTextPainter.width,
        ),
        calScaleValue(x: (332 + 75), refactor: refactorY),
      ),
    );
  }

  @override
  void drawLicensePlate({
    required String licenseNumber,
    required String provinceName,
  }) {
    final recCenterOffset = Offset(
      calScaleValue(x: 197, refactor: refactorX),
      calScaleValue(x: 300, refactor: refactorY),
    );

    // rect conner offset
    _rectConner = offsetConnerRect(
      center: recCenterOffset,
      width: _rectWidth,
      hight: _reactHight,
    );

    // draw rect
    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: recCenterOffset, width: _rectWidth, height: _reactHight),
      Radius.circular(calScaleValue(x: 15, refactor: refactorX)),
    );
    final rRectPaint = Paint()
      ..strokeWidth = calScaleValue(x: 4, refactor: refactorY)
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(rRect, rRectPaint);

    // draw province
    final provinceTextPainter = TextPainter(
      text: TextSpan(
        text: provinceName,
        style: textStyle.copyWith(
          fontSize: calScaleValue(x: 32, refactor: refactorY),
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    provinceTextPainter.layout(
      minWidth: 0,
      maxWidth: _rectWidth,
    );

    provinceTextPainter.paint(
      canvas,
      Offset(
        dXCenter(
          dx: calScaleValue(x: 72, refactor: refactorX),
          maxLayoutWidth: _rectWidth,
          paintWidth: provinceTextPainter.width,
        ),
        calScaleValue(x: 245, refactor: refactorY),
      ),
    );

    // draw license
    final licenseTextPainter = TextPainter(
      text: TextSpan(
        text: licenseNumber.toLicensePlateNumber(),
        style: textStyle.copyWith(
          fontSize: calScaleValue(x: 48, refactor: refactorY),
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    licenseTextPainter.layout(
      minWidth: 0,
      maxWidth: _rectWidth,
    );
    licenseTextPainter.paint(
      canvas,
      Offset(
        dXCenter(
          dx: calScaleValue(x: 72, refactor: refactorX),
          maxLayoutWidth: _rectWidth,
          paintWidth: licenseTextPainter.width,
        ),
        calScaleValue(x: 295, refactor: refactorY),
      ),
    );
  }

  @override
  void drawLicenseType(String licenseType) {
    final licenseTypeTextPainter = TextPainter(
      text: TextSpan(
        text: 'ປ້າຍ $licenseType',
        style: textStyle.copyWith(
          fontSize: _normalFont,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    licenseTypeTextPainter.layout(
      minWidth: 0,
      maxWidth: _rectWidth,
    );
    licenseTypeTextPainter.paint(
      canvas,
      Offset(
        dXCenter(
          dx: calScaleValue(x: 62, refactor: refactorX),
          maxLayoutWidth: _rectWidth,
          paintWidth: licenseTypeTextPainter.width,
        ),
        calScaleValue(x: 370, refactor: refactorY),
      ),
    );
  }

  @override
  Future<void> drawQRcode(String data) async {
    try {
      final pq = QrPainter(
        data: "https://str.mof.gov.la/roadtax/verify/$data",
        version: QrVersions.auto,
      );
      final qImageData = await pq.toImage(
        calScaleValue(x: 120, refactor: refactorX),
      );
      canvas.drawImage(
        qImageData,
        Offset(calScaleValue(x: 804, refactor: refactorX), _rectConner.dy),
        Paint(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void drawTxDate(DateTime dateTime) {
    final dateTextPainter = TextPainter(
      text: TextSpan(
        text: 'ວັນທີຊຳລະ: ${dateTime.format()}',
        style: textStyle.copyWith(
          fontSize: _normalFont,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    dateTextPainter.layout(
      minWidth: 0,
      maxWidth: _maxWidthTxDateAndAmount,
    );
    dateTextPainter.paint(
      canvas,
      Offset(
        calScaleValue(x: 59, refactor: refactorX),
        calScaleValue(x: (370 + 42), refactor: refactorY),
      ),
    );
  }

  @override
  void drawVehicleIcon(String vehicleCode) {
    final icon = vehicleCode.toIcon();
    final iconCarTextPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: textStyle.copyWith(
          fontSize: calScaleValue(x: 100, refactor: refactorY),
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    iconCarTextPainter.layout();
    iconCarTextPainter.paint(
      canvas,
      Offset(
        calScaleValue(x: 490.0, refactor: refactorX),
        calScaleValue(x: 330, refactor: refactorY),
      ),
    );
  }

  @override
  void drawVehicleName(String vehicleName) {
    try {
      final fontSize = calScaleValue(x: 42, refactor: refactorY);
      final maxWidth = calScaleValue(x: 362, refactor: refactorX);

      final carModelTextPainter = TextPainter(
        text: TextSpan(
          text: vehicleName,
          style: textStyle.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      carModelTextPainter.layout(
        minWidth: 0,
        maxWidth: maxWidth,
      );
      carModelTextPainter.paint(
        canvas,
        Offset(
          dXCenter(
            dx: calScaleValue(x: 32, refactor: refactorX),
            maxLayoutWidth: maxWidth,
            paintWidth: carModelTextPainter.width,
          ),
          dYCenter(
            dy: calScaleValue(x: 175, refactor: refactorY),
            maxLayoutHight: calScaleValue(x: 62, refactor: refactorY),
            paintHight: carModelTextPainter.height,
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void drawYear(String year) {
    final maxWidthYear = calScaleValue(x: 434, refactor: refactorX);

    final yearTextPainter = TextPainter(
      text: TextSpan(
        text: year,
        style: textStyle.copyWith(
          fontSize: calScaleValue(x: 132, refactor: refactorY),
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    yearTextPainter.layout(
      minWidth: 0,
      maxWidth: maxWidthYear,
    );
    yearTextPainter.paint(
      canvas,
      Offset(
        dXCenter(
          dx: calScaleValue(x: 342, refactor: refactorX),
          maxLayoutWidth: maxWidthYear,
          paintWidth: yearTextPainter.width,
        ),
        _rectConner.dy - (yearTextPainter.height * 0.25),
      ),
    );
  }
}
