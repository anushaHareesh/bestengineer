import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../widgets/bottomsheets/visitedRemarkSheet.dart';

class ScheduleListScreen extends StatefulWidget {
  String type;
  ScheduleListScreen({required this.type});

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  Color parseColor(String color) {
    print("Colorrrrr...$color");
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.type == "from menu"
          ? null
          : AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnqHome(
                                  type: "from scheduleList",
                                )));
                  },
                  icon: Icon(Icons.arrow_back)),
              backgroundColor: P_Settings.loginPagetheme,
              title: Text("Shedule List"),
            ),
      body: Consumer<RegistrationController>(
        builder: (context, value, child) {
          if (value.isSchedulelIstLoadind) {
            return SpinKitCircle(
              color: P_Settings.loginPagetheme,
            );
          } else if (value.scheduleList.length == 0) {
            return Center(
              child: Lottie.asset("assets/noData.json", height: 200),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: value.scheduleList.length,
                itemBuilder: (context, index) {
                  return customCard(value.scheduleList[index], index);
                  // return Card(
                  //   color: Colors.grey[100],
                  //   child: ListTile(
                  //     onTap: () {
                  //       VisitedRemarkSheet visited = VisitedRemarkSheet();
                  //       visited.showRemarkSheet(
                  //         context,
                  //       );
                  //     },
                  //     // leading: CircleAvatar(
                  //     //   radius: 18,
                  //     //   backgroundImage: AssetImage(
                  //     //     "assets/calendar.png",
                  //     //   ),
                  //     //   backgroundColor: Colors.transparent,
                  //     // ),
                  //     title: Column(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.only(top: 8.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 value.scheduleList[index]["s_customer_name"]
                  //                     .toString()
                  //                     .toUpperCase(),
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.bold),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //         Divider(
                  //           indent: 40,
                  //           endIndent: 50,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(left: 5.0, right: 5),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               Icon(
                  //                 Icons.calendar_month,
                  //                 color: Colors.orange,
                  //                 size: 17,
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Text(
                  //                 "Inv Date        :  ",
                  //                 style: TextStyle(
                  //                     fontSize: 14, color: Colors.grey[500]),
                  //               ),
                  //               Flexible(
                  //                 child: Text(
                  //                   value.scheduleList[index]["s_invoice_date"]
                  //                       .toString(),
                  //                   style: TextStyle(fontSize: 14),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 5, right: 5, top: 8.0, bottom: 8),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               Icon(
                  //                 Icons.numbers,
                  //                 color: Colors.green,
                  //                 size: 17,
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Text(
                  //                 "Qt No             :  ",
                  //                 style: TextStyle(
                  //                     fontSize: 14, color: Colors.grey[500]),
                  //               ),
                  //               Flexible(
                  //                 child: Text(
                  //                   value.scheduleList[index]["s_invoice_no"]
                  //                       .toString(),
                  //                   style: TextStyle(fontSize: 14),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(left: 5, right: 5),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               Icon(
                  //                 Icons.phone,
                  //                 color: Colors.blue,
                  //                 size: 17,
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Text(
                  //                 "Ph                     :  ",
                  //                 style: TextStyle(
                  //                     fontSize: 14, color: Colors.grey[500]),
                  //               ),
                  //               Flexible(
                  //                 child: Text(
                  //                   value.scheduleList[index]["phone_1"]
                  //                       .toString(),
                  //                   style: TextStyle(fontSize: 14),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //         value.scheduleList[index]["company_add1"] == null ||
                  //                 value.scheduleList[index]["company_add1"]
                  //                     .isEmpty
                  //             ? Container()
                  //             : Padding(
                  //                 padding: const EdgeInsets.only(
                  //                     left: 5, right: 5, top: 8.0, bottom: 8),
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.start,
                  //                   children: [
                  //                     Icon(
                  //                       Icons.place,
                  //                       color: Colors.red,
                  //                       size: 17,
                  //                     ),
                  //                     SizedBox(
                  //                       width: 10,
                  //                     ),
                  //                     Text(
                  //                       "Com Info       :  ",
                  //                       style: TextStyle(
                  //                           fontSize: 14,
                  //                           color: Colors.grey[500]),
                  //                     ),
                  //                     Flexible(
                  //                       child: Text(
                  //                         value.scheduleList[index]
                  //                                 ["company_add1"]
                  //                             .toString(),
                  //                         style: TextStyle(fontSize: 14),
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //         value.scheduleList[index]["owner_name"] == null ||
                  //                 value
                  //                     .scheduleList[index]["owner_name"].isEmpty
                  //             ? Container()
                  //             : Padding(
                  //                 padding:
                  //                     const EdgeInsets.only(left: 5, right: 5),
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.start,
                  //                   children: [
                  //                     Icon(
                  //                       Icons.person,
                  //                       color: Colors.orange,
                  //                       size: 17,
                  //                     ),
                  //                     SizedBox(
                  //                       width: 10,
                  //                     ),
                  //                     Text(
                  //                       "Contact Person : ",
                  //                       style: TextStyle(
                  //                           fontSize: 14,
                  //                           color: Colors.grey[500]),
                  //                     ),
                  //                     Flexible(
                  //                       child: Text(
                  //                         value.scheduleList[index]
                  //                                 ["owner_name"]
                  //                             .toString(),
                  //                         style: TextStyle(fontSize: 14),
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //         // Row(
                  //         //   mainAxisAlignment: MainAxisAlignment.start,
                  //         //   children: [
                  //         //     TextButton(
                  //         //         onPressed: () {
                  //         //           VisitedRemarkSheet visited =
                  //         //               VisitedRemarkSheet();
                  //         //           visited.showRemarkSheet(
                  //         //             context,
                  //         //           );
                  //         //         },
                  //         //         child: Text("Visited"))
                  //         //     // TextButton(
                  //         //     //     style: ElevatedButton.styleFrom(
                  //         //     //         primary: P_Settings.loginPagetheme),
                  //         //     //     onPressed: () {
                  //         //     //       VisitedRemarkSheet visited=VisitedRemarkSheet();
                  //         //     //       visited.showRemarkSheet(context, );
                  //         //     //     },
                  //         //     //     child: Text("Visited")),
                  //         //   ],
                  //         // )
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget customCard(Map list, int index) {
    return Consumer<RegistrationController>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            VisitedRemarkSheet visited = VisitedRemarkSheet();
            visited.showRemarkSheet(
                context,
                value.scheduleList[index]["enq_id"],
                value.scheduleList[index]["s_invoice_id"]);
          },
          child: Card(
            elevation: 3,
            // color: Colors.red,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          // "ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssj",
                          value.scheduleList[index]["s_customer_name"]
                              .toString()
                              .toUpperCase(),
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 4,
                  color: value.scheduleList[index]["l_color"] == null ||
                          value.scheduleList[index]["l_color"].isEmpty
                      ? Colors.grey[100]
                      : parseColor(value.scheduleList[index]["l_color"]),
                ),

                // Row(
                //   children: [
                //     Column(
                //       children: [
                //         Image.asset(
                //           "assets/calendar.png",
                //           height: 28,
                //         ),
                //       ],
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 8.0),
                //       child: Column(
                //         children: [
                //           Text(list["no"]),
                //           Text(list["ph"]),
                //         ],
                //       ),
                //     )
                //   ],
                // )
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        "Inv No : ",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Flexible(
                        child: Text(
                          value.scheduleList[index]["s_invoice_no"].toString(),
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[900]),
                        ),
                      ),
                    ],
                  ),
                  leading:
                      // Image.asset("assets/calendar.png",height: 25,),

                      CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/calendar.png"),
                  ),
                  trailing: Wrap(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 14,
                        color: Color.fromARGB(255, 175, 116, 76),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        value.scheduleList[index]["s_invoice_date"].toString(),
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 14,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        value.scheduleList[index]["phone_1"].toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                value.scheduleList[index]["owner_name"] == null ||
                        value.scheduleList[index]["owner_name"].isEmpty &&
                            value.scheduleList[index]["company_add1"] == null ||
                        value.scheduleList[index]["company_add1"].isEmpty
                    ? Container()
                    : Divider(),
                value.scheduleList[index]["company_add1"] == null ||
                        value.scheduleList[index]["company_add1"].isEmpty
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          children: [
                            Text(
                              'Company Info      :  ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                // "Kanuur jhdjshdjdshjdjshdjadhd sdhjshd nhdhshh vv",
                                value.scheduleList[index]["company_add1"]
                                    .toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                value.scheduleList[index]["owner_name"] == null ||
                        value.scheduleList[index]["owner_name"].isEmpty
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              'Contact Person   :  ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                // "anusha kkk",
                                value.scheduleList[index]["owner_name"],
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
    );
  }
}
