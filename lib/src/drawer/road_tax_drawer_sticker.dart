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

  /// scale refactor
  final double refactor;

  /// implement draw road tax sticker
  ///
  /// [canvas] is canvas to draw
  /// [refactor] is refactor number
  DrawRoadTaxSticker({required this.canvas, required this.refactor})
      : _rectWidth = calScaleX(x: 265, refactor: refactor),
        _reactHight = calScaleX(x: 126, refactor: refactor),
        _normalFont = calScaleX(x: 30, refactor: refactor),
        _maxWidthTxDateAndAmount = calScaleX(x: 400, refactor: refactor);

  // rect conner point when draw license plate
  late Offset _rectConner;

  final double _rectWidth;

  final double _reactHight;

  final double _normalFont;

  final double _maxWidthTxDateAndAmount;

  /// load image from assets
  ///
  /// throw Exception
  Future<ui.Image> _loadImage<T>(T image, [int? width, int? hight]) async {
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

      final codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetHeight: hight,
        targetWidth: width,
      );
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
        calScaleX(x: 59, refactor: refactor),
        calScaleX(x: (370 + 42 * 2), refactor: refactor),
      ),
    );
  }

  @override
  Future<void> drawBackgroundImage(ByteData? byteData) async {
    try {
      ui.Image baseImage;
      if (byteData != null) {
        baseImage = await _loadImage<ByteData>(byteData);
      } else {
        baseImage = await _loadImage<String>("assets/stiker_tamplete.png");
      }
      canvas.drawImage(baseImage, const Offset(0.0, 0.0), Paint());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> drawBarcode(String data) async {
    try {
      final image = img.Image(
        calScaleX(x: 282, refactor: refactor).toInt(),
        calScaleX(x: 90, refactor: refactor).toInt(),
      );

      img.fill(image, img.getColor(0, 0, 0, 0));

      barcode_img.drawBarcode(
        image,
        barcode_img.Barcode.code128(),
        data,
        font: img.arial_24,
      );

      final codec = await ui.instantiateImageCodec(
        Uint8List.fromList(
          img.encodePng(image),
        ),
      );
      var frame = await codec.getNextFrame();
      canvas.drawImage(
        frame.image,
        Offset(
          calScaleX(x: 727, refactor: refactor),
          (calScaleX(x: 124, refactor: refactor) + _rectConner.dy) +
              calScaleX(x: 24, refactor: refactor),
        ),
        Paint(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void drawChassisNumber(String chassisNumber) {
    final chassisNumberTextPainter = TextPainter(
      text: TextSpan(
        text: 'ເລກຖັງ: $chassisNumber',
        style: textStyle.copyWith(
          fontSize: _normalFont - calScaleX(x: 5, refactor: refactor),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    chassisNumberTextPainter.layout();
    chassisNumberTextPainter.paint(
      canvas,
      Offset(
        calScaleX(x: 377, refactor: refactor),
        calScaleX(x: ((332 + 75) + 50), refactor: refactor),
      ),
    );
  }

  @override
  void drawEngineDisplacement(String engineDisplacement) {
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
    engineDisplacementTextPainter.layout();
    engineDisplacementTextPainter.paint(
      canvas,
      Offset(
        calScaleX(x: 490, refactor: refactor),
        calScaleX(x: (332 + 75), refactor: refactor),
      ),
    );
  }

  @override
  void drawLicensePlate({
    required String licenseNumber,
    required String provinceName,
  }) {
    final recCenterOffset = Offset(
      calScaleX(x: 197, refactor: refactor),
      calScaleX(x: 300, refactor: refactor),
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
      const Radius.circular(15),
    );
    final rRectPaint = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(rRect, rRectPaint);

    // draw province
    final provinceTextPainter = TextPainter(
      text: TextSpan(
        text: provinceName,
        style: textStyle.copyWith(
          fontSize: calScaleX(x: 32, refactor: refactor),
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
          dx: calScaleX(x: 76, refactor: refactor),
          maxLayoutWidth: _rectWidth,
          paintWidth: provinceTextPainter.width,
        ),
        calScaleX(x: 245, refactor: refactor),
      ),
    );

    // draw license
    final licenseTextPainter = TextPainter(
      text: TextSpan(
        text: licenseNumber.toLicensePlateNumber(),
        style: textStyle.copyWith(
          fontSize: calScaleX(x: 48, refactor: refactor),
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
          dx: calScaleX(x: 76, refactor: refactor),
          maxLayoutWidth: _rectWidth,
          paintWidth: licenseTextPainter.width,
        ),
        calScaleX(x: 295, refactor: refactor),
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
          dx: calScaleX(x: 62, refactor: refactor),
          maxLayoutWidth: _rectWidth,
          paintWidth: licenseTypeTextPainter.width,
        ),
        calScaleX(x: 370, refactor: refactor),
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
        calScaleX(x: 120, refactor: refactor),
      );
      canvas.drawImage(
        qImageData,
        Offset(calScaleX(x: 804, refactor: refactor), _rectConner.dy),
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
        calScaleX(x: 59, refactor: refactor),
        calScaleX(x: (370 + 42), refactor: refactor),
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
          fontSize: calScaleX(x: 100, refactor: refactor),
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
        calScaleX(x: 490.0, refactor: refactor),
        calScaleX(x: 330, refactor: refactor),
      ),
    );
  }

  @override
  void drawVehicleName(String vehicleName) {
    try {
      final fontSize = calScaleX(x: 42, refactor: refactor);
      final maxWidth = calScaleX(x: 362, refactor: refactor);

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
            dx: calScaleX(x: 32, refactor: refactor),
            maxLayoutWidth: maxWidth,
            paintWidth: carModelTextPainter.width,
          ),
          dYCenter(
            dy: calScaleX(x: 175, refactor: refactor),
            maxLayoutHight: calScaleX(x: 62, refactor: refactor),
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
    final maxWidthYear = calScaleX(x: 434, refactor: refactor);

    final yearTextPainter = TextPainter(
      text: TextSpan(
        text: year,
        style: textStyle.copyWith(
          fontSize: calScaleX(x: 132, refactor: refactor),
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
          dx: calScaleX(x: 342, refactor: refactor),
          maxLayoutWidth: maxWidthYear,
          paintWidth: yearTextPainter.width,
        ),
        _rectConner.dy - (yearTextPainter.height * 0.25),
      ),
    );
  }
}
