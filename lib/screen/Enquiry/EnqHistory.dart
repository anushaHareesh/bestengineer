import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/dateFind.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/screen/Enquiry/enqHistDetails.dart';
import 'package:bestengineer/screen/Quotation/directQuotation.dart';
import 'package:bestengineer/widgets/bottomsheets/removereason.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../widgets/alertCommon/deletePopup.dart';

class EnQHistory extends StatefulWidget {
  const EnQHistory({super.key});

  @override
  State<EnQHistory> createState() => _EnQHistoryState();
}

class _EnQHistoryState extends State<EnQHistory> {
  DateFind dateFind = DateFind();
  String? date;
  DateTime now = DateTime.now();
  List<String> s = [];
  String? todaydate;
  // DeletePopup deletepopup = DeletePopup();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    s = date!.split(" ");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductController>(context, listen: false)
          .setDate(s[0], s[0]);
    });
    Provider.of<ProductController>(context, listen: false).getEnqhistoryData(
      context,
      "",
      // s[0],
      // s[0],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Provider.of<ProductController>(context, listen: false)
                  .enQhistoryList
                  .length ==
              0
          ? Colors.white
          : Colors.grey[200],
      // appBar: AppBar(
      //   title: Text("Enquiry History"),
      //   backgroundColor: P_Settings.loginPagetheme,
      // ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Consumer<ProductController>(
          builder: (context, value, child) {
            return value.isLoading
                ? Container(
                    height: size.height * 0.8,
                    child: SpinKitCircle(
                      color: P_Settings.loginPagetheme,
                    ),
                  )
                : value.enQhistoryList.length == 0
                    ? Container(
                        height: size.height * 0.8,
                        child: Center(
                          child: Lottie.asset("assets/noData.json",
                              width: size.width * 0.45),
                        ))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.enQhistoryList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          margin:
                                              EdgeInsets.only(left: 10, top: 7),
                                          child: Text(
                                              value.enQhistoryList[index]
                                                  .companyName
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[700],
                                                  fontSize: 14)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text(
                                        //   "Code   : ",
                                        //   style:
                                        //       TextStyle(color: Colors.grey),
                                        // ),
                                        Container(
                                          margin: EdgeInsets.only(left: 0),
                                          child: Text(
                                            "${[
                                              value
                                                  .enQhistoryList[index].enqCode
                                                  .toString()
                                            ]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[700],
                                                fontSize: 13),
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            Text(
                                              "Added on : ",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              value
                                                  .enQhistoryList[index].addedOn
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[700],
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Contact Person  : ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                        Flexible(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              value.enQhistoryList[index]
                                                  .ownerName
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[700],
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 8.0),
                                  //   child: Row(
                                  //     children: [
                                  //       Text(
                                  //         "Added on : ",
                                  //         style:
                                  //             TextStyle(color: Colors.grey),
                                  //       ),
                                  //       Text(
                                  //         value.enQhistoryList[index].addedOn
                                  //             .toString(),
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //              color: Colors.grey[700],
                                  //             fontSize: 15),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Divider(),
                                  InkWell(
                                    onTap: () {
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

                                      RemoveReason reason = RemoveReason();
                                      reason.showDeleteReasonSheet(
                                          context, index);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Remove",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: 14,
                                            )
                                          ],
                                        ),
                                        value.enQhistoryList[index]
                                                    .verify_status ==
                                                "0"
                                            ? Container(
                                                height: size.height * 0.05,
                                                child: TextButton(
                                                  onPressed: () {
                                                    Provider.of<QuotationController>(
                                                            context,
                                                            listen: false)
                                                        .getQuotationFromEnqList(
                                                            context,
                                                            value
                                                                .enQhistoryList[
                                                                    index]
                                                                .enqId
                                                                .toString());
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DirectQuotation(
                                                                enqcode: value
                                                                    .enQhistoryList[
                                                                        index]
                                                                    .enqCode
                                                                    .toString(),
                                                                enqId: value
                                                                    .enQhistoryList[
                                                                        index]
                                                                    .enqId
                                                                    .toString(),
                                                              )),
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "[Make Quotation]",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: P_Settings
                                                                .loginPagetheme,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        InkWell(
                                          onTap: () {
                                            Provider.of<ProductController>(
                                                    context,
                                                    listen: false)
                                                .getEnqhistoryDetails(
                                                    context,
                                                    value.enQhistoryList[index]
                                                        .enqId
                                                        .toString());
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EnQHistoryDetails(
                                                        enqId: value
                                                            .enQhistoryList[
                                                                index]
                                                            .enqId
                                                            .toString(),
                                                        enqCode: value
                                                            .enQhistoryList[
                                                                index]
                                                            .enqCode
                                                            .toString(),
                                                      )),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "View",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6.0),
                                                child: Image.asset(
                                                  "assets/eye.png",
                                                  height: 20,
                                                  color: Colors.green,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
          },
        ),
      ),
    );
  }
}
