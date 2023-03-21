import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController txtController = TextEditingController();
  var stringHolder = "";
  var intHolder = 0;
  final GlobalKey globalKey = GlobalKey();

  void _setTextValue() {
    setState(() {
      txtController.text = txtController.text.toString().toUpperCase();
      stringHolder =  txtController.text.toString().toUpperCase()[0];
      intHolder = int.parse(txtController.text.toString().replaceAll(RegExp('[^0-9]'), '')) + 1;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(color: Colors.white, fontSize: 34.0),
              ),
              Text(
                "Thiago Carvalho V1.13",
                style: TextStyle(color: Colors.grey[300], fontSize: 8.0),
              ),
            ]
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              'Digite a rua e a posição:',
            ),
            TextField(
              controller: txtController,
              maxLines: 1,
              textAlign: TextAlign.center,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Ex: A1...",
              ),
              onSubmitted: (value) => _setTextValue(),
            ),
            Container(
                width: 400,
                height: 600,
                margin: const EdgeInsets.all(5),
                child: RepaintBoundary(
                  key: globalKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              width: 170,
                              height: 60,
                              child: SfBarcodeGenerator(
                                value: "${txtController.text}.5",
                                showValue: true,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 30),
                              width: 170,
                              height: 60,
                              child: SfBarcodeGenerator(
                                value: "${txtController.text}.4",
                                showValue: true,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 30),
                              width: 170,
                              height: 60,
                              child: SfBarcodeGenerator(
                                value: "${txtController.text}.3",
                                showValue: true,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 30),
                              width: 170,
                              height: 60,
                              child: SfBarcodeGenerator(
                                value: "${txtController.text}.2",
                                showValue: true,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              width: 170,
                              height: 60,
                              child: SfBarcodeGenerator(
                                value: "${txtController.text}.1",
                                showValue: true,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                width: 150,
                                height: 50,
                                margin: const EdgeInsets.only(top: 10),
                                child: const Image(
                                    image: AssetImage("assets/logo.png"))),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              width: 170,
                              height: 60,
                              child: SfBarcodeGenerator(
                                value: "${stringHolder + intHolder.toString()}.5",
                                showValue: true,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 30),
                              width: 170,
                              height: 60,
                              child: SfBarcodeGenerator(
                                value: "${stringHolder + intHolder.toString()}.4",
                                showValue: true,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 30),
                              width: 170,
                              height: 60,
                              child: SfBarcodeGenerator(
                                value: "${stringHolder + intHolder.toString()}.3",
                                showValue: true,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 30),
                              width: 170,
                              height: 60,
                              child: SfBarcodeGenerator(
                                value: "${stringHolder + intHolder.toString()}.2",
                                showValue: true,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              width: 170,
                              height: 60,
                              child: SfBarcodeGenerator(
                                value: "${stringHolder + intHolder.toString()}.1",
                                showValue: true,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                width: 150,
                                height: 50,
                                margin: const EdgeInsets.only(top: 10),
                                child: const Image(
                                    image: AssetImage("assets/logo.png"))),
                          ]),
                    ],
                  ),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Imprimir',
        onPressed: () {
          renderAndPrintImage();
        },
        child: const Icon(Icons.print),
      ),
    );
  }

  void renderAndPrintImage() async {
    final boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage(pixelRatio: 5.0);
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List();
    if (imageBytes != null) {
      final img = pw.MemoryImage(imageBytes);
      final doc = pw.Document();
      doc.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(img),
            ); // Center
          })); // Page
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => doc.save());
    }
  }
}
