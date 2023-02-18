class RoadTaxData {
  /// road tax data model
  RoadTaxData({
    required this.vehicleCode,
    required this.vehicleName,
    required this.licensePlateNumber,
    required this.licenseTypeName,
    required this.province,
    required this.chassisNumber,
    required this.engineDisplacement,
    required this.barcode,
    required this.amount,
    required this.year,
    required this.time,
  });

  final String vehicleCode;
  final String vehicleName;
  final String licensePlateNumber;
  final String licenseTypeName;
  final String province;
  final String chassisNumber;
  final String engineDisplacement;
  final String barcode;
  final String amount;
  final String year;
  final DateTime time;
}
