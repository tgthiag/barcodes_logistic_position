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
  final GlobalKey globalKey = GlobalKey();

  void _setTextValue() {
    setState(() {
      txtController.text = txtController.text.toString().toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              decoration: const InputDecoration(
                hintText: "Ex: A1...",
              ),
              onSubmitted: (value) => _setTextValue(),
            ),
            Container(
                width: 300,
                height: 600,
                margin: const EdgeInsets.all(5),
                child: RepaintBoundary(
                  key: globalKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          width: 170,
                          height: 60,
                          child: SfBarcodeGenerator(
                            value: "${txtController.text}.5",
                            showValue: true,
                            textStyle: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      width: 170,
                      height: 60,
                      child: SfBarcodeGenerator(
                        value: "${txtController.text}.4",
                        showValue: true,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          width: 170,
                          height: 60,
                      child: SfBarcodeGenerator(
                        value: "${txtController.text}.3",
                        showValue: true,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          width: 170,
                          height: 60,
                      child: SfBarcodeGenerator(
                        value: "${txtController.text}.2",
                        showValue: true,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          width: 170,
                          height: 60,
                      child: SfBarcodeGenerator(
                        value: "${txtController.text}.1",
                        showValue: true,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                        Container(
                            width: 150,
                            height: 50,
                        margin: const EdgeInsets.only(top: 10),
                        child: const Image(image: AssetImage("assets/logo.png"))),
                  ]),
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
