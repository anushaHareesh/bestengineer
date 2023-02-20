import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({super.key});

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        title: Text("Shedule List"),
      ),
      body: Consumer<QuotationController>(
        builder: (context, value, child) {
          if (value.isSchedulelIstLoadind) {
            return SpinKitCircle(
              color: P_Settings.loginPagetheme,
            );
          } else if (value.scheduleList.length == 0) {
            return Container(
              child: Lottie.asset("assets/noData.json"),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: value.scheduleList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[100],
                    child: ListTile(
                      // leading: CircleAvatar(
                      //   radius: 18,
                      //   backgroundImage: AssetImage(
                      //     "assets/calendar.png",
                      //   ),
                      //   backgroundColor: Colors.transparent,
                      // ),
                      title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  value.scheduleList[index]["s_invoice_no"]
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            indent: 40,
                            endIndent: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.orange,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Inv Date        :  ",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[500]),
                                ),
                                Flexible(
                                  child: Text(
                                    value.scheduleList[index]["s_invoice_date"]
                                        .toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 8.0, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.business,
                                  color: Colors.green,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Com Name  :  ",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[500]),
                                ),
                                Flexible(
                                  child: Text(
                                    value.scheduleList[index]["s_customer_name"]
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                  size: 17,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Ph                      :  ",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[500]),
                                ),
                                Flexible(
                                  child: Text(
                                    value.scheduleList[index]["phone_1"]
                                        .toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                          value.scheduleList[index]["company_add1"] == null ||
                                  value.scheduleList[index]["company_add1"]
                                      .isEmpty
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 8.0, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.place,
                                        color: Colors.red,
                                        size: 17,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Com Info       :  ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[500]),
                                      ),
                                      Flexible(
                                        child: Text(
                                          value.scheduleList[index]
                                                  ["company_add1"]
                                              .toString(),
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          value.scheduleList[index]["owner_name"] == null ||
                                  value
                                      .scheduleList[index]["owner_name"].isEmpty
                              ? Container()
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.orange,
                                        size: 17,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Contact Person : ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[500]),
                                      ),
                                      Flexible(
                                        child: Text(
                                          value.scheduleList[index]
                                                  ["owner_name"]
                                              .toString(),
                                          style: TextStyle(fontSize: 14),
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
              ),
            );
          }
        },
      ),
    );
  }
}
