import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController txtController = TextEditingController();
  final GlobalKey globalKey = GlobalKey();


  void _printLatestValue() {
    setState(() {
      txtController.text = txtController.text.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
              onSubmitted: (value) => _printLatestValue(),
            ),

            Container(
              width: 300,
              height: 500,
              margin: EdgeInsets.all(10),
              child:  RepaintBoundary(
                key: globalKey,
                child:
                Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3, // takes 30% of available width
                      child:       SfBarcodeGenerator(
                        value: "${txtController.text}.1",
                        showValue: true,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 3, // takes 30% of available width
                      child:       SfBarcodeGenerator(
                        value: "${txtController.text}.2",
                        showValue: true,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 3, // takes 30% of available width
                      child:       SfBarcodeGenerator(
                        value: "${txtController.text}.3",
                        showValue: true,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 3, // takes 30% of available width
                      child:       SfBarcodeGenerator(
                        value: "${txtController.text}.4",
                        showValue: true,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                        flex: 3, // takes 30% of available width
                        child: Image(image: AssetImage("assets/logo.png"))
                    ),
                  ]
                ),
              )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {
          print("ok");
          renderImage();
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<String?> generateBarcode() async {
    print(txtController.text);
//     // Create a DataMatrix barcode
//     final dm = Barcode.dataMatrix();
//
// // Generate a SVG with "Hello World!"
//     final svg = dm.toSvg('Hello World!', width: 200, height: 200);
//
//     final svgImage = pw.SvgImage(svg: svg);
//
//     pdf.addPage(pw.Page(build: (pw.Context context) {
//       return pw.Center(
//         child: svgImage,
//       ); // Center
//     })); // Page
//
// // Save the image
// //     await File('barcode.svg').writeAsString(svg);
//   print(svg);
    return null;
  }
  void renderImage() async {
    final boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage();
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List();
    if (imageBytes != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/container_image.png').create();
      print(directory);
      print(imagePath);
      await imagePath.writeAsBytes(imageBytes);
    }
  }

}


