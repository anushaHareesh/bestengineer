import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class PdFSave {
  DateTime now = DateTime.now();

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
      "pname": "abzxbsmzxdbzsdnsmdnsmdnsm,d,smd,sd,smd,zsndmsndnsdnc",
      "qty": "10",
      "rate": "200",
      "gstp": "18%",
      "gst": "120",
      "discp": "10%",
      "disc": "100",
      "net": "300"
    }
  ];
  Future<File> savepdf() async {
    final pdf = Document();
    final image = await imageFromAssetBundle('assets/noImg.png');

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(image),
        buildQuotationHeading(),
        SizedBox(height: 0.1 * PdfPageFormat.cm),
        buildCustomerData(),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildInvoice(report),
        Divider(),
        buildTotal(report),
      ],
      footer: (context) => buildFooter(
          "NJADJASDJASDJASJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ"),
    ));

    return downloadDoc(name: "m$now.pdf", pdf: pdf);
  }

///////////////////////////////////////////////////////////////////////////////////
  Widget buildHeader(ImageProvider image) {
    return Container(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Image(
              image,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("BEST ENGINEERS PVT LTD",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.red)),
              Text("Attention to: Anushaa"),
              Text("znckxjnckjxznckx"),
            ],
            // crossAxisAlignment: pw.CrossAxisAlignment.start,
          ),
        ],
      ),
      Divider(thickness: 2, color: PdfColors.red)
    ]));
  }

/////////////////////////////////////////////////////////////////////////
  Widget buildQuotationHeading() {
    return Container(
        child: Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("QUOTATION", style: TextStyle(fontSize: 18))]),
      Divider(color: PdfColors.black, thickness: 1, indent: 180, endIndent: 180)
    ]));
  }

  Widget buildCustomerData() {
    return Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text('Quotation No    : ',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text(
                '213',
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            ]),
            Row(children: [
              Text('Customer          : ',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text('ANUSHA K',
                  style: TextStyle(
                    fontSize: 10,
                  ))
            ]),
            Row(
              children: [
                Text('Address            : ',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Text('KANNUR THAVAKAARAA',
                    style: TextStyle(
                      fontSize: 12,
                    ))
              ],
            ),
          ]),
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(children: [
              Text('Date      : ',
                  style:
                      pw.TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text('20-11-2023',
                  style: TextStyle(
                    fontSize: 12,
                  ))
            ]),
            Row(children: [
              Text('Phone   : ',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text('9061259261',
                  style: TextStyle(
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
    ]));
  }

  Widget buildInvoice(List<Map<String, dynamic>> list) {
    final headers = [
      'Sl No',
      'Product Name',
      'Qty',
      'Rate',
      'Amt',
      'GST%',
      'GST',
      'Net Amt',
    ];
    final data = report.map((item) {
      print("sdjsjkh----${item["qty"].runtimeType}");

      double amt = double.parse(item["qty"].toString()) *
          double.parse(item["rate"].toString());
      // double total = double.parse(item["qty"]) * item["rate"] ;

      return [
        item["sno"],
        item["pname"],
        item["qty"],
        item["rate"],
        amt,
        item["gstp"],
        item["gst"],
        item["net"],
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      columnWidths: {
        0: FixedColumnWidth(50),
        1: FixedColumnWidth(110),
        2: FixedColumnWidth(50),
        3: FixedColumnWidth(70),
        4: FixedColumnWidth(70),
        5: FixedColumnWidth(60),
        6: FixedColumnWidth(60),
        7: FixedColumnWidth(80),
      },
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
        6: Alignment.centerRight,
        7: Alignment.centerRight,
      },
    );
  }

  ////////////////////////////////////////////////////
  static Widget buildTotal(List<Map<String, dynamic>> list) {
    double sum = 0.0;
    for (int i = 0; i < list.length; i++) {
      sum = double.parse(list[i]["net"]) + sum;
    }

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Grand total',
                  value: sum,
                  unite: true,
                ),

                Divider(),

                // SizedBox(height: 2 * PdfPageFormat.mm),
                // Container(height: 1, color: PdfColors.grey400),
                // SizedBox(height: 0.5 * PdfPageFormat.mm),
                // Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ////////////////////////////////////////////////////
  static buildText({
    required String title,
    required double value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value.toString(), style: unite ? style : null),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////////
  static Widget buildFooter(String terms) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Terms And Conditions', value: terms),
          // SizedBox(height: 1 * PdfPageFormat.mm),
          // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );
//////////////////////////////////////////////////////////////////////
  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Flexible(child: Text(value)),
      ],
    );
  }

  /////////////////////////////////////////////////
  // Future<File> savedocument(
  //     {required String name, required pw.Document pdf}) async {
  //   // final bytes = pdf.save();

  //   final dir = await getApplicationDocumentsDirectory();

  //   final file = File('${dir.path}/${name}');

  //   await file.writeAsBytes(await pdf.save());
  //   // sendFile(file);
  //   return file;
  // }

///////////////////////////////////////////////////////////////////////////
  static Future sendFile(File file) async {
    final url = file.path;
    Share.shareXFiles([XFile(url)]);
  }

  /////////////////////////////////////////////////////////////////////////////
  Future<File> downloadDoc(
      {required String name, required pw.Document pdf}) async {
    Directory? extDir = await getExternalStorageDirectory();
    String dirPath = '${extDir!.path}/BestPDF';
    print("dirPath----$dirPath");
    dirPath =
        dirPath.replaceAll("Android/data/com.example.bestengineer/files/", "");
    await Directory(dirPath).create(recursive: true);
    // File('${dirPath}/ nxnc.txt').create(recursive: true);

    final file = File('${dirPath}/${name}');

    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
