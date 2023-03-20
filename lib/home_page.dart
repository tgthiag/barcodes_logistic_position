import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
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
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Digite a rua e a posição:',
            ),
            TextField(
              controller: txtController,
              maxLines: 1,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Ex: A1...",
              ),
              onSubmitted: (value) => _setTextValue(),
            ),
            Container(
                width: 200,
                height: 500,
                margin: EdgeInsets.all(10),
                child: RepaintBoundary(
                  key: globalKey,
                  child: Column(children: <Widget>[
                    Expanded(
                      flex: 8, // takes 30% of available width
                      child: SfBarcodeGenerator(
                        value: "${txtController.text}.1",
                        showValue: true,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 8, // takes 30% of available width
                      child: SfBarcodeGenerator(
                        value: "${txtController.text}.2",
                        showValue: true,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 8, // takes 30% of available width
                      child: SfBarcodeGenerator(
                        value: "${txtController.text}.3",
                        showValue: true,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 8, // takes 30% of available width
                      child: SfBarcodeGenerator(
                        value: "${txtController.text}.4",
                        showValue: true,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Expanded(
                        flex: 8, // takes 30% of available width
                        child: Image(image: AssetImage("assets/logo.png"))),
                  ]),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Imprimir',
        onPressed: () {
          renderImage();
        },
        child: const Icon(Icons.print),
      ),
    );
  }

  void renderImage() async {
    final boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage();
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List();
    if (imageBytes != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          await File('${directory.path}\\container_image.png').create();

      await imagePath.writeAsBytes(imageBytes);

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
