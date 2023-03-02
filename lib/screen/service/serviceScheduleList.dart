import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

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
            return ListView.builder(
              itemCount: value.servicescheduleList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
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
                                    value.servicescheduleList[index]["cust_phn"]
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
                            value.servicescheduleList[index]["company_add1"] ==
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
                              child: Row(children: [
                                Text("Type  : ",
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 13)),
                                Text(
                                    "${value.servicescheduleList[index]["type"]}",
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
                                  );
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
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
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

  Future<void> _selectDate(
    BuildContext context,
    int index,
  ) async {
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

    // Provider.of<QuotationController>(context, listen: false)
    //     .setScheduledDate(index, date!, context);
    // });
  }
}
