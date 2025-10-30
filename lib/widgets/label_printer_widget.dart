import 'package:flutter/material.dart';

class LabelPrinterWidget extends StatelessWidget {
  final String name;
  final String designation;

  LabelPrinterWidget({required this.name, required this.designation});

  // Function to calculate the best text size to fit in the label
  double getBestFontSize(String text, double width) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(fontSize: 30)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: width);

    double fontSize = 30;
    while (textPainter.size.width > width && fontSize > 5) {
      fontSize -= 1;
      textPainter = TextPainter(
        text: TextSpan(text: text, style: TextStyle(fontSize: fontSize)),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(maxWidth: width);
    }

    return fontSize;
  }

  @override
  Widget build(BuildContext context) {
    double labelWidth = 864; // In pixels
    double labelHeight = 203; // In pixels

    double nameFontSize = getBestFontSize(name, labelWidth);
    double designationFontSize = getBestFontSize(designation, labelWidth);

    return Container(
      width: labelWidth,
      height: labelHeight,
      color: Colors.white,
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style:
                TextStyle(fontSize: nameFontSize, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            designation,
            style: TextStyle(fontSize: designationFontSize),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
