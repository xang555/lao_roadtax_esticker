# lao_roadtax_esticker

[![lao_roadtax_esticker](https://github.com/xang555/lao_roadtax_esticker/actions/workflows/dart.yml/badge.svg)](https://github.com/xang555/lao_roadtax_esticker/actions/workflows/dart.yml)

Flutter package create lao road tax E-sticker

![sticker](https://github.com/xang555/lao_roadtax_esticker/blob/master/images/sticker.jpeg)

>pull requests is welcome


## Install

add `lao_roadtax_esticker` to `pubspec.yaml`

```yaml
lao_roadtax_esticker:<release>
```

then add theses fonts from this package to your project

```yaml
  fonts:
    - family: PhetsarathOT
      fonts:
        - asset: packages/lao_roadtax_eticker/fonts/Phetsarath_OT.ttf
    - family:  RoadTaxIcons
      fonts:
       - asset: packages/lao_roadtax_eticker/fonts/RoadTaxIcons.ttf
```

## Usage

### **Using default template**

```dart
    final LaoRoadTaxSticker createSticker = CreateLaoRoadTaxSticker();

    final stickerByte = createSticker.createSticker(
      RoadTaxData(
        vehicleCode: "01",
        vehicleName: "ລົດຈັກ",
        licensePlateNumber: "ຍຫ 5578",
        licenseTypeName: "ເອກະຊົນ",
        province: "ກຳແພງນະຄອນ",
        chassisNumber: "RLHHC1207BY468177",
        engineDisplacement: "200",
        barcode: "M191090001020",
        amount: "550000",
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
```

### **Using your background image template**

```dart
   final data = await rootBundle.load("assets/<your_road_tax_background_image_template>.png");

    final LaoRoadTaxSticker createSticker = CreateLaoRoadTaxSticker(roadTaxBackgroundTemplateImage: data);

    final stickerByte = createSticker.createSticker(
      RoadTaxData(
        vehicleCode: "01",
        vehicleName: "ລົດຈັກ",
        licensePlateNumber: "ຍຫ 5578",
        licenseTypeName: "ເອກະຊົນ",
        province: "ກຳແພງນະຄອນ",
        chassisNumber: "RLHHC1207BY468177",
        engineDisplacement: "200",
        barcode: "M191090001020",
        amount: "550000",
        year: "2023",
        time: DateTime.now(),
      ),
    );
```

### **Save sticker to gallery**

if you need to save sticker image to gallery please using [gallery_saver](https://pub.dev/packages/gallery_saver)

```dart

  void saveSticker() async {
    try {
      final imageByte = await _createStickerFromLib();

      if (imageByte != null) {
        final directory = await getTemporaryDirectory();
        final imagePath = File('${directory.path}/roadTaxSticker.png');
        if (!(await imagePath.exists())) {
          await imagePath.create();
        }
        // write to temporary directory
        await imagePath.writeAsBytes(imageByte.buffer.asUint8List());

        final saveImage =
            await GallerySaver.saveImage(imagePath.path, albumName: "Road Tax");

        // delete image from temporary directory
        await imagePath.delete();
        if (saveImage == true) {
          print("---------- save success");
        }
      }
    } catch (e) {
      print("----------$e");
    }
  }

  Future<ByteData?> _createStickerFromLib() async {
    final data = await rootBundle.load("assets/tam3.png");

    final LaoRoadTaxSticker createSticker =
        CreateLaoRoadTaxSticker(roadTaxBackgroundTemplateImage: data);
    final stickerByte = createSticker.createSticker(
      RoadTaxData(
        vehicleCode: "01",
        vehicleName: "ລົດຈັກ",
        licensePlateNumber: "ຍຫ 5578",
        licenseTypeName: "ເອກະຊົນ",
        province: "ກຳແພງນະຄອນ",
        chassisNumber: "RLHHC1207BY468177",
        engineDisplacement: "200",
        barcode: "M191090001020",
        amount: "550000",
        year: "2023",
        time: DateTime.now(),
      ),
    );

    return stickerByte;
  }

```

### **Display sticker**

```dart

class StrikerRoadTax extends StatelessWidget {
  const StrikerRoadTax({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ByteData?>(
      future: _createStickerFromLib(),
      builder: (BuildContext context, AsyncSnapshot<ByteData?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Image.memory(Uint8List.view(snapshot.data!.buffer));
      },
    );
  }
}


Future<ByteData?> _createStickerFromLib() async {
  final data = await rootBundle.load("assets/tam3.png");

  final LaoRoadTaxSticker createSticker =
      CreateLaoRoadTaxSticker(roadTaxBackgroundTemplateImage: data);
  final stickerByte = createSticker.createSticker(
    RoadTaxData(
      vehicleCode: "01",
      vehicleName: "ລົດຈັກ",
      licensePlateNumber: "ຍຫ 5578",
      licenseTypeName: "ເອກະຊົນ",
      province: "ກຳແພງນະຄອນ",
      chassisNumber: "RLHHC1207BY468177",
      engineDisplacement: "200",
      barcode: "M191090001020",
      amount: "550000",
      year: "2023",
      time: DateTime.now(),
    ),
  );

  return stickerByte;
}

```

## Donation

if this package useful you can donate me by

**Bank**

<img src="https://github.com/xang555/lao_roadtax_esticker/blob/master/images/laoQR.png" width="50%" height="50%">

**Binance Pay**

<img src="https://github.com/xang555/lao_roadtax_esticker/blob/master/images/binance_pay.png" width="50%" height="50%">
