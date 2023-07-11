import 'dart:math';

import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:bestengineer/screen/Dashboard/admin_dash_tile_page.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/commonColor.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String? userGp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notification();
  }

  // notification() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   userGp = prefs.getString("userGroup");
  //   if (userGp == "1") {
  //     Provider.of<QuotationController>(context, listen: false)
  //         .getCount(context,toda);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(),
      body: SafeArea(
        child: Consumer<RegistrationController>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                value.confrmedQuotGraph == null ||
                        value.confrmedQuotGraph.isEmpty
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "Confirmed Quotation By User".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                value.confrmedQuotGraph == null ||
                        value.confrmedQuotGraph.isEmpty
                    ? Container()
                    : Divider(
                        thickness: 1,
                      ),
                value.confrmedQuotGraph == null ||
                        value.confrmedQuotGraph.isEmpty
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: 1.7,
                          child: DChartBar(
                            data: [
                              {'id': 'Bar', 'data': value.confrmedQuotGraph},
                            ],
                            domainLabelRotation:
                                value.confrmedQuotGraph.length > 6 ? 45 : 0,
                            minimumPaddingBetweenLabel: 2,
                            domainLabelPaddingToAxisLine: 16,
                            axisLineTick: 2,
                            axisLinePointTick: 2,
                            axisLinePointWidth: 10,
                            axisLineColor: P_Settings.loginPagetheme,
                            measureLabelPaddingToAxisLine: 16,
                            barColor: (barData, index, id) => Color(
                                    (Random().nextDouble() * 0xFF4d47c)
                                            .toInt() <<
                                        0)
                                .withOpacity(1),
                            showBarValue: true,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                value.userservDone == null || value.userservDone.isEmpty
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "Service Done By User".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                value.userservDone == null || value.userservDone.isEmpty
                    ? Container()
                    : Divider(
                        thickness: 1,
                      ),
                value.userservDone == null || value.userservDone.isEmpty
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: 1.6,
                          child: DChartPie(
                            data: value.userservDone,
                            donutWidth: 30,
                            labelColor: Colors.black,
                            fillColor: (pieData, index) => Color(
                                    (Random().nextDouble() * 0xFF4d47c)
                                            .toInt() <<
                                        0)
                                .withOpacity(1),
                            showLabelLine: true,
                            pieLabel: (pieData, index) {
                              return "${pieData['domain']}:\n${pieData['measure']}";
                            },
                            labelPosition: PieLabelPosition.outside,
                            // pieLabel: (pieData, index) => "anu",
                            // minimumPaddingBetweenLabel: 2,
                            // domainLabelPaddingToAxisLine: 16,
                            // axisLineTick: 2,
                            // axisLinePointTick: 2,
                            // axisLinePointWidth: 10,
                            // axisLineColor: P_Settings.loginPagetheme,
                            // measureLabelPaddingToAxisLine: 16,
                            // barColor: (barData, index, id) => Color(
                            //         (Random().nextDouble() * 0xFF4d47c).toInt() << 0)
                            //     .withOpacity(1),
                            // showBarValue: true,
                          ),
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<QuotationController>(context, listen: false)
                            .getAdminDashTile(context, "1");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminDashTilePage(
                                    tileId: "1",
                                  )),
                        );
                      },
                      child: Container(
                        height: size.height * 0.15,
                        width: size.width * 0.9,
                        child: Card(
                          elevation: 4,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * 0.05,
                                    width: size.width * 0.15,
                                    child: Image.asset(
                                      "assets/enquiry.png",
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Pending Enquiry",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 23.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    value.isAdminLoading
                                        ? SpinKitThreeBounce(
                                            color: P_Settings.loginPagetheme,
                                            size: 13)
                                        : Text(
                                            value.pendingEnq.toString(),
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    P_Settings.loginPagetheme),
                                          )
                                  ],
                                ),
                              )
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), //<-- SEE HERE
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<QuotationController>(context, listen: false)
                            .getAdminDashTile(context, "2");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminDashTilePage(
                                    tileId: "2",
                                  )),
                        );
                      },
                      child: Container(
                        height: size.height * 0.15,
                        width: size.width * 0.9,
                        child: Card(
                          elevation: 4,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * 0.05,
                                    width: size.width * 0.15,
                                    child: Image.asset(
                                      "assets/quot.png",
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Pending Quotation",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 23.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    value.isAdminLoading
                                        ? SpinKitThreeBounce(
                                            color: P_Settings.loginPagetheme,
                                            size: 13)
                                        : Text(
                                            value.pendingQtn.toString(),
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    P_Settings.loginPagetheme),
                                          )
                                  ],
                                ),
                              )
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), //<-- SEE HERE
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<QuotationController>(context, listen: false)
                            .getAdminDashTile(context, "3");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminDashTilePage(
                                    tileId: "3",
                                  )),
                        );
                      },
                      child: Container(
                        height: size.height * 0.15,
                        width: size.width * 0.9,
                        child: Card(
                          elevation: 4,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * 0.05,
                                    width: size.width * 0.15,
                                    child: Image.asset(
                                      "assets/quot2.png",
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Confirmed Quotation",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 23.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    value.isAdminLoading
                                        ? SpinKitThreeBounce(
                                            color: P_Settings.loginPagetheme,
                                            size: 13)
                                        : Text(
                                            value.cnfQut.toString(),
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    P_Settings.loginPagetheme),
                                          )
                                  ],
                                ),
                              )
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), //<-- SEE HERE
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<QuotationController>(context, listen: false)
                            .getAdminDashTile(context, "4");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminDashTilePage(
                                    tileId: "4",
                                  )),
                        );
                      },
                      child: Container(
                        height: size.height * 0.15,
                        width: size.width * 0.9,
                        child: Card(
                          elevation: 4,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * 0.05,
                                    width: size.width * 0.15,
                                    child: Image.asset(
                                      "assets/service2.png",
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Pending Service",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 23.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    value.isAdminLoading
                                        ? SpinKitThreeBounce(
                                            color: P_Settings.loginPagetheme,
                                            size: 13)
                                        : Text(
                                            value.pendingSer.toString(),
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    P_Settings.loginPagetheme),
                                          )
                                  ],
                                ),
                              )
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), //<-- SEE HERE
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
