import 'dart:ui';
import 'package:barcodes_logistica/barcodes_paper_a4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final TextEditingController? txtController = TextEditingController();
  var stringHolder = "";
  var intHolder = 0;
  final GlobalKey globalKey = GlobalKey();
  String? _selectedValue = "Macedo";
  final sgaPlantList = {"Macedo", "Cumbica"};

  void _setTextValue() {
    setState(() {
      txtController?.text = (txtController?.text.length == 2
          ? "${txtController?.text.toString().toUpperCase()[0]}0${int.parse(txtController!.text.toString().replaceAll(RegExp('[^0-9]'), ''))}"
          : txtController?.text.toString().toUpperCase())!;
      stringHolder = txtController!.text.toString().toUpperCase()[0];
      intHolder = int.parse(
              txtController!.text.toString().replaceAll(RegExp('[^0-9]'), '')) +
          1;
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
            ]),
      ),
      body: SingleChildScrollView(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 180,
            height: 300,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.lightBlue,
                    width: 2,
                    style: BorderStyle.solid),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            margin: const EdgeInsets.only(right: 90),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Selecione a unidade:',
                ),
                DropdownButton<String>(
                  value: _selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                  },
                  items: <String>['Macedo', 'Cumbica']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const Text(
                  'Digite a rua e a posição:',
                ),
                SizedBox(
                    width: 100.0,
                    height: 60,
                    child: TextField(
                      controller: txtController,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Ex: A1...",
                      ),
                      onSubmitted: (value) => _setTextValue(),
                    )),
                IconButton(
                    iconSize: 50,
                    color: Colors.blue,
                    tooltip: 'Print image',
                    onPressed: () => renderAndPrintImage(),
                    icon: const Icon(Icons.print))
              ],
            ),
          ),
          Container(
              width: 375,
              height: 600,
              margin: const EdgeInsets.all(60),
              child: RepaintBoundary(
                key: globalKey,
                child: BarcodesPapera4(
                    txtController: txtController,
                    intHolder: intHolder,
                    stringHolder: stringHolder),
              )),
        ],
      )),
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
