import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/dateFind.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DealerWiseReport extends StatefulWidget {
  const DealerWiseReport({super.key});

  @override
  State<DealerWiseReport> createState() => _DealerWiseReportState();
}

class _DealerWiseReportState extends State<DealerWiseReport> {
  DateFind dateFind = DateFind();
  String? todaydate;
  DateTime now = DateTime.now();
  String? selected;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    Provider.of<QuotationController>(context, listen: false).fromDate = null;
    Provider.of<QuotationController>(context, listen: false).todate = null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: P_Settings.fillcolor,
      body: Consumer<QuotationController>(
        builder: (context, value, child) {
          return Column(
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
                                .getDealerWiseReport(context, df, tf);
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
              value.isLoading
                  ? Container(
                      height: size.height * 0.67,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SpinKitCircle(
                            color: P_Settings.loginPagetheme,
                          ),
                        ],
                      ),
                    )
                  : value.dealerwiseReportList.length == 0
                      ? Container(
                          height: size.height * 0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset("assets/noData.json",
                                  height: size.height * 0.2),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: value.dealerwiseReportList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            value.dealerwiseReportList[index]
                                                    ["s_customer_name"]
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[700]),
                                          ),
                                          // Divider(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.numbers,
                                                  color: Colors.blue,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: size.height * 0.01,
                                                ),
                                                Text(
                                                  "Inv No                      :   ",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey[500]),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    value.dealerwiseReportList[
                                                            index]
                                                            ["s_invoice_no"]
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Colors.grey[700]),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.orange,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: size.height * 0.01,
                                                ),
                                                Text(
                                                  "Inv date                   :   ",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey[500]),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    value.dealerwiseReportList[
                                                            index]
                                                            ["s_invoice_date"]
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Colors.grey[700]),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.business,
                                                  color: Colors.brown,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: size.height * 0.01,
                                                ),
                                                Text(
                                                  "Com Name            :   ",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey[500]),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    value.dealerwiseReportList[
                                                            index]
                                                            ["company_name"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Colors.grey[700]),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          value.dealerwiseReportList[index]
                                                          ["cancel_remark"] ==
                                                      null ||
                                                  value
                                                      .dealerwiseReportList[
                                                          index]
                                                          ["cancel_remark"]
                                                      .isEmpty
                                              ? Container()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.note,
                                                        color: Colors.red,
                                                        size: 16,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.height * 0.01,
                                                      ),
                                                      Text(
                                                        "Cancel Remark   :   ",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors
                                                                .grey[500]),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          value
                                                              .dealerwiseReportList[
                                                                  index][
                                                                  "cancel_remark"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .grey[700]),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Prepared by: ",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Colors.grey[500]),
                                                  ),
                                                  Text(
                                                    value.dealerwiseReportList[
                                                            index]
                                                            ["prepared_by"]
                                                        .toString()
                                                        .toUpperCase(),
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Total Amt : ",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Colors.grey[500]),
                                                  ),
                                                  Text(
                                                    "\u{20B9}${value.dealerwiseReportList[index]["s_total_net_amount"].toString()} ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            },
                          ),
                        ),
            ],
          );
        },
      ),
    );
  }
}
