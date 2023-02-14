import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/pdftest/pdfExport.dart';

import 'package:bestengineer/pdftest/pdfModel.dart';
import 'package:bestengineer/screen/Enquiry/enqDashboard.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:bestengineer/screen/Quotation/pdfQuotation.dart';
import 'package:bestengineer/screen/Quotation/pdfsave.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class PdfPreviewPage extends StatelessWidget {
  PdfQuotation quotation1 = PdfQuotation();
  PdFSave pdfSave = PdFSave();
  DateTime now = DateTime.now();

  // final Invoice invoice;
  // PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);
  ExportPdf export = ExportPdf();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EnqHome(
                            type: "return from quataion",
                          )));
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: P_Settings.loginPagetheme,
        title: Text('PDF Preview'),
        actions: [
          IconButton(
              onPressed: () async {
                final pdffile = await pdfSave.savepdf();
                print("pdffile----$pdffile");
                PdFSave.sendFile(pdffile);
              },
              icon: Icon(Icons.share)),
          // Padding(
          //   padding: const EdgeInsets.only(left: 12.0),
          //   child: IconButton(
          //       onPressed: () async {
          //         // final pdffile = await pdfSave.savepdf();
          //         // PdFSave.downloadDoc("m$now.pdf");
          //       },
          //       icon: Icon(Icons.download)),
          // )
        ],
      ),
      body: PdfPreview(
          useActions: false, build: (context) => quotation1.generate()),
    );
  }
}
