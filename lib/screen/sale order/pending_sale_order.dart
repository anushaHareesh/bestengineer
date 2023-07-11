import 'package:bestengineer/components/dateFind.dart';
import 'package:bestengineer/screen/sale%20order/sale_order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';
import '../../controller/quotationController.dart';

class PendingSaleOrder extends StatefulWidget {
  const PendingSaleOrder({super.key});

  @override
  State<PendingSaleOrder> createState() => _PendingSaleOrderState();
}

class _PendingSaleOrderState extends State<PendingSaleOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    // Provider.of<QuotationController>(context, listen: false).fromDate = null;
    // Provider.of<QuotationController>(context, listen: false).todate = null;
  }

  DateFind dateFind = DateFind();
  String? todaydate;
  DateTime now = DateTime.now();
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
                              .getPendingSaleOrder(context, df, tf);
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
                : value.pendingSaleOrder.length == 0
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
                        itemCount: value.pendingSaleOrder.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                color: Colors.grey[100],
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    trailing: Image.asset(
                                      "assets/right.png",
                                      height: size.height * 0.04,
                                    ),
                                    onTap: () {
                                      Provider.of<QuotationController>(context,
                                              listen: false)
                                          .getSaleOrderDetails(
                                              context,
                                              value.pendingSaleOrder[index]
                                                  ["so_id"]);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SaleOrderDetails(
                                                  title: value.pendingSaleOrder[
                                                      index]["so_series"],
                                                  qtn_id:
                                                      value.pendingSaleOrder[
                                                          index]["qtn_id"],
                                                  so_id: value.pendingSaleOrder[
                                                      index]["so_id"],
                                                )),
                                      );
                                    },
                                    // leading: ,
                                    title: Text(
                                      "${value.pendingSaleOrder[index]["so_series"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,fontSize: 14),
                                    ),
                                    // subtitle: Text(
                                    //     "SO_ID  : ${value.pendingSaleOrder[index]["so_id"]}"),
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

  Widget saleOrderDetails() {
    return Container(
        color: Colors.grey[100],
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(
                  "jhdjhdbj",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            );
          },
        ));
  }
}
