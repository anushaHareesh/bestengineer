import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:bestengineer/screen/service/serviceChat.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../widgets/bottomsheets/productService.dart';

class ServiceScheduleList extends StatefulWidget {
  String? type;
  ServiceScheduleList({this.type});

  @override
  State<ServiceScheduleList> createState() => _ServiceScheduleListState();
}

class _ServiceScheduleListState extends State<ServiceScheduleList> {
  DateTime currentDate = DateTime.now();
  String? todaydate;
  String? date;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              title: Text("Service Shedule List"),
            ),
      body: SafeArea(
        child: Consumer<RegistrationController>(
          builder: (context, value, child) {
            if (value.isServSchedulelIstLoadind) {
              return SpinKitCircle(
                color: P_Settings.loginPagetheme,
              );
            } else {
              return ListView.builder(
                itemCount: value.servicescheduleList.length,
                itemBuilder: (context, index) {
                  String rem = value.servicescheduleList[index]["complaints"]
                      .replaceAll("\n", " ");
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          onTap: () {
                            Provider.of<RegistrationController>(context,
                                    listen: false)
                                .getProdFromServiceSchedule(
                                    value.servicescheduleList[index]["form_id"],
                                    value.servicescheduleList[index]["qb_id"],
                                    context);
                            ServiceProduct ser = ServiceProduct();
                            ser.showProdSheet(context, index);
                          },
                          title: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${value.servicescheduleList[index]["cust_name"]}",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 19),
                                      ),
                                    )
                                  ]),
                              value.servicescheduleList[index]["cust_phn"] ==
                                          null ||
                                      value
                                          .servicescheduleList[index]
                                              ["cust_phn"]
                                          .isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.blue,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        // Text("Ph  : ",
                                        //     style: TextStyle(
                                        //         color: Colors.grey[600], fontSize: 13)),
                                        Flexible(
                                          child: Text(
                                              "${value.servicescheduleList[index]["cust_phn"]}",
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 14)),
                                        )
                                      ]),
                                    ),
                              value.servicescheduleList[index]
                                              ["company_add1"] ==
                                          null ||
                                      value
                                          .servicescheduleList[index]
                                              ["company_add1"]
                                          .isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(children: [
                                        Icon(
                                          Icons.business,
                                          color: Colors.orange,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                              "${value.servicescheduleList[index]["company_add1"]}",
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 14)),
                                        )
                                      ]),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Text("Type  : ",
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 13)),
                                      Text(
                                          "${value.servicescheduleList[index]["type"]}",
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 14))
                                    ]),
                                    InkWell(
                                      onTap: () {
                                        Provider.of<QuotationController>(
                                                context,
                                                listen: false)
                                            .getPreviousChat(
                                                value.servicescheduleList[index]
                                                    ["form_id"],
                                                value.servicescheduleList[index]
                                                    ["qb_id"],
                                                context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ServiceChat(
                                                    form_id: value
                                                            .servicescheduleList[
                                                        index]["form_id"],
                                                    qb_id: value
                                                            .servicescheduleList[
                                                        index]["qb_id"],
                                                  )),
                                        );
                                      },
                                      child: Image.asset(
                                        "assets/chat.png",
                                        height: 20,
                                        // color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _selectDate(
                                        context,
                                        index,
                                        value.servicescheduleList[index]
                                            ["form_id"],
                                        value.servicescheduleList[index]
                                            ["qb_id"]);
                                  },
                                  child: Row(
                                    children: [
                                      Text("Choose Installation date  :  ",
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 13)),
                                      Icon(
                                        Icons.calendar_month,
                                        size: 16,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        "${value.servicescheduleList[index]["installation_date"]}",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              value.servicescheduleList[index]["complaints"] ==
                                          null ||
                                      value
                                          .servicescheduleList[index]
                                              ["complaints"]
                                          .isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Text("Complaints  : ",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 13)),
                                          Flexible(
                                            child: Text(
                                              rem,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      // appBar: widget.type == "from menu"
      //     ? null
      //     : AppBar(
      //         leading: IconButton(
      //             onPressed: () {
      //               Navigator.pushReplacement(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => EnqHome(
      //                             type: "from service scheduleList",
      //                           )));
      //             },
      //             icon: Icon(Icons.arrow_back)),
      //         backgroundColor: P_Settings.loginPagetheme,
      //         title: Text("Service Shedule List"),
      //       ),
    );
  }

  Widget buildCard(int index, Size size) {
    return Consumer<RegistrationController>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
          child: ExpansionTileCard(
            onExpansionChanged: (values) {
              Provider.of<RegistrationController>(context, listen: false)
                  .getProdFromServiceSchedule(
                      value.servicescheduleList[index]["form_id"],
                      value.servicescheduleList[index]["qb_id"],
                      context);
            },
            elevation: 4,
            baseColor: Color.fromARGB(255, 248, 246, 246),
            expandedColor: Color.fromARGB(255, 248, 246, 246),
            // key: cardA,
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/service2.png"),
              backgroundColor: Colors.transparent,
            ),
            title: Text(
              "${value.servicescheduleList[index]["cust_name"]}",
              style: TextStyle(color: Colors.grey[800], fontSize: 19),
            ),
            subtitle: value.servicescheduleList[index]["cust_phn"] == null ||
                    value.servicescheduleList[index]["cust_phn"].isEmpty
                ? Container()
                : Text("${value.servicescheduleList[index]["cust_phn"]}",
                    style: TextStyle(color: Colors.grey[800], fontSize: 14)),
            children: <Widget>[
              Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    children: [
                      value.servicescheduleList[index]["company_add1"] ==
                                  null ||
                              value.servicescheduleList[index]["company_add1"]
                                  .isEmpty
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(children: [
                                Icon(
                                  Icons.business,
                                  color: Colors.orange,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                      "${value.servicescheduleList[index]["company_add1"]}",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 14)),
                                )
                              ]),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(children: [
                          Text("Type  : ",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 13)),
                          Text("${value.servicescheduleList[index]["type"]}",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 14))
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            _selectDate(
                                context,
                                index,
                                value.servicescheduleList[index]["form_id"],
                                value.servicescheduleList[index]["qb_id"]);
                          },
                          child: Row(
                            children: [
                              Text("Choose Installation date  :  ",
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 13)),
                              Icon(
                                Icons.calendar_month,
                                size: 16,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "${value.servicescheduleList[index]["installation_date"]}",
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
              ),
              value.isProdLoding
                  ? SpinKitCircle(
                      color: P_Settings.loginPagetheme,
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Products Info : ",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            // FittedBox(
                            //   child: DataTable(
                            //     horizontalMargin: 0,
                            //     columnSpacing: 10,
                            //     // border: TableBorder.all(
                            //     //     width: 1,
                            //     //     color: Color.fromARGB(255, 117, 115, 115)),
                            //     columns: [
                            //       // column to set the name
                            //       DataColumn(
                            //         label: Text('Item'),
                            //       ),
                            //       DataColumn(
                            //         label: Text('Qty'),
                            //       ),
                            //     ],
                            //     rows: value.servicesProdList
                            //         .map(
                            //           (list) => DataRow(
                            //             cells: [
                            //               DataCell(
                            //                 Column(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.center,
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     Text(
                            //                       list["product_name"],
                            //                       style:
                            //                           TextStyle(fontSize: 16),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //               DataCell(
                            //                 Text(
                            //                   list["qty"].toString(),
                            //                   style: TextStyle(fontSize: 16),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         )
                            //         .toList(),
                            //   ),
                            // )
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                height: size.height * 0.3,
                                child: ListView.builder(
                                  itemCount: value.servicesProdList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Item : "),
                                              Text(
                                                  "${value.servicesProdList[index]["product_name"]}")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Qty : "),
                                              Text(
                                                  "${value.servicesProdList[index]["qty"]}")
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate(
      BuildContext context, int index, String frmId, String qb_id) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light()
                    .copyWith(primary: P_Settings.loginPagetheme),
              ),
              child: child!);
        });
    if (pickedDate != null && pickedDate != currentDate)
      // setState(() {
      date = DateFormat('dd-MM-yyyy').format(pickedDate);
    print("date----------------$date");

    Provider.of<RegistrationController>(context, listen: false)
        .saveNextScheduleServiceDate(date!, frmId, qb_id, context);
    // });
  }
}
