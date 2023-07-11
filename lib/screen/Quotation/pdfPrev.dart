import 'dart:io';

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
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../controller/controller.dart';

class PdfPreviewPage extends StatefulWidget {
  String br;
  String id;
  PdfPreviewPage({required this.br, required this.id});
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
    print("jkjkssjkd----${widget.id}");
    Provider.of<QuotationController>(context, listen: false)
        .getPdfData(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
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
            // IconButton(
            //     onPressed: () {
            //       _addWatermarkToPDF();
            //     },
            //     icon: Icon(Icons.abc)),
            Consumer<QuotationController>(
              builder: (context, value, child) {
                return IconButton(
                    onPressed: () async {
                      final pdffile = await pdfSave.savepdf(
                          value.detailPdf,
                          value.masterPdf,
                          value.termsPdf,
                          value.msgLogsPdf,
                          widget.br);
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
                          value.detailPdf,
                          value.masterPdf,
                          value.termsPdf,
                          value.msgLogsPdf,
                          widget.br);
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
                      value.detailPdf,
                      value.masterPdf,
                      value.termsPdf,
                      value.msgLogsPdf,
                      widget.br));
            }
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to exit from this app'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }

  // Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  //   final path = (await getExternalStorageDirectory())!.path;
  //   final file = File('$path/$fileName');
  //   await file.writeAsBytes(bytes, flush: true);
  //   OpenFilex.open('$path/$fileName');
  // }

  // Future<List<int>> _readDocumentData(String name) async {
  //   final ByteData data = await rootBundle.load('assets/$name');
  //   return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  // }

  // Future<void> _addWatermarkToPDF() async {
  //   // final image = await imageFromAssetBundle('assets/noImg.png');
  //   var imgBytes =
  //       (await rootBundle.load("assets/noImg.png")).buffer.asUint8List();
  //   //   final watermarkedImg = await ImageWatermark.addTextWatermarkCentered(
  //   //     imgBytes: imgBytes,
  //   //     watermarktext: 'watermarkText',
  //   //   );
  //   PdfDocument document =
  //       PdfDocument(inputBytes: await _readDocumentData('Invoice1.pdf'));

  //   //Get first page from document
  //   PdfPage page = document.pages[0];

  //   //Get page size
  //   Size pageSize = page.getClientSize();

  //   //Set a standard font
  //   PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 40);

  //   //Measure the text
  //   Size size = font.measureString('Confidential');

  //   //Create PDF graphics for the page
  //   PdfGraphics graphics = page.graphics;

  //   //Calculate the center point
  //   double x = pageSize.width / 2;
  //   double y = pageSize.height / 2;

  //   //Save the graphics state for the watermark text
  //   graphics.save();

  //   //Tranlate the transform with the center point
  //   graphics.translateTransform(x, y);

  //   //Set transparency level for the text
  //   graphics.setTransparency(0.25);

  //   //Rotate the text to -40 Degree
  //   graphics.rotateTransform(-40);

  //   //Draw the watermark text to the desired position over the PDF page with red color
  //   graphics.drawImage(
  //       PdfBitmap(imgBytes),
  //       Rect.fromLTWH(
  //           -size.width / 2, -size.height / 2, size.width, size.height));
  //   // graphics.drawString('Confidential', font,
  //   //     pen: PdfPen(PdfColor(255, 0, 0)),
  //   //     brush: PdfBrushes.red,
  //   //     bounds: Rect.fromLTWH(
  //   //         -size.width / 2, -size.height / 2, size.width, size.height));

  //   //Restore the graphics
  //   graphics.restore();

  //   //Save the document
  //   List<int> bytes = await document.save();

  //   //Dispose the document
  //   document.dispose();

  //   //Save the file and launch/download
  //   saveAndLaunchFile(bytes, 'Invoice3.pdf');
  // }
}
