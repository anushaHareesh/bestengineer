import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HHH {
  Future<Uint8List> generate() async {
    final pdf = Document();
    final image = await imageFromAssetBundle('assets/noImg.png');

    pdf.addPage(
      MultiPage(
      pageFormat: PdfPageFormat.a4,

      build: (context) => [
        // buildHeader(image),
        Divider(),

        imageSet(image),
        // SizedBox(height: 0.1 * PdfPageFormat.cm),
        // buildCustomerData(masterPdf),
        // SizedBox(height: 0.5 * PdfPageFormat.cm),
        // buildInvoice(detailPdf),
        // // Divider(),
        // SizedBox(height: 5),

        // buildTotal(detailPdf),
      ],
      header: (context) => buildHeader(image),
      footer: (context) => buildFooter(),
    ));

    return pdf.save();
  }

  Widget imageSet(ImageProvider image) {
    return Stack(children: [
      Container(
        height: 800,
        child: Image(image),
      ),
      Container(child: Text("jhsdjhsjdhs")),
      Positioned(
        top: 100,
        child: Container(child: Text("jhsdjhsjdhs")),
      ),
      Container(child: Text("jhsdjhsjdhs")),
      Container(child: Text("jhsdjhsjdhs")),
      Container(child: Text("jhsdjhsjdhs")),
      Container(child: Text("jhsdjhsjdhs")),
    ]);
    // return Container(height: double.infinity, child: Image(image));
  }

  Widget buildHeader(ImageProvider im) {
    return Row(children: [SizedBox(height: 60, child: Image(im))]);
  }
   Widget buildFooter() {
   return Column(children: [
      Row(
        children: [
          Text("Terms :",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Flexible(
              child: Text("khjkshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhjkfhlzkjfffffffffffffffffffffffffffffffffffffffffffffffffff",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 9,
                  ))),
        ],
      ),
      // Divider(endIndent: 330),
      // Row(children: [
      //   Flexible(child: Text(value)),
      // ])
    ]);
  }
}
