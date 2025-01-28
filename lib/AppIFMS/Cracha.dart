import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'Estudante.dart';

class CrachaScreen extends StatelessWidget {
  final String username;

  const CrachaScreen({Key? key, required this.username}) : super(key: key);

  Future<void> _printPage(BuildContext context, GlobalKey key) async {
    final RenderRepaintBoundary boundary =
    key.currentContext?.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      final Uint8List imageData = byteData.buffer.asUint8List();

      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
        return _generatePdf(format, imageData);
      });
    }
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, Uint8List imageData) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(imageData);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(image),
          );
        },
      ),
    );

    return Uint8List.fromList(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey key = GlobalKey();
    final String matricula = "123456-9";
    final String curso = "ADS";
    final String campus = "IFMS Campus Corumbá";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Crachá Digital"),
        backgroundColor: Colors.green[600],
      ),
      body: RepaintBoundary(
        key: key,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green[50],
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        color: Colors.green[600],
                        width: double.infinity,
                        child: const Text(
                          "Crachá",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: 8.0,
                        top: 8.0,
                        child: ElevatedButton(
                          onPressed: () => _printPage(context, key),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            side: const BorderSide(color: Colors.green, width: 1),
                            minimumSize: const Size(30, 30),
                          ),
                          child: const Text(
                            "Baixar Documento",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/imagens/goku.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Matrícula: $matricula",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Curso: $curso",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Campus: $campus",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.asset(
                      'assets/imagens/barra.png',
                      width: 200,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EstudanteScreen(username: username)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      minimumSize: const Size(200, 40),
                    ),
                    child: const Text(
                      "Informações do Estudante",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
