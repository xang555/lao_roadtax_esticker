import 'package:flutter/services.dart';

abstract class RoadTaxDrawer {
  ///  draw background image;
  ///
  /// default background is default template
  Future<void> drawBackgroundImage([ByteData? byteData]);

  /// draw vehicle name
  void drawVehicleName(String vehicleName);

  /// draw license plate
  void drawLicensePlate(
      {required String licenseNumber, required String provinceName});

  /// draw license type
  void drawLicenseType(String licenseType);

  /// draw tx date
  void drawTxDate(DateTime dateTime);

  /// draw amount
  void drawAmount(String amount);

  /// draw year
  void drawYear(String year);

  /// draw vehicle icon
  void drawVehicleIcon(String vehicleCode);

  /// draw engine Displacement
  void drawEngineDisplacement(String engineDisplacement);

  /// draw Chassis number
  void drawChassisNumber(String chassisNumber);

  /// draw QrCode
  Future<void> drawQRcode(String data);

  /// draw barcode
  Future<void> drawBarcode(String data);
}
