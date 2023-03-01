import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class SimpleSync extends StatefulWidget {
  const SimpleSync({super.key});

  @override
  State<SimpleSync> createState() => _SimpleSyncState();
}

class _SimpleSyncState extends State<SimpleSync> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
        child: Text("click"),
        onPressed: () {
          _createPDF();
        },
      ),
    );
  }

  Future<void> _createPDF() async {
    //Create a PDF document
    final PdfDocument document = PdfDocument();
    //Add a new page
    final PdfPage page = document.pages.add();

    //Create a string format to set text alignment
    final PdfStringFormat format = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle);
    final PdfStringFormat middleFormat =
        PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle);

    //Create padding, borders for PDF grid
    final PdfPaddings padding = PdfPaddings(left: 2);
    final PdfPen linePen = PdfPen(PdfColor(0, 0, 0), width: 2);
    final PdfPen lastRowBorderPen = PdfPen(PdfColor(0, 0, 0), width: 1);
    final PdfBorders borders = PdfBorders(
        left: linePen, top: linePen, bottom: linePen, right: linePen);
    final PdfBorders lastRowBorder = PdfBorders(
        left: linePen, top: linePen, bottom: lastRowBorderPen, right: linePen);

    //Create a new font
    final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 9);

    //Drawing the grid as two seperate grids

    //Create a grid
    final PdfGrid headerGrid = PdfGrid();
    //Set font for all cells
    headerGrid.style.font = font;
    //Add columns
    headerGrid.columns.add(count: 3);
    //Set column width
    headerGrid.columns[0].width = 80;
    headerGrid.columns[2].width = 80;
    //Add a row
    final PdfGridRow headerRow1 = headerGrid.rows.add();
    //Set row height
    headerRow1.height = 70;
    //Add cell value and style properties
    headerRow1.cells[0].value = 'COMPANY LOGO (ROUND)';
    headerRow1.cells[0].style.stringFormat = format;
    headerRow1.cells[1].value = 'SHREE NNANSHARDA JEWELLERY (LOGO)';
    headerRow1.cells[1].style.stringFormat = format;
    headerRow1.cells[1].columnSpan = 2;
    final PdfGridRow headerRow2 = headerGrid.rows.add();
    headerRow2.cells[0].value = '';
    headerRow2.cells[0].columnSpan = 3;
    headerRow2.height = 15;
    final PdfGridRow headerRow3 = headerGrid.rows.add();
    headerRow3.cells[0].value = 'PARTY NAME:';
    headerRow3.cells[0].style.stringFormat = middleFormat;
    headerRow3.cells[0].style.cellPadding = padding;
    headerRow3.cells[2].value = 'DATE:';
    headerRow3.cells[2].style.stringFormat = middleFormat;
    headerRow3.cells[2].style.cellPadding = padding;
    final PdfGridRow headerRow4 = headerGrid.rows.add();
    headerRow4.cells[0].value = '';
    headerRow4.cells[0].columnSpan = 3;
    headerRow4.height = 25;
    //Set border for all rows
    for (int i = 0; i < headerGrid.rows.count; i++) {
      final PdfGridRow headerRow = headerGrid.rows[i];
      if (i == headerGrid.rows.count - 1) {
        for (int j = 0; j < headerRow.cells.count; j++) {
          headerRow.cells[j].style.borders = lastRowBorder;
        }
      } else {
        for (int j = 0; j < headerRow.cells.count; j++) {
          headerRow.cells[j].style.borders = borders;
        }
      }
    }
    //Draw grid and get drawn bounds
    final PdfLayoutResult result =
        headerGrid.draw(page: page, bounds: const Rect.fromLTWH(1, 1, 0, 0))!;

    //Create a new grid
    PdfGrid contentGrid = PdfGrid();
    contentGrid.style.font = font;
    contentGrid.columns.add(count: 4);
    //Add grid header
    contentGrid.headers.add(1);
    contentGrid.columns[0].width = 40;
    contentGrid.columns[1].width = 140;
    contentGrid.columns[3].width = 80;
    //Get header and set values
    final PdfGridRow contentHeader = contentGrid.headers[0];
    contentHeader.cells[0].value = 'SR NO';
    contentHeader.cells[0].style.stringFormat = format;
    contentHeader.cells[0].style.borders = borders;
    contentHeader.cells[1].value = 'PRODUCT IMAGE';
    contentHeader.cells[1].style.stringFormat = format;
    contentHeader.cells[1].style.borders = borders;
    contentHeader.cells[2].value = 'PRODUCT DETAILS';
    contentHeader.cells[2].style.stringFormat = format;
    contentHeader.cells[2].style.borders = borders;
    contentHeader.cells[3].value = 'QUANTITY';
    contentHeader.cells[3].style.stringFormat = format;
    contentHeader.cells[3].style.borders = borders;
    //Add content rows
    contentGrid =
        await _addContentRow('1', contentGrid, format, middleFormat, padding);
    contentGrid =
        await _addContentRow('2', contentGrid, format, middleFormat, padding);
    contentGrid =
        await _addContentRow('3', contentGrid, format, middleFormat, padding);
    contentGrid =
        await _addContentRow('4', contentGrid, format, middleFormat, padding);
    contentGrid =
        await _addContentRow('5', contentGrid, format, middleFormat, padding);
    contentGrid =
        await _addContentRow('6', contentGrid, format, middleFormat, padding);
    //Add a new row
    final PdfGridRow totalRow = contentGrid.rows.add();
    totalRow.cells[0].value = 'TOTAL QUANTITY';
    //Set column span
    totalRow.cells[0].columnSpan = 3;
    totalRow.cells[0].style.stringFormat = format;
    totalRow.height = 25;
    //Set borders for all cells in grid
    for (int i = 0; i < contentGrid.rows.count; i++) {
      final PdfGridRow contentRow = contentGrid.rows[i];
      for (int j = 0; j < contentRow.cells.count; j++) {
        contentRow.cells[j].style.borders = borders;
      }
    }
    //Draw content grid based on the bounds calculated in first grid
    contentGrid.draw(
        page: result.page,
        bounds:
            Rect.fromLTWH(1, result.bounds.top + result.bounds.height, 0, 0));

    //Save PDF document
    final List<int> bytes = await document.save();
    //Dispose the document
    document.dispose();

    //Get external storage directory
    Directory directory = (await getApplicationDocumentsDirectory())!;
    //Get directory path
    String path = directory.path;
    //Create an empty file to write PDF data
    File file = File('$path/Output.pdf');
    //Write PDF data
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document in mobile
    OpenFilex.open('$path/Output.pdf');
  }

  //Custom method to create content row and set style properties
  Future<PdfGrid> _addContentRow(
      String srNo,
      PdfGrid grid,
      PdfStringFormat format,
      PdfStringFormat middleFormat,
      PdfPaddings padding) async {
    //Add a row
    final PdfGridRow contentRow1 = grid.rows.add();
    //Set height
    contentRow1.height = 15;
    //Set values and style properties
    contentRow1.cells[0].value = srNo;
    contentRow1.cells[0].style.stringFormat = format;
    //Set row span
    contentRow1.cells[0].rowSpan = 6;
    contentRow1.cells[1].rowSpan = 6;
    contentRow1.cells[2].value = '';
    contentRow1.cells[3].rowSpan = 6;
    final PdfGridRow contentRow2 = grid.rows.add();
    contentRow2.cells[2].value = 'DESIGN NO-';
    contentRow2.cells[2].style.cellPadding = padding;
    contentRow2.cells[2].style.stringFormat = middleFormat;
    final PdfGridRow contentRow3 = grid.rows.add();
    contentRow3.cells[2].value = 'GROSS WEIGHT-';
    contentRow3.cells[2].style.cellPadding = padding;
    contentRow3.cells[2].style.stringFormat = middleFormat;
    final PdfGridRow contentRow4 = grid.rows.add();
    contentRow4.cells[2].value = 'DIAMOND CTS-';
    contentRow4.cells[2].style.cellPadding = padding;
    contentRow4.cells[2].style.stringFormat = middleFormat;
    final PdfGridRow contentRow5 = grid.rows.add();
    contentRow5.cells[2].value = 'GOLD COLOUR-';
    contentRow5.cells[2].style.cellPadding = padding;
    contentRow5.cells[2].style.stringFormat = middleFormat;
    final PdfGridRow contentRow6 = grid.rows.add();
    contentRow6.cells[2].value = '';
    contentRow6.height = 15;
    final PdfGridRow contentRow7 = grid.rows.add();
    contentRow7.cells[0].value = '';
    contentRow7.cells[0].columnSpan = 4;
    contentRow7.height = 5;
    return grid;
  }
}
