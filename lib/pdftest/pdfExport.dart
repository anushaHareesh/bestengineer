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
  final headers = ["id", "name"];
  var report = [
    {
      "sno": 1,
      "pname": "abc",
      "qty": "10",
      "rate": "200",
      "gstp": "18%",
      "gst": "120",
      "discp": "10%",
      "disc": "100",
      "net": "300"
    },
    {
      "sno": 1,
      "pname": "abc",
      "qty": "10",
      "rate": "200",
      "gstp": "18%",
      "gst": "120",
      "discp": "10%",
      "disc": "100",
      "net": "300"
    },
    {
      "sno": 1,
      "pname": "abc",
      "qty": "10",
      "rate": "200",
      "gstp": "18%",
      "gst": "120",
      "discp": "10%",
      "disc": "100",
      "net": "300"
    },
    {
      "sno": 1,
      "pname": "abc",
      "qty": "10",
      "rate": "200",
      "gstp": "18%",
      "gst": "120",
      "discp": "10%",
      "disc": "100",
      "net": "300"
    },
    {
      "sno": 1,
      "pname": "abc",
      "qty": "10",
      "rate": "200",
      "gstp": "18%",
      "gst": "120",
      "discp": "10%",
      "disc": "100",
      "net": "300"
    },
    {
      "sno": 1,
      "pname": "abc",
      "qty": "10",
      "rate": "200",
      "gstp": "18%",
      "gst": "120",
      "discp": "10%",
      "disc": "100",
      "net": "300"
    },
    {
      "sno": 1,
      "pname": "abc",
      "qty": "10",
      "rate": "200",
      "gstp": "18%",
      "gst": "120",
      "discp": "10%",
      "disc": "100",
      "net": "300"
    },
    {
      "sno": 1,
      "pname": "abc",
      "qty": "10",
      "rate": "200",
      "gstp": "18%",
      "gst": "120",
      "discp": "10%",
      "disc": "100",
      "net": "300"
    },
    {
      "sno": 1,
      "pname": "abc",
      "qty": "10",
      "rate": "200",
      "gstp": "18%",
      "gst": "120",
      "discp": "10%",
      "disc": "100",
      "net": "300"
    },
    {
      "sno": 1,
      "pname": "abc",
      "qty": "10",
      "rate": "200",
      "gstp": "18%",
      "gst": "120",
      "discp": "10%",
      "disc": "100",
      "net": "300"
    }
  ];

  DateTime now = DateTime.now();
  List<pw.Widget> widgets = [];
