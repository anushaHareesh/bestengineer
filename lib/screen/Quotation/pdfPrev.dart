import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/pdftest/pdfExport.dart';

import 'package:bestengineer/pdftest/pdfModel.dart';
import 'package:bestengineer/screen/Quotation/pdfQuotation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class PdfPreviewPage extends StatelessWidget {
  PdfQuotation quotation1 = PdfQuotation();
  // final Invoice invoice;
  // PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);
  ExportPdf export = ExportPdf();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        title: Text('PDF Preview'),
        actions: [
          IconButton(
              onPressed: () async {
                final pdffile = await export.savePdf();
                ExportPdf.sendFile(pdffile);
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: PdfPreview(
          useActions: false, build: (context) => quotation1.generate()),
    );
  }
}
