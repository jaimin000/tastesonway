import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pdf/pdf.dart';

class Utilities{

  Future<PdfColor> pdfTextColor(String imageUrl) async {
    var paletteGenerator =
    await PaletteGenerator.fromImageProvider(
      NetworkImage(imageUrl),
      filters: [],
      size: Size(1396, 2308),

      // I want the dominant color of the top left section of the image
      region: Offset.zero & Size(1396, 2308),
      maximumColorCount: 20,
    );

    var dominantColor = paletteGenerator.dominantColor?.color;
    var textColor = PdfColor.fromInt(0xFF000000);
    if (dominantColor != null) {
      textColor = dominantColor.computeLuminance() > 0.5
          ? PdfColor.fromInt(0xFF1E1E1E)
          : PdfColor.fromInt(0xFFFFFFFF);
    }
    return textColor;
  }

  Future<Color> menuTextColor(String imageUrl) async {
    print(imageUrl);
    var paletteGenerator =
    await PaletteGenerator.fromImageProvider(
      NetworkImage(imageUrl),
      filters: [],
      size: Size(1396, 2308),
      region: Offset.zero & Size(1396, 2308),
      maximumColorCount: 20,
    );

    var dominantColor = paletteGenerator.dominantColor?.color;
    var textColor = Colors.black;
    if (dominantColor != null) {
      textColor =
      dominantColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    }
    return textColor;
  }

}