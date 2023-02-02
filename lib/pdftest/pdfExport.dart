import 'dart:io';
import 'package:bestengineer/pdftest/pdfModel.dart';
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
  List<pw.Widget> widgets = [];

  Future<Uint8List> makePdf(Invoice invoice) async {
    final pdf = pw.Document();
    final image = await imageFromAssetBundle('assets/noImg.png');
    final headrText = pw.Row(
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
    );
    widgets.add(headrText);
    for (int i = 0; i < 4; i++) {
      widgets.add(
        pw.Text(
          'Heading',
          style: pw.TextStyle(
            fontSize: 25,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      );
      widgets.add(pw.SizedBox(height: 5));
      widgets.add(
        pw.Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed accumsan augue, ut tincidunt lectus. Vestibulum venenatis euismod eros suscipit rhoncus. Sed vulputate congue turpis ut cursus. Proin sollicitudin nulla vel nisi vulputate sagittis. Morbi neque mauris, auctor id posuere eu, egestas porttitor justo. Donec tempus egestas lorem in convallis. Quisque fermentum, augue ut facilisis pretium, risus dolor viverra est, ac consequat tellus risus vitae sapien. ',
          style: const pw.TextStyle(color: PdfColors.grey),
        ),
      );
      widgets.add(pw.SizedBox(height: 10));
    }

    final tab = pw.Table(
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
            pw.Text('\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
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
    );
    widgets.add(tab);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => widgets, //here goes the widgets list
      ),
    );
    // pdf.addPage(
    //   pw.Page(
    //       build: (context) => pw.Column(children: [
    //             pw.SizedBox(
    //               height: 50,
    //             ),
    //             pw.Table(
    //               border: pw.TableBorder.all(color: PdfColors.black),
    //               children: [
    //                 // The first row just contains a phrase 'INVOICE FOR PAYMENT'
    //                 pw.TableRow(
    //                   children: [
    //                     pw.Padding(
    //                       child: pw.Text(
    //                         'INVOICE FOR PAYMENT',
    //                         textAlign: pw.TextAlign.center,
    //                       ),
    //                       padding: pw.EdgeInsets.all(20),
    //                     ),
    //                   ],
    //                 ),

    //                 ...invoice.items.map(
    //                   (e) => pw.TableRow(
    //                     children: [
    //                       pw.Expanded(
    //                         child: pw.Text(e.description),
    //                         flex: 2,
    //                       ),
    //                       pw.Expanded(
    //                         child: pw.Text("\$${e.cost}"),
    //                         flex: 1,
    //                       )
    //                     ],
    //                   ),
    //                 ),

    //                 pw.TableRow(
    //                   children: [
    //                     pw.Text('TAX', textAlign: pw.TextAlign.right),
    //                     pw.Text(
    //                         '\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
    //                   ],
    //                 ),
    //                 // Show the total
    //                 pw.TableRow(
    //                   children: [
    //                     pw.Text('TOTAL', textAlign: pw.TextAlign.right),
    //                     pw.Text("\$${invoice.totalCost()}"),
    //                   ],
    //                 )
    //               ],
    //             ),
    //             pw.Padding(
    //               child: pw.Text(
    //                 "THANK YOU FOR YOUR BUSINESS!",
    //               ),
    //               padding: pw.EdgeInsets.all(20),
    //             ),
    //           ])),
    // );
    return pdf.save();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<File> savePdf(Invoice invoice) async {
    final pdf = pw.Document();
    final image = await imageFromAssetBundle('assets/noImg.png');
    final headrText = pw.Row(
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
    );
    widgets.add(headrText);
    for (int i = 0; i < 4; i++) {
      widgets.add(
        pw.Text(
          'Heading',
          style: pw.TextStyle(
            fontSize: 25,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      );
      widgets.add(pw.SizedBox(height: 5));
      widgets.add(
        pw.Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed accumsan augue, ut tincidunt lectus. Vestibulum venenatis euismod eros suscipit rhoncus. Sed vulputate congue turpis ut cursus. Proin sollicitudin nulla vel nisi vulputate sagittis. Morbi neque mauris, auctor id posuere eu, egestas porttitor justo. Donec tempus egestas lorem in convallis. Quisque fermentum, augue ut facilisis pretium, risus dolor viverra est, ac consequat tellus risus vitae sapien. ',
          style: const pw.TextStyle(color: PdfColors.grey),
        ),
      );
      widgets.add(pw.SizedBox(height: 10));
    }

    final tab = pw.Table(
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
            pw.Text('\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
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
    );
    widgets.add(tab);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => widgets, //here goes the widgets list
      ),
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
