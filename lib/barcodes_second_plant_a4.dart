import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class BarcodesSecondPlantA4 extends StatelessWidget {
  final TextEditingController? txtController;
  final String positioning;

  static const myFont = 'timesbd';
  static const double myFontSize = 65.0;
  static const double barcodeWidth = 280.0;
  static const double barcodeHeight = 140.0;

  BarcodesSecondPlantA4(
      {super.key, required this.txtController, required this.positioning});

  String? barcodeTextMount(streetNValue, positioning, howTall) {
    return "${txtController!.text}.$howTall$positioning";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: barcodeWidth,
                      height: barcodeHeight,
                      child: SfBarcodeGenerator(
                        value: barcodeTextMount(txtController, positioning, 3),
                        showValue: true,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: myFontSize,
                            fontFamily: myFont),
                      ),
                    ),
                    const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 90,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 70),
                      width: barcodeWidth,
                      height: barcodeHeight,
                      child: SfBarcodeGenerator(
                        value: barcodeTextMount(txtController, positioning, 2),
                        showValue: true,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: myFontSize,
                            fontFamily: myFont),
                      ),
                    ),
                    Transform.rotate(
                      angle: -math.pi / 5,
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 90,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: barcodeWidth,
                      height: barcodeHeight,
                      child: SfBarcodeGenerator(
                        value: barcodeTextMount(txtController, positioning, 1),
                        showValue: true,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: myFontSize,
                            fontFamily: myFont),
                      ),
                    ),
                    const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 90,
                      ),
                    )
                  ],
                ),
              ]),
    );
  }
}
