import 'package:flutter/material.dart';

import '../icon/road_tax_icons_icons.dart';

extension VehicleCodeToIcon on String {
  /// convert vehicle code to car icon
  IconData toIcon() {
    switch (this) {
      case "01":
        return RoadTaxIcons.motorcycle;
      case "02":
        return RoadTaxIcons.suv;
      case "03":
        return RoadTaxIcons.passenger;
      case "04":
        return RoadTaxIcons.pickup;
      case "05":
        return RoadTaxIcons.truck;
      case "06":
        return RoadTaxIcons.trailer_truck;
      case "07":
        return RoadTaxIcons.trailer;
      case "08":
        return RoadTaxIcons.container_truck;
      case "09":
        return RoadTaxIcons.mine_truck;
      case "10":
        return RoadTaxIcons.mid_truck;
      case "11":
        return RoadTaxIcons.cementl_truck;
      case "12":
        return RoadTaxIcons.mini_truck;
      case "13":
        return RoadTaxIcons.forklifts;
      case "14":
        return RoadTaxIcons.petrol_truck;
      case "15":
        return RoadTaxIcons.jumbo;
      case "16":
        return RoadTaxIcons.tuk_tuk;
      case "17":
        return RoadTaxIcons.bus;
      case "18":
        return RoadTaxIcons.van;
      case "19":
        return RoadTaxIcons.mini_bus;
      case "20":
        return RoadTaxIcons.van;
      default:
        return Icons.question_mark;
    }
  }
}
