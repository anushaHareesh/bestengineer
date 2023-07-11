import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdfDownload {
  DateTime now = DateTime.now();
  String? date;
  String? staff_name;
  Future<File> downLoadpdf(
      List<Map<String, dynamic>> detailPdf,
      List<Map<String, dynamic>> masterPdf,
      List<Map<String, dynamic>> termsList,
       List<Map<String, dynamic>> msg_log,
      String br) async {
    date = DateFormat('ddMMyyyy').format(now);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    staff_name = prefs.getString("staff_name");
    final pdf = Document();
    final headerimage;
    final footerimage;
    final rupee;
    rupee = await imageFromAssetBundle('assets/rupee.png');
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
        // SizedBox(height: 5),
        buildTotal(detailPdf, rupee),
      ],

      header: (
        context,
      ) {
        return buildHeader(headerimage);
      },
      footer: (context) =>
          buildFooter(termsList, msg_log, footerimage, staff_name.toString()),
    ));
    String inv = masterPdf[0]["s_customer_name"] + date;

    // return savedocument(name: "m$now.pdf", pdf: pdf);
    // return downloadDoc(name: "$inv.pdf", pdf: pdf);
    return downloadDoc(name: "$inv.pdf", pdf: pdf);
  }

///////////////////////////////////////////////////////////////////////////////////
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
                  fontSize: 9,
                ),
              )
            ]),
            Row(children: [
              Text('Customer          : ',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text(masterPdf[0]["s_customer_name"],
                  style: TextStyle(
                    fontSize: 9,
                  ))
            ]),
            Row(
              children: [
                Text('Address            : ',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                Container(
                    width: 200,
                    // flex: 1,
                    // fit: FlexFit.tight,
                    child: Flexible(
                        child: Text(
                            // "bzjjzsbzsjbnm nfkjfnjkxd nfjkfjkf jfjfndjkf jfkjdfj jkhfkjzfshkj jkhfjkzskjf ihjkkkkkkkkkkkkkkkk jkjkjkjkjkjkjkjkjkjkjkjkjkjkjkjkjkjkjk kkkkkkkkkkkkkkkj",
                            masterPdf[0]["company_add1"],
                            style: TextStyle(
                              fontSize: 9,
                            ))))
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
                    fontSize: 9,
                  ))
            ]),
            Row(children: [
              Text('Phone   : ',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text(masterPdf[0]["phone_1"],
                  style: TextStyle(
                    fontSize: 9,
                  ))
            ]),

            Row(children: [
              Text('Mobile   : ',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text(masterPdf[0]["phone_2"],
                  style: TextStyle(
                    fontSize: 9,
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
    bool bord = false;

    int i = 0;
    final headers = [
      'Sl No',
      'Product Name',
      'Qty',
      'Rate',
      'Amount',
      'Discount',
      // 'GST%',
      'GST',
      'Net Amount',
    ];

    var data1;
    Map map;
    List<List<dynamic>> data = [];
    int j;

    // if (list.length > 13) {
    //   int k = (list.length - 13) % 15;
    //   if (k < 10) {
    //     k = k + 5;
    //   } else {
    //     k = k;
    //   }
    //   j = list.length + k;
    // } else {
    //   j = 13;
    // }
    // for (int i = 0; i < j; i++) {
    //   if (i > list.length - 1) {
    //     // map = {
    //     //   "product_name": "",
    //     //   "qty": "",
    //     //   "rate": "",
    //     //   "amount": "",
    //     //   "discount_amount": "",
    //     //   'tax_perc': "",
    //     //   "tax": "",
    //     //   "net_rate": ""
    //     // };
    //     data1 = ["", "", "", "", "", "", "", ""];
    //   } else {
    //     map = list[i];
    //     data1 = returnRows(map, (i + 1).toString());
    //   }

    //   data.add(data1);
    // }

    for (int i = 0; i < list.length; i++) {
      data1 = returnRows(list[i], (i + 1).toString());
      data.add(data1);
    }

    double sum = 0.0;
    double amount_tot = 0.0;
    double gstTot = 0.0;
    double discTot = 0.0;

    for (int i = 0; i < list.length; i++) {
      sum = double.parse(list[i]["net_rate"]) + sum;
      amount_tot = double.parse(list[i]["amount"]) + amount_tot;
      gstTot = double.parse(list[i]["tax"]) + gstTot;
      discTot = double.parse(list[i]["discount_amount"]) + discTot;
    }
    // returnTotal(list);
    List<dynamic> tot = [
      "",
      "Amount / Discount / GST Total",
      "",
      "",
      amount_tot,
      discTot,
      gstTot,
      ""
    ];
    List<dynamic> tot1 = [
      "",
      "Grand Total",
      "",
      "",
      "",
      "",
      "",
      sum.toStringAsFixed(2)
    ];
    // // List<dynamic> tot2 = [
    // //   "",
    // //   "Amount Total",
    // //   "",
    // //   "",
    // //   amount_tot.toStringAsFixed(2),
    // //   "",
    // //   "",
    // //   "",
    // //   ""
    // // ];

    // data.add(tot2);
    // data.add(tot);
    // data.add(tot1);

    // bord = true;
    print("data----$data1");
///////////////////**************************************************************  */
    // List<List<dynamic>> data = [];
    // for (int i = 0; i < list.length; i++) {
    //   data1 = returnRows(list[i], (i + 1).toString());

    //   data.add(data1);
    // }
    // // List<dynamic> m = ["Grand Total", "400"];
    // // data.add(m);
    // print("data----$data1");
///////////////************************************************/////////////////// */
    // final data = list.map((item) {
    //   print("sdjsjkh----${item["qty"].runtimeType}");
    //   i = i + 1;

    //   // double total = double.parse(item["qty"]) * item["rate"] ;
    //   double netrate = double.parse(item["net_rate"]!);

    //   return [
    //     i,
    //     item["product_name"],
    //     item["qty"],
    //     item["rate"],
    //     item["amount"],
    //     item["discount_amount"],
    //     item["tax_perc"],
    //     item["tax"],
    //     netrate.toStringAsFixed(2),
    //   ];
    // }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      tableWidth: TableWidth.max,

      // cellDecoration: (index, data, rowNum) {
      //   return TableRow(children: children)
      // },
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
      headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
      cellStyle: TextStyle(fontSize: 8),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 10,
      columnWidths: {
        // 0: FixedColumnWidth(50),
              1: FixedColumnWidth(190),

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
        // 8: Alignment.centerRight,
      },
    );
  }

returnRows(Map listmap, String i) {
    double netrate = double.parse(listmap["net_rate"]!);
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String parsedstring1 = listmap["product_desc"].replaceAll(exp, '');
    
    return [
      i,
      "${listmap["product_name"]}  \n $parsedstring1",
      listmap["qty"],
      listmap["rate"],
      listmap["amount"],
      listmap["discount_amount"],
      // listmap["tax_perc"],
      listmap["tax"],
      netrate.toStringAsFixed(2),
    ];
  }

  ////////////////////////////////////////////////////
  Widget buildTotal(
    List<Map<String, dynamic>> list,
    ImageProvider image,
  ) {
    double sum = 0.0;
    double amount_tot = 0.0;
    double gstTot = 0.0;
    double disctTot = 0.0;

    for (int i = 0; i < list.length; i++) {
      sum = double.parse(list[i]["net_rate"]) + sum;
      amount_tot = double.parse(list[i]["amount"]) + amount_tot;
      gstTot = double.parse(list[i]["tax"]) + gstTot;
      disctTot = double.parse(list[i]["discount_amount"]) + disctTot;
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
                SizedBox(height: 2 * PdfPageFormat.mm),

                Row(children: [
                  Expanded(
                      child: Text(
                    'Amount total',
                  )),
                  Container(
                    child: Image(image, height: 8, width: 9),
                  ),
                  Text(
                    "${amount_tot.toStringAsFixed(2)}",
                  )
                ]),
                SizedBox(height: 2 * PdfPageFormat.mm),

                Row(children: [
                  Expanded(
                      child: Text(
                    'Discount total',
                  )),
                  Container(
                    child: Image(image, height: 8, width: 9),
                  ),
                  Text(
                    "${disctTot.toStringAsFixed(2)}",
                  )
                ]),

                SizedBox(height: 2 * PdfPageFormat.mm),
                Row(children: [
                  Expanded(
                      child: Text(
                    'GST total',
                  )),
                  Container(
                    child: Image(image, height: 8, width: 9),
                  ),
                  Text(
                    "${gstTot.toStringAsFixed(2)}",
                  )
                ]),
                Divider(),

                Row(children: [
                  Expanded(
                      child: Text(
                    'Grand total',
                  )),
                  Container(
                    child: Image(image, height: 8, width: 9),
                  ),
                  Text(sum.toStringAsFixed(2))
                ]),
                // buildText(
                //   title: 'Grand total',
                //   value: sum.toStringAsFixed(2),
                //   unite: true,
                // ),

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
          List<Map<String, dynamic>> listterms,
          List<Map<String, dynamic>> msg_log,
          ImageProvider image,
          String staffName) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(msg_log[0]["remarks"], style: TextStyle(fontSize: 9)),
            SizedBox(width: 10),
            msg_log.length>1 
              ? Text(msg_log[1]["remarks"], style: TextStyle(fontSize: 9))
              : Container()

            // Row(children: [
            //   Text("Signature : ", style: TextStyle(fontSize: 8)),
            //   Container(width: 40)
            // ])
          ]),

          // Container(
          //   // width: 100,
          //   // decoration:
          //   //     BoxDecoration(border: Border.all(color: PdfColors.black)),
          //   alignment: Alignment.centerLeft,
          //   child: Padding(
          //       padding: EdgeInsets.all(3),
          //       child: Text("Prepared By : $staffName",
          //           style: TextStyle(fontSize: 10))),
          // ),
          // Container(
          //   width:400 ,
          //     // margin: const EdgeInsets.all(15.0),
          //     // padding: const EdgeInsets.all(3.0),
          //     decoration:
          //         BoxDecoration(border: Border.all(color: PdfColors.black)),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //       Text("Prepared By  : ", style: TextStyle(fontSize: 13)),
          //       Text(staffName, style: TextStyle(fontSize: 12))
          //     ])),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title: listterms[0]["t_head"], value: listterms[0]["t_detail"]),
          // SizedBox(height: 1 * PdfPageFormat.mm),
          // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Row(children: [
            Text(
                " * This quotation is system generated hence no signature required * ",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))
          ]),
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

  /////////////////////////////////////////////////
  Future<File> savedocument(
      {required String name, required pw.Document pdf}) async {
    // final bytes = pdf.save();

    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/${name}');

    await file.writeAsBytes(await pdf.save());
    // sendFile(file);
    return file;
  }
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
    print("dir----$dirPath");
    // Directory folder = Directory(dirPath);
    // if (await folder.exists()) {
    //   print("Folder exists");
    // } else {
    //   try {
    //     await folder.create(recursive: true);
    //   } catch (e) {}
    // }
    await Directory(dirPath).create(recursive: true);

    final file = File('${dirPath}/${name}');
    print("file---------$file");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