///////////////////////////////////////////////////////
  Future<Uint8List> makePdf() async {
    var list = (report as List)
        .map((item) => pw.TableRow(children: [
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(item['sno'].toString(),
                    style: pw.TextStyle(color: PdfColors.grey800)),
              ),
              pw.Container(
                  width: 10,
                  alignment: pw.Alignment.centerLeft,
                  margin: pw.EdgeInsets.only(left: 4),
                  child: pw.Flexible(
                    child: pw.Text(item['pname'].toString(),
                        style: pw.TextStyle(color: PdfColors.grey800)),
                  )),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                margin: pw.EdgeInsets.only(right: 4),
                child: pw.Text(item['qty'],
                    style: pw.TextStyle(color: PdfColors.grey800)),
              ),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                margin: pw.EdgeInsets.only(right: 4),
                child: pw.Text(item['rate'],
                    style: pw.TextStyle(color: PdfColors.grey800)),
              ),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                margin: pw.EdgeInsets.only(right: 4),
                child: pw.Text(item['gstp'],
                    style: pw.TextStyle(color: PdfColors.grey800)),
              ),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                margin: pw.EdgeInsets.only(right: 4),
                child: pw.Text(item['gst'],
                    style: pw.TextStyle(color: PdfColors.grey800)),
              ),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                margin: pw.EdgeInsets.only(right: 4),
                child: pw.Text(item['discp'],
                    style: pw.TextStyle(color: PdfColors.grey800)),
              ),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                margin: pw.EdgeInsets.only(right: 4),
                child: pw.Text(item['disc'],
                    style: pw.TextStyle(color: PdfColors.grey800)),
              ),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                margin: pw.EdgeInsets.only(right: 4),
                child: pw.Text(item['net'],
                    style: pw.TextStyle(color: PdfColors.grey800)),
              ),
            ]))
        .toList();
    list.insert(
        0,
        pw.TableRow(children: [
          pw.Container(alignment: pw.Alignment.center, child: pw.Text("S No")),
          pw.Container(
              alignment: pw.Alignment.center, child: pw.Text("PRODUCT NAME")),
          pw.Container(alignment: pw.Alignment.center, child: pw.Text("QTY")),
          pw.Container(alignment: pw.Alignment.center, child: pw.Text("RATE")),
          pw.Container(alignment: pw.Alignment.center, child: pw.Text("GST%")),
          pw.Container(alignment: pw.Alignment.center, child: pw.Text("GST")),
          pw.Container(alignment: pw.Alignment.center, child: pw.Text("DISC%")),
          pw.Container(alignment: pw.Alignment.center, child: pw.Text("DISC")),
          pw.Container(
              alignment: pw.Alignment.center, child: pw.Text("NET AMT")),

          //...
        ]));

    final pdf = pw.Document();
    final image = await imageFromAssetBundle('assets/noImg.png');
    final headrText = pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.SizedBox(
          height: 120,
          width: 120,
          child: pw.Image(
            image,
          ),
        ),
        pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("BEST ENGINEERS LTD",
                style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.red)),
            pw.Text("Attention to: Anushaa"),
            pw.Text("znckxjnckjxznckx"),
          ],
          // crossAxisAlignment: pw.CrossAxisAlignment.start,
        ),
        pw.Divider(thickness: 2, color: PdfColors.red)
      ],
    );
    widgets.add(headrText);

    final sized = pw.SizedBox(height: 20);
    widgets.add(sized);

    final quotHead =
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
      pw.Text("QUOTATION",
          style: pw.TextStyle(
            fontSize: 20,
          ))
    ]);
    widgets.add(quotHead);
    widgets.add(sized);

    final quotaAddr =
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Row(children: [
            pw.Text('Quotation No    : ',
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
            pw.Text('213',
                style: pw.TextStyle(
                  fontSize: 12,
                ))
          ]),
          pw.Row(children: [
            pw.Text('Customer          : ',
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
            pw.Text('ANUSHA K',
                style: pw.TextStyle(
                  fontSize: 10,
                ))
          ]),
          pw.Row(
            children: [
              pw.Text('Address            : ',
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold)),
              pw.Text('KANNUR THAVAKAARAA',
                  style: pw.TextStyle(
                    fontSize: 12,
                  ))
            ],
          ),
        ],
      ),
      pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Row(children: [
              pw.Text('Date      : ',
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold)),
              pw.Text('20-11-2023',
                  style: pw.TextStyle(
                    fontSize: 12,
                  ))
            ]),
            pw.Row(children: [
              pw.Text('Phone   : ',
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold)),
              pw.Text('9061259261',
                  style: pw.TextStyle(
                    fontSize: 12,
                  ))
            ]),
            // pw.Row(
            //   children: [
            //     pw.Text('Address  : ',
            //         style: pw.TextStyle(
            //             fontSize: 10, fontWeight: pw.FontWeight.bold)),
            //     pw.Text('KANNUR THAVAKAARAA',
            //         style: pw.TextStyle(
            //           fontSize: 12,
            //         ))
            //   ],
            // ),
          ])
    ]);

    widgets.add(quotaAddr);
    widgets.add(sized);
    final tab = pw.SizedBox(
        height: 600,
        child: pw.Table(
            border: pw.TableBorder(
                verticalInside: pw.BorderSide(),
                bottom: pw.BorderSide(),
                top: pw.BorderSide(),
                left: pw.BorderSide(),
                right: pw.BorderSide()),
            children: list));

    // final tab = pw.Table.fromTextArray(
    //     headers: headers, data: data, cellAlignment: pw.Alignment.bottomRight);
    widgets.add(tab);

    // widgets.add(sized);
    // final termHead = pw.Row(children: [pw.Text("Terms & Conditions")]);
    // widgets.add(termHead);

    // final terDetail = pw.Row(
    //     children: [pw.Text("TERMS AND CONDITIONS  : TRAVELLING CHARGE EXTRA")]);
    // widgets.add(termHead);
    // widgets.add(terDetail);
    // final sum = pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
    //   pw.Text("GrandTotal  : "),
    //   pw.Text("228888 "),
    // ]);
    // widgets.add(sum);
    pdf.addPage(
      pw.MultiPage(
        
      //  crossAxisAlignment: pw.CrossAxisAlignment.center,
      footer: (context) {
        return pw.Column(children: [
          pw.Row(children: [pw.Text("Terms & Conditions")]),
          pw.Row(children: [
            pw.Text("TERMS AND CONDITIONS  : TRAVELLING CHARGE EXTRA")
          ])
        ]);
      },
      build: (context) => widgets,
    ));
    return pdf.save();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<File> savePdf() async {
    var list = (report as List)
        .map((item) => pw.TableRow(children: [
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(item['id'].toString()),
              ),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(item['report_id'].toString()),
              ),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(item['place']),
              ),
              // pw.Text(item['report_id'].toString()),
              // pw.Text(item['place']),
              //...
            ]))
        .toList();
    list.insert(
        0,
        pw.TableRow(children: [
          pw.Text("id"),
          pw.Text("report id"),
          pw.Text("place"),
          //...
        ]));
    // var data = list.map((e) => [e["id"], e["name"]]).toList();

    final pdf = pw.Document();
    final image = await imageFromAssetBundle('assets/noImg.png');
    final headrText = pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          children: [
            pw.Text("Attention to: Anushaa"),
            pw.Text("znckxjnckjxznckx"),
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
    final tab = pw.Table(
        border: pw.TableBorder.all(color: PdfColors.black), children: list);
    // final tab = pw.Table.fromTextArray(
    //     headers: headers, data: data, cellAlignment: pw.Alignment.bottomRight);
    widgets.add(tab);
    // final sum = pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
    //   pw.Text("GrandTotal  : "),
    //   pw.Text("228888 "),
    // ]);
    // widgets.add(sum);
    pdf.addPage(pw.MultiPage(
      build: (context) => widgets,
    ));

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
