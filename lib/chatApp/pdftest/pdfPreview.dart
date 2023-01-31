import 'package:bestengineer/chatApp/pdftest/pdfApi.dart';
import 'package:bestengineer/chatApp/pdftest/pdfExport.dart';
import 'package:bestengineer/chatApp/pdftest/pdfmodel.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class PdfPreviewPage extends StatelessWidget {
  final Invoice invoice;
  PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);
  ExportPdf export = ExportPdf();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
        actions: [
          IconButton(
              onPressed: () async {
                final pdffile = await export.savePdf(invoice);
                ExportPdf.sendFile(pdffile);
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: PdfPreview(
        useActions: false,
        build: (context) => export.makePdf(invoice),
      ),
    );
  }
}
