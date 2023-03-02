import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_watermark/image_watermark.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfQuotation {
  Future<Uint8List> generate(
      List<Map<String, dynamic>> detailPdf,
      List<Map<String, dynamic>> masterPdf,
      List<Map<String, dynamic>> termsList,
      String br) async {
    final pdf = Document();
    final headerimage;
    final footerimage;
    if (br == "0") {
      headerimage = await imageFromAssetBundle('assets/kannur_header.png');
      footerimage = await imageFromAssetBundle('assets/kannur_footer.png');
    } else {
      headerimage = await imageFromAssetBundle('assets/kozhikod_header.png');
      footerimage = await imageFromAssetBundle('assets/kozhikod_footer.png');
    }

    pdf.addPage(MultiPage(
      pageFormat:
          PdfPageFormat.a4.applyMargin(left: 0, top: 0, right: 0, bottom: 0),
      crossAxisAlignment: CrossAxisAlignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      //  pageFormat: PdfPageFormat(8 * PdfPageFormat.cm, 20 * PdfPageFormat.cm, marginAll: 0.5 * PdfPageFormat.cm),
      build: (context) => [
        // imageSet(image, detailPdf, masterPdf, termsList),
        // SizedBox(
        //   height: 0.4 * PdfPageFormat.cm,
        //   child: Watermark(child: Image(image)),
        //   // child: Watermark(
        //   //     child: Text("Conhshgsjshdj"), angle: 0, fit: BoxFit.contain),
        // ),
        // waterMark(headerimage),
        buildQuotationHeading(),
        SizedBox(height: 0.1 * PdfPageFormat.cm),
        buildCustomerData(masterPdf),

        // SizedBox(
        //   height: 0.4 * PdfPageFormat.cm,
        //   child: Watermark(child: Image(image), angle: 0, fit: BoxFit.contain),
        //   // child: Watermark(
        //   //     child: Text("Conhshgsjshdj"), angle: 0, fit: BoxFit.contain),
        // ),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildInvoice(detailPdf),
        // Divider(),
        SizedBox(height: 5),
        buildTotal(detailPdf),
      ],

      header: (
        context,
      ) {
        return buildHeader(headerimage);
      },
      footer: (context) => buildFooter(termsList, footerimage),
    ));

    // final List<int> bytes = await pdf.save();

    // saveAndLaunchFile(bytes, "inv2.pdf");
    return pdf.save();
  }

///////////////////////////////////////////////////////////////////////////////////
  Widget waterMark(ImageProvider image) {
    return Container(
      child: Image(
        image,
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////
  Widget buildHeader(ImageProvider image) {
    return Container(
      child: Image(
        image,
      ),
    );
    // return Container(
    //     child: Column(children: [
    //   Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       SizedBox(
    //         height: 120,
    //         width: 600,
    //         child: Image(
    //           image,
    //         ),
    //       ),
    //       // Column(
    //       //   mainAxisAlignment: MainAxisAlignment.start,
    //       //   crossAxisAlignment: CrossAxisAlignment.start,
    //       //   children: [
    //       //     Text("BEST MACHINETOOLS PVT LTD",
    //       //         style: TextStyle(
    //       //             fontSize: 24,
    //       //             fontWeight: pw.FontWeight.bold,
    //       //             color: PdfColors.red)),
    //       //     Text("Attention to: Anushaa"),
    //       //     Text("znckxjnckjxznckx"),
    //       //   ],
    //       //   // crossAxisAlignment: pw.CrossAxisAlignment.start,
    //       // ),
    //     ],
    //   ),
    //   // Divider(thickness: 2, color: PdfColors.red)
    // ]));
  }

/////////////////////////////////////////////////////////////////////////
  Widget buildQuotationHeading() {
    return Container(
        child: Column(children: [
      SizedBox(height: 6),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("QUOTATION", style: TextStyle(fontSize: 16))]),
      Divider(color: PdfColors.black, thickness: 1, indent: 180, endIndent: 180)
    ]));
  }

  Widget buildCustomerData(List<Map<String, dynamic>> masterPdf) {
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
                masterPdf[0]["s_invoice_no"],
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            ]),
            Row(children: [
              Text('Customer          : ',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text(masterPdf[0]["s_customer_name"],
                  style: TextStyle(
                    fontSize: 10,
                  ))
            ]),
            Row(
              children: [
                Text('Address            : ',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Text(masterPdf[0]["company_add1"],
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
              Text(masterPdf[0]["qdate"],
                  style: TextStyle(
                    fontSize: 12,
                  ))
            ]),
            Row(children: [
              Text('Phone   : ',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text(masterPdf[0]["phone_1"],
                  style: TextStyle(
                    fontSize: 12,
                  ))
            ]),

            Row(children: [
              Text('Mobile   : ',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text(masterPdf[0]["phone_2"],
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
    print("kjgkjf------$list");
    int i = 0;
    final headers = [
      'Sl No',
      'Product Name',
      'Qty',
      'Rate',
      'Amt',
      'Disc',
      'GST%',
      'GST',
      'Net Amt',
    ];

    final data = list.map((item) {
      print("sdjsjkh----${item["qty"].runtimeType}");
      i = i + 1;

      // double total = double.parse(item["qty"]) * item["rate"] ;
      double netrate = double.parse(item["net_rate"]!);

      return [
        i,
        item["product_name"],
        item["qty"],
        item["rate"],
        item["amount"],
        item["discount_amount"],
        item["tax_perc"],
        item["tax"],
        netrate.toStringAsFixed(2),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      tableWidth: TableWidth.max,
      border: TableBorder(
        left: BorderSide(
          color: PdfColors.grey,
        ),
        right: BorderSide(
          color: PdfColors.grey,
        ),
        // top: BorderSide(
        //   color: PdfColors.grey,
        // ),
        bottom: BorderSide(
          color: PdfColors.grey,
        ),
        // verticalInside: BorderSide(),
        // left: pw.BorderSide(style: pw.BorderStyle.solid),
        horizontalInside: BorderSide.none,
        verticalInside: BorderSide(
          color: PdfColors.grey,
          style: BorderStyle.solid,
        ),
      ),
      headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      cellStyle: TextStyle(fontSize: 8),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      columnWidths: {
        // 0: FixedColumnWidth(50),
        1: FixedColumnWidth(110),
        // 2: FixedColumnWidth(50),
        // 3: FixedColumnWidth(70),
        // 4: FixedColumnWidth(70),
        // 5: FixedColumnWidth(60),
        // 6: FixedColumnWidth(60),
        // 7: FixedColumnWidth(60),
        // 8: FixedColumnWidth(80),
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
        8: Alignment.centerRight,
      },
    );
  }

  ////////////////////////////////////////////////////
  static Widget buildTotal(List<Map<String, dynamic>> list) {
    double sum = 0.0;
    for (int i = 0; i < list.length; i++) {
      sum = double.parse(list[i]["net_rate"]) + sum;
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
                  value: sum.toStringAsFixed(2),
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
    required String value,
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
  static Widget buildFooter(
          List<Map<String, dynamic>> listterms, ImageProvider image) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title: listterms[0]["t_head"], value: listterms[0]["t_detail"]),
          // SizedBox(height: 1 * PdfPageFormat.mm),
          // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),

          Container(
              color: PdfColors.red,
              width: 800,
              // height:160,
              child: Image(image, fit: BoxFit.contain))
        ],
      );
//////////////////////////////////////////////////////////////////////
  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);
    return Column(children: [
      Row(
        children: [
          Text(title,
              style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Flexible(
              child: Text(value,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 6,
                  ))),
        ],
      ),
      // Divider(endIndent: 330),
      // Row(children: [
      //   Flexible(child: Text(value)),
      // ])
    ]);
  }

  // Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  //   final path = (await getExternalStorageDirectory())!.path;
  //   final file = File('$path/$fileName');
  //   await file.writeAsBytes(bytes, flush: true);
  //   OpenFilex.open('$path/$fileName');
  // }
}
