import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UserwiseReport extends StatefulWidget {
  const UserwiseReport({super.key});

  @override
  State<UserwiseReport> createState() => _UserwiseReportState();
}

class _UserwiseReportState extends State<UserwiseReport> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<QuotationController>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return SpinKitCircle(
              color: P_Settings.loginPagetheme,
            );
          } else {
            if (value.userwiseReportList.length == 0) {
              return Lottie.asset("assets/noData.json");
            } else {
              return ListView.builder(
                itemCount: value.userwiseReportList.length,
                itemBuilder: (context, index) {
                  // return buildCard(
                  //     value.userwiseReportList[index]["NAME"].toUpperCase(),
                  //     value.userwiseReportList[index]["Enquiry Count"],
                  //     value.userwiseReportList[index]["Quotation Pending"],
                  //     value.userwiseReportList[index]["Quotation Confirmed"],
                  //     size);
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("assets/man.png"),
                        ),
                        title: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  value.userwiseReportList[index]["NAME"]
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: P_Settings.loginPagetheme,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Divider(),
                            // Row(
                            //   children: [
                            //     Text("Enq Count : "),
                            //     ClipRRect(
                            //       borderRadius: BorderRadius.circular(12.0),
                            //       child: Container(
                            //           color: Colors.red,

                            //           child: Padding(
                            //             padding: const EdgeInsets.all(8.0),
                            //             child: Text(
                            //               value.userwiseReportList[index]
                            //                   ["Enquiry Count"],
                            //               style: TextStyle(color: Colors.white),
                            //             ),
                            //           )),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              children: [
                                Expanded(
                                  // width: size.width*0.4,
                                  child: Text(
                                    "Enquiry Count",
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 13),
                                  ),
                                ),
                                Text(
                                  value.userwiseReportList[index]
                                      ["Enquiry Count"],
                                  // style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    // width: size.width*0.4,
                                    child: Text(
                                      "Quotation Conirmed ",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 13),
                                    ),
                                  ),
                                  Text(
                                    value.userwiseReportList[index]
                                        ["Quotation Confirmed"],
                                    // style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    // width: size.width*0.4,
                                    child: Text(
                                      "Quotation Pending",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 13),
                                    ),
                                  ),
                                  Text(
                                    value.userwiseReportList[index]
                                        ["Quotation Pending"],
                                    // style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  Widget buildCard(
      String name, String enq, String quotCount, String quotConfrm, Size size) {
    return Consumer<QuotationController>(
      builder: (context, value, child) {
        return Card(
          child: Row(
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/man.png",
                    height: size.height * 0.06,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name.toUpperCase(),
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Enq Count : "),
                      Text(
                        enq,
                        // style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Quotation Conirmed: "),
                      Text(
                        quotConfrm,
                        // style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Quotation Pending: "),
                      Text(
                        quotCount,
                        // style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
