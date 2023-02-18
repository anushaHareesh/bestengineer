import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/pdftest/pdfExport.dart';

import 'package:bestengineer/pdftest/pdfModel.dart';
import 'package:bestengineer/screen/Enquiry/enquiryScreen.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:bestengineer/screen/Quotation/pdfDownload.dart';
import 'package:bestengineer/screen/Quotation/pdfQuotation.dart';
import 'package:bestengineer/screen/Quotation/pdfsave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../controller/controller.dart';

class PdfPreviewPage extends StatefulWidget {
  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  PdfQuotation quotation1 = PdfQuotation();
  PdfDownload dwnload = PdfDownload();
  PdFSave pdfSave = PdFSave();

  DateTime now = DateTime.now();

  // final Invoice invoice;
  ExportPdf export = ExportPdf();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<QuotationController>(context, listen: false).getPdfData(
        context,
        Provider.of<QuotationController>(context, listen: false)
            .sivd
            .toString());
  }

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
          Consumer<QuotationController>(
            builder: (context, value, child) {
              return IconButton(
                  onPressed: () async {
                    final pdffile = await pdfSave.savepdf(
                        value.detailPdf, value.masterPdf, value.termsPdf);
                    print("pdffile----$pdffile");
                    PdFSave.sendFile(pdffile);
                  },
                  icon: Icon(Icons.share));
            },
          ),
          Consumer<QuotationController>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: IconButton(
                  onPressed: () async {
                    final pdffile = await dwnload.downLoadpdf(
                        value.detailPdf, value.masterPdf, value.termsPdf);
                    print("kjxnzx-------$pdffile");
                    final snackBar = SnackBar(
                      duration: Duration(seconds: 2),
                      content: const Text(
                        'Pdf downloaded to BestPDF folder',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: (Colors.black),
                      // action: SnackBarAction(
                      //   label: 'dismiss',
                      //   onPressed: () {},
                      // ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon: Icon(Icons.download),
                ),
              );
            },
          )
        ],
      ),
      body: Consumer<QuotationController>(
        builder: (context, value, child) {
          if (value.isPdfLoading) {
            return SpinKitCircle(
              color: P_Settings.loginPagetheme,
            );
          } else {
            return PdfPreview(
                useActions: false,
                build: (context) => quotation1.generate(
                    value.detailPdf, value.masterPdf, value.termsPdf));
          }
        },
      ),
    );
  }
}
