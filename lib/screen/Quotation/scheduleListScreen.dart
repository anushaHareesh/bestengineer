import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:bestengineer/pdftest/pdfPreview.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/bottomsheets/select_branch_sheet.dart';
import '../../widgets/bottomsheets/visitedRemarkSheet.dart';

class ScheduleListScreen extends StatefulWidget {
  String type;
  ScheduleListScreen({required this.type});

  @override
  State<ScheduleListScreen> createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

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
            } else if (value.todyscheduleList.length == 0 &&
                value.tomarwscheduleList.length == 0) {
              return Center(
                child: Lottie.asset("assets/noData.json", height: 200),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    value.todyscheduleList.length > 0
                        ? Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Today's Schedule",
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: value.todyscheduleList.length,
                                itemBuilder: (context, index) {
                                  return customCard(
                                      value.todyscheduleList[index], index);
                                },
                              ),
                            ],
                          )
                        : Container(),
                    value.tomarwscheduleList.length > 0
                        ? Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tomorrow's Schedule",
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: value.tomarwscheduleList.length,
                                itemBuilder: (context, index) {
                                  return customCard(
                                      value.tomarwscheduleList[index], index);
                                },
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              );
            }
          },
        ));
  }

  Widget customCard(Map list, int index) {
    return Consumer<RegistrationController>(
      builder: (context, value, child) {
        return InkWell(
          // onTap: () {
          //   VisitedRemarkSheet visited = VisitedRemarkSheet();
          //   visited.showRemarkSheet(
          //       context,
          //       value.scheduleList[index]["enq_id"],
          //       value.scheduleList[index]["s_invoice_id"]);
          // },
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Card(
              elevation: 3,
              color: Color.fromARGB(255, 250, 249, 249),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            // "ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssj",
                            list["s_customer_name"].toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  // Divider(
                  //   indent: 50,
                  //   endIndent: 50,
                  //   thickness: 4,
                  //   color: value.scheduleList[index]["l_color"] == null ||
                  //           value.scheduleList[index]["l_color"].isEmpty
                  //       ? Colors.grey[100]
                  //       : parseColor(value.scheduleList[index]["l_color"]),
                  // ),

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
                            list["s_invoice_no"].toString(),
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[900]),
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
                        // Text("Inv Date : "),
                        Text(
                          list["s_invoice_date"].toString(),
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _makePhoneCall(list["phone_1"]);
                          },
                          child: Icon(
                            Icons.phone,
                            size: 14,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          list["phone_1"].toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  // value.scheduleList[index]["owner_name"] == null ||
                  //         value.scheduleList[index]["owner_name"].isEmpty &&
                  //             value.scheduleList[index]["company_add1"] == null ||
                  //         value.scheduleList[index]["company_add1"].isEmpty
                  //     ? Container()
                  //     : Divider(),
                  list["company_add1"] == null || list["company_add1"].isEmpty
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
                                  list["company_add1"].toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              )
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 4,
                    color: list["l_color"] == null || list["l_color"].isEmpty
                        ? Colors.grey[200]
                        : parseColor(list["l_color"].toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Contact Person :  ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                // "anusha kkkmfnnnnnnnnnnnnnnnnnnnnmn kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk",
                                list["owner_name"],
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              Provider.of<QuotationController>(context,
                                      listen: false)
                                  .branchselected = null;
                              SelectBranchSheet sheet = SelectBranchSheet();
                              sheet.showRemarkSheet(
                                  context, list["s_invoice_id"]);
                            },
                            child: Icon(
                              Icons.picture_as_pdf_outlined,
                              color: Colors.purple,
                            )),
                        InkWell(
                            onTap: () {
                              VisitedRemarkSheet visited = VisitedRemarkSheet();
                              visited.showRemarkSheet(context, list["enq_id"],
                                  list["s_invoice_id"]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Finish",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     value.scheduleList[index]["owner_name"] == null ||
                  //             value.scheduleList[index]["owner_name"].isEmpty
                  //         ? Container()
                  //         : Row(
                  //           children: [
                  //             Text(
                  //               'Contact Person   :  ',
                  //               style: TextStyle(
                  //                 color: Colors.grey,
                  //               ),
                  //             ),
                  //             Flexible(
                  //               child: Text(
                  //                 // "anusha kkk",
                  //                 value.scheduleList[index]["owner_name"],
                  //                 style: TextStyle(fontSize: 14),
                  //               ),
                  //             )
                  //           ],
                  //         ),

                  //   ],
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
