import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future<String> downloadAndSavePdfFromUrl(String url) async {
  final response = await http.get(Uri.parse(url));
  final bytes = response.bodyBytes;
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/downloaded_pdf.pdf');

  await file.writeAsBytes(bytes);
  return file.path;
}

class PdfViewerPage extends StatefulWidget {
  final String path;

  const PdfViewerPage({Key? key, required this.path}) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: widget.path,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
      ),
    );
  }
}
