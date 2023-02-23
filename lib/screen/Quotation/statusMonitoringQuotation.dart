import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class QuotationStatusMonitoring extends StatefulWidget {
  String? title;
  QuotationStatusMonitoring({this.title});

  @override
  State<QuotationStatusMonitoring> createState() =>
      _QuotationStatusMonitoringState();
}

class _QuotationStatusMonitoringState extends State<QuotationStatusMonitoring> {
  int? i;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    i = 0;
  }

  @override
  Widget build(BuildContext context) {
    i = 0;
    print("hfhh---$i");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title.toString().toUpperCase(),
            style: TextStyle(fontSize: 15),
          ),
          backgroundColor: P_Settings.loginPagetheme,
        ),
        body: SingleChildScrollView(
          child: Consumer<Controller>(
            builder: (context, value, child) {
              if (value.isStatusMon) {
                return Container(
                  height: size.height * 0.8,
                  child: SpinKitCircle(
                    color: P_Settings.loginPagetheme,
                  ),
                );
              } else {
                return Container(
                  // height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      top: 18,
                    ),
                    child: Column(
                        children: value.statusMon.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 8, right: 5),
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    color: P_Settings.lightPurple,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: P_Settings.loginPagetheme)),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(e["remarks"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                          e["NAME"] +
                                              " " +
                                              "/" +
                                              "  " +
                                              e["added_on"],
                                          // "sfhdhsfjkhfkjfkjsfkjjmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm",
                                          // overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[500],
                                              fontSize: 15)),
                                    ),
                                  ],
                                ),
                              )
                              // Expanded(
                              //   child: ListTile(
                              //     title: Text(e["title"],
                              //         style:
                              //             TextStyle(fontWeight: FontWeight.bold)),
                              //     subtitle: Text("12/23/2023"),
                              //   ),
                              // ),
                            ],
                          ),
                          // i == value.statusMon.length
                          //     ? Container()
                          //     :

                          Container(
                            margin: EdgeInsets.only(left: 17),
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 40),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              color: P_Settings.loginPagetheme,
                            ))),
                            // child: Text(e["content"]
                            // ),
                          ),
                        ],
                      );
                    }).toList()),
                  ),
                );
              }
            },
          ),
        ));
  }
}
