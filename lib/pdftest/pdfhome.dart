
import 'package:bestengineer/pdftest/pdfModel.dart';
import 'package:bestengineer/pdftest/pdfPreview.dart';
import 'package:bestengineer/pdftest/pdfdetail.dart';
import 'package:flutter/material.dart';

class PdfHome extends StatefulWidget {
  const PdfHome({super.key});

  @override
  State<PdfHome> createState() => _PdfHomeState();
}

class _PdfHomeState extends State<PdfHome> {
  final invoices = [
    Invoice(
      customer: 'David Thomas',
      address: '123 Fake St\r\nBermuda Triangle',
      items: [
        LineItem(
          'Technical Engagement',
          120,
        ),
        LineItem('Deployment Assistance', 200),
        LineItem('Develop Software Solution', 3020.45),
        LineItem('Produce Documentation', 840.50),
      ],
    ),
    Invoice(
      customer: 'Michael Ambiguous',
      address: '82 Unsure St\r\nBaggle Palace',
      items: [
        LineItem('Professional Advice', 100),
        LineItem('Lunch Bill', 43.55),
        LineItem('Remote Assistance', 50),
      ],
    ),
    Invoice(
      customer: 'Marty McDanceFace',
      address: '55 Dancing Parade\r\nDance Place',
      items: [
        LineItem('Program the robots', 400.50),
        LineItem('Find tasteful dance moves for the robots', 80.55),
        LineItem('General quality assurance', 80),
      ],
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices'),
      ),
      body: Column(children: [
        ElevatedButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PdfPreviewPage(),
                ),
              );
            },
            child: Text("pdf"))
      ]),
      // body: ListView(
      //   children: [
      //     ...invoices.map(
      //       (e) => ListTile(
      //         // title: Text(e.name),
      //         subtitle: Text(e.customer),
      //         trailing: Text('\$${e.totalCost().toStringAsFixed(2)}'),
      //         onTap: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (builder) => DetailPage(invoice: e),
      //             ),
      //           );
      //         },
      //       ),
      //     )
      // ],
      // ),
    );
  }
}
