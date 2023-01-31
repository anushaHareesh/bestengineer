import 'dart:io';

import 'package:bestengineer/chatApp/pdftest/pdfmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class ExportPdf {
  DateTime now = DateTime.now();

  Future<Uint8List> makePdf(Invoice invoice) async {
    final pdf = pw.Document();
    final image = await imageFromAssetBundle('assets/noImg.png');

    pdf.addPage(
      pw.Page(
          build: (context) => pw.Column(children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text("Attention to: ${invoice.customer}"),
                        pw.Text(invoice.address),
                      ],
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                    ),
                    pw.SizedBox(
                      height: 150,
                      width: 150,
                      child: pw.Image(
                        image,
                      ),
                    )
                  ],
                ),
                pw.SizedBox(
                  height: 50,
                ),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    // The first row just contains a phrase 'INVOICE FOR PAYMENT'
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          child: pw.Text(
                            'INVOICE FOR PAYMENT',
                            textAlign: pw.TextAlign.center,
                          ),
                          padding: pw.EdgeInsets.all(20),
                        ),
                      ],
                    ),

                    ...invoice.items.map(
                      (e) => pw.TableRow(
                        children: [
                          pw.Expanded(
                            child: pw.Text(e.description),
                            flex: 2,
                          ),
                          pw.Expanded(
                            child: pw.Text("\$${e.cost}"),
                            flex: 1,
                          )
                        ],
                      ),
                    ),

                    pw.TableRow(
                      children: [
                        pw.Text('TAX', textAlign: pw.TextAlign.right),
                        pw.Text(
                            '\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                      ],
                    ),
                    // Show the total
                    pw.TableRow(
                      children: [
                        pw.Text('TOTAL', textAlign: pw.TextAlign.right),
                        pw.Text("\$${invoice.totalCost()}"),
                      ],
                    )
                  ],
                ),
                pw.Padding(
                  child: pw.Text(
                    "THANK YOU FOR YOUR BUSINESS!",
                  ),
                  padding: pw.EdgeInsets.all(20),
                ),
              ])),
    );
    return pdf.save();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<File> savePdf(Invoice invoice) async {
    final pdf = pw.Document();
    final image = await imageFromAssetBundle('assets/noImg.png');

    pdf.addPage(
      pw.Page(
          build: (context) => pw.Column(children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text("Attention to: ${invoice.customer}"),
                        pw.Text(invoice.address),
                      ],
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                    ),
                    pw.SizedBox(
                      height: 150,
                      width: 150,
                      child: pw.Image(
                        image,
                      ),
                    )
                  ],
                ),
                pw.SizedBox(
                  height: 50,
                ),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    // The first row just contains a phrase 'INVOICE FOR PAYMENT'
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          child: pw.Text(
                            'INVOICE FOR PAYMENT',
                            textAlign: pw.TextAlign.center,
                          ),
                          padding: pw.EdgeInsets.all(20),
                        ),
                      ],
                    ),
                    // The remaining rows contain each item from the invoice, and uses the
                    // map operator (the ...) to include these items in the list
                    ...invoice.items.map(
                      // Each new line item for the invoice should be rendered on a new TableRow
                      (e) => pw.TableRow(
                        children: [
                          // We can use an Expanded widget, and use the flex parameter to specify
                          // how wide this particular widget should be. With a flex parameter of
                          // 2, the description widget will be 66% of the available width.
                          pw.Expanded(
                            child: pw.Text(e.description),
                            flex: 2,
                          ),
                          // Again, with a flex parameter of 1, the cost widget will be 33% of the
                          // available width.
                          pw.Expanded(
                            child: pw.Text("\$${e.cost}"),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                    // After the itemized breakdown of costs, show the tax amount for this invoice
                    // In this case, it's just 10% of the invoice amount
                    pw.TableRow(
                      children: [
                        pw.Text('TAX', textAlign: pw.TextAlign.right),
                        pw.Text(
                            '\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                      ],
                    ),
                    // Show the total
                    pw.TableRow(
                      children: [
                        pw.Text('TOTAL', textAlign: pw.TextAlign.right),
                        pw.Text("\$${invoice.totalCost()}"),
                      ],
                    )
                  ],
                ),
                pw.Padding(
                  child: pw.Text(
                    "THANK YOU FOR YOUR BUSINESS!",
                  ),
                  padding: pw.EdgeInsets.all(20),
                ),
              ])),
    );

    return savedocument(name: "m$now.pdf", pdf: pdf);
  }

///////////////////////////////////////////////////////////////////////////////////
  Future<File> savedocument(
      {required String name, required pw.Document pdf}) async {
    // final bytes = pdf.save();

    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/${name}');

    await file.writeAsBytes(await pdf.save());
    // sendFile(file);
    return file;
  }

///////////////////////////////////////////////////////////////////////////
  static Future sendFile(File file) async {
    final url = file.path;
    Share.shareXFiles([XFile(url)]);
  }
}
