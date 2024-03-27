import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;
  final String username;

  const PdfViewerPage({Key? key, required this.pdfUrl, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('$username CV', style: Theme.of(context).textTheme.displayLarge,),
        centerTitle: true,
      ),
      body: SfPdfViewer.network(
        pdfUrl,
      ),
    );
  }
}