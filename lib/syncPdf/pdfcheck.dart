import 'package:bestengineer/syncPdf/hhh.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfCheck extends StatefulWidget {
  const PdfCheck({super.key});

  @override
  State<PdfCheck> createState() => _PdfCheckState();
}

class _PdfCheckState extends State<PdfCheck> {
  HHH hh = HHH();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(useActions: false, build: (context) => hh.generate()),
    );
  }
}
