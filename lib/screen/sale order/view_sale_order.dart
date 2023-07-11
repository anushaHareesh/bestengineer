import 'package:bestengineer/components/dateFind.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/screen/sale%20order/view_so_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';

class ViewSaleOrder extends StatefulWidget {
  const ViewSaleOrder({super.key});

  @override
  State<ViewSaleOrder> createState() => _ViewSaleOrderState();
}

class _ViewSaleOrderState extends State<ViewSaleOrder> {
  DateFind dateFind = DateFind();
  String? todaydate;
  DateTime now = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    // Provider.of<QuotationController>(context, listen: false).fromDate = null;
    // Provider.of<QuotationController>(context, listen: false).todate = null;
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
                              .viewSaleOrder(context, df, tf);
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
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpinKitCircle(
                        color: P_Settings.loginPagetheme,
                      ),
                    ],
                  )
                : value.saleOrderList.length == 0
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
                        itemCount: value.saleOrderList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                color: Colors.grey[100],
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8, left: 0, right: 0),
                                  child: ListTile(
                                    // trailing: Image.asset(
                                    //   "assets/right.png",
                                    //   height: size.height * 0.04,
                                    // ),
                                    onTap: () {
                                      Provider.of<QuotationController>(context,
                                              listen: false)
                                          .getSaleOrderDetails(
                                              context,
                                              value.saleOrderList[index]
                                                  ["so_id"]);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewSODetails(
                                                  title:
                                                      value.saleOrderList[index]
                                                          ["so_series"],
                                                  // qtn_id:
                                                  //     value.pendingSaleOrder[
                                                  //         index]["qtn_id"],
                                                  // so_id: value.pendingSaleOrder[
                                                  //     index]["so_id"],
                                                )),
                                      );
                                    },
                                    // leading: ,
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${value.saleOrderList[index]["so_series"]}",
                                          // "jhjdfdjfndjkfnjkdzxnfdjknf gfg dgdxfggggggggggggggggggggggggggggggggggggggg",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          height: 19,
                                        ),
                                        value.saleOrderList[index]
                                                        ["company_add1"] !=
                                                    null &&
                                                value
                                                    .saleOrderList[index]
                                                        ["company_add1"]
                                                    .isNotEmpty
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Address    :  ",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        // "hdjshdjshdjsds sjdhjsdhjsz szjdhsjdhbsh jsdhjshd szghszhfusahyf",
                                                        "${value.saleOrderList[index]["company_add1"]}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey[900]),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        value.saleOrderList[index]["phone_1"] !=
                                                    null &&
                                                value
                                                    .saleOrderList[index]
                                                        ["phone_1"]
                                                    .isNotEmpty
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Phone        :  ",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        // "hdjshdjshdjsds sjdhjsdhjsz szjdhsjdhbsh jsdhjshd szghszhfusahyf",
                                                        "${value.saleOrderList[index]["phone_1"]}",
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        value.saleOrderList[index]["remarks"] ==
                                                    null ||
                                                value
                                                    .saleOrderList[index]
                                                        ["remarks"]
                                                    .isEmpty
                                            ? Container()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Remarks  :  ",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${value.saleOrderList[index]["remarks"]}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey[900]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        value.saleOrderList[index]
                                                        ["pay_type"] !=
                                                    null &&
                                                value
                                                    .saleOrderList[index]
                                                        ["pay_type"]
                                                    .isNotEmpty
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Pay Type  :  ",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "${value.saleOrderList[index]["pay_type"]}",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        Divider(
                                          thickness: 1,
                                          height: 19,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Adv Amt : ",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey[600]),
                                                ),
                                                Text(
                                                  // "2000000000005500.00",
                                                  "\u{20B9}${value.saleOrderList[index]["adv_amount"]}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Pending Amt : ",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors
                                                                .grey[600])),
                                                    Container(
                                                      child: Text(
                                                        //  "2000000000055000.00",
                                                        "\u{20B9}${value.saleOrderList[index]["pending_amount"]}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    // subtitle: value.saleOrderList[index]
                                    //                 ["remarks"] ==
                                    //             null ||
                                    //         value
                                    //             .saleOrderList[index]["remarks"]
                                    //             .isEmpty
                                    //     ?Container(): Padding(
                                    //         padding:
                                    //             const EdgeInsets.only(top: 8.0),
                                    //         child: Row(
                                    //           children: [
                                    //             Text("Remarks  : "),
                                    //             Expanded(
                                    //               child: Text(
                                    //                 "${value.saleOrderList[index]["remarks"]}",
                                    //                 style:
                                    //                     TextStyle(fontSize: 13,color: Colors.grey[900]),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       )
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ))
          ],
        ),
      ),
    );
  }
}
