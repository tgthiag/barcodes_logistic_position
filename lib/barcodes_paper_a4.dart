import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class BarcodesPapera4 extends StatelessWidget{
  final TextEditingController? txtController;
  final int intHolder;
   final String? stringHolder;

  BarcodesPapera4({super.key, required this.txtController, required this.intHolder, required this.stringHolder});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  width: 180,
                  height: 58,
                  child: SfBarcodeGenerator(
                    value: "${txtController?.text}.5",
                    showValue: true,
                    textStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 30),
                  width: 180,
                  height: 58,
                  child: SfBarcodeGenerator(
                    value: "${txtController?.text}.4",
                    showValue: true,
                    textStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 30),
                  width: 180,
                  height: 58,
                  child: SfBarcodeGenerator(
                    value: "${txtController?.text}.3",
                    showValue: true,
                    textStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 30),
                  width: 180,
                  height: 58,
                  child: SfBarcodeGenerator(
                    value: "${txtController?.text}.2",
                    showValue: true,
                    textStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: 180,
                  height: 58,
                  child: SfBarcodeGenerator(
                    value: "${txtController?.text}.1",
                    showValue: true,
                    textStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    width: 180,
                    height: 60,
                    margin: const EdgeInsets.only(top: 10),
                    child: const Image(
                        image: AssetImage("assets/logo.png"))),
              ]),
          Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: 180,
              height: 58,
              child: SfBarcodeGenerator(
                value: (txtController!.text.isNotEmpty &&
                    txtController?.text[1] == "0" && txtController?.text[2] != "9")
                    ? "${"${stringHolder}0$intHolder"}.5"
                    : "${stringHolder! + intHolder.toString()}.5",
                showValue: true,
                textStyle:
                const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              width: 180,
              height: 58,
              child: SfBarcodeGenerator(
                value: (txtController!.text.isNotEmpty &&
                    txtController?.text[1] == "0" && txtController?.text[2] != "9")
                    ? "${"${stringHolder}0$intHolder"}.4"
                    : "${stringHolder! + intHolder.toString()}.4",
                showValue: true,
                textStyle:
                const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              width: 180,
              height: 58,
              child: SfBarcodeGenerator(
                value: (txtController!.text.isNotEmpty &&
                    txtController?.text[1] == "0" && txtController?.text[2] != "9")
                    ? "${"${stringHolder}0$intHolder"}.3"
                    : "${stringHolder! + intHolder.toString()}.3",
                showValue: true,
                textStyle:
                const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              width: 180,
              height: 58,
              child: SfBarcodeGenerator(
                value: (txtController!.text.isNotEmpty &&
                    txtController?.text[1] == "0" && txtController?.text[2] != "9")
                    ? "${"${stringHolder}0$intHolder"}.2"
                    : "${stringHolder! + intHolder.toString()}.2",
                showValue: true,
                textStyle:
                const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: 180,
              height: 58,
              child: SfBarcodeGenerator(
                value: (txtController!.text.isNotEmpty &&
                    txtController?.text[1] == "0" && txtController?.text[2] != "9")
                    ? "${"${stringHolder}0$intHolder"}.1"
                    : "${stringHolder! + intHolder.toString()}.1",
                showValue: true,
                textStyle:
                const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                width: 180,
                height: 60,
                margin: const EdgeInsets.only(top: 10),
                child: const Image(
                    image: AssetImage("assets/logo.png"))),
          ]),
        ],
      ),
    );
  }

}