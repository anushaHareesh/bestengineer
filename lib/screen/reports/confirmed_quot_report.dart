import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/widgets/bottomsheets/select_branch_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';
import '../../components/dateFind.dart';

class ConfirmedQuotation extends StatefulWidget {
  const ConfirmedQuotation({super.key});

  @override
  State<ConfirmedQuotation> createState() => _ConfirmedQuotationState();
}

class _ConfirmedQuotationState extends State<ConfirmedQuotation> {
  DateFind dateFind = DateFind();
  String? todaydate;
  DateTime now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todaydate = DateFormat('dd-MM-yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Consumer<QuotationController>(
        builder: (context, value, child) => Column(
          children: [
            Container(
              height: size.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            // String df;
                            // String tf;
                            dateFind.selectDateFind(context, "from date");
                            // if (value.fromDate == null) {
                            //   df = todaydate.toString();
                            // } else {
                            //   df = value.fromDate.toString();
                            // }
                            // if (value.todate == null) {
                            //   tf = todaydate.toString();
                            // } else {
                            //   tf = value.todate.toString();
                            // }
                            // Provider.of<Controller>(context, listen: false)
                            //     .historyData(context, splitted[0], "",
                            //         df, tf);
                          },
                          icon: Icon(
                            Icons.calendar_month,
                            // color: P_Settings.loginPagetheme,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Text(
                          value.fromDate == null
                              ? todaydate.toString()
                              : value.fromDate.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            dateFind.selectDateFind(context, "to date");
                          },
                          icon: Icon(Icons.calendar_month)),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          value.todate == null
                              ? todaydate.toString()
                              : value.todate.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                      child: Container(
                    height: size.height * 0.05,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: P_Settings.loginPagetheme,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(2), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          String df;
                          String tf;

                          if (value.fromDate == null) {
                            df = todaydate.toString();
                          } else {
                            df = value.fromDate.toString();
                          }
                          if (value.todate == null) {
                            tf = todaydate.toString();
                          } else {
                            tf = value.todate.toString();
                          }

                          Provider.of<QuotationController>(context,
                                  listen: false)
                              .getConfirmedQuotation(
                            df,
                            tf,
                            context,
                          );
                        },
                        child: Text(
                          "Apply",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.whiteColor,
                          ),
                        )),
                  ))
                ],
              ),
              // dropDownCustom(size,""),
            ),
            Divider(),
            value.isReportLoading
                ? Container(
                  height: size.height * 0.6,
                  child: Center(
                    child: SpinKitCircle(
                        color: P_Settings.loginPagetheme,
                      ),
                  ),
                )
                : value.confrimedQuotList.length == 0
                    ? Container(
                        height: size.height * 0.6,
                        child: Center(
                            child: Lottie.asset("assets/noData.json",
                                height: size.height * 0.2)))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: value.confrimedQuotList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.grey[100],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              // "hfjdfjndfjkfffffnbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
                                              value.confrimedQuotList[index]
                                                  ["s_customer_name"],
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Container(
                                            width: size.width * 0.2,
                                            child: Text(
                                              "Inv No",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600]),
                                            ),
                                          ),
                                          Container(
                                            width: size.width * 0.03,
                                            child: Text(":"),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                value.confrimedQuotList[index]
                                                    ["s_invoice_no"],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[800]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: size.width * 0.2,
                                            child: Text(
                                              "Inv Date",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600]),
                                            ),
                                          ),
                                          Container(
                                            width: size.width * 0.03,
                                            child: Text(":"),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                value.confrimedQuotList[index]
                                                    ["s_invoice_date"],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[800]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: size.width * 0.2,
                                            child: Text(
                                              "Confirmed By",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600]),
                                            ),
                                          ),
                                          Container(
                                            width: size.width * 0.03,
                                            child: Text(":"),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                value.confrimedQuotList[index]
                                                    ["confirmed_by"],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[800]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      InkWell(
                                        onTap: () {
                                          value.branchselected = null;
                                          SelectBranchSheet quot =
                                              SelectBranchSheet();
                                          quot.showRemarkSheet(
                                              context,
                                              value.confrimedQuotList[index]
                                                  ["s_invoice_id"]);
                                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PdfPreview()));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "View PDF",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
