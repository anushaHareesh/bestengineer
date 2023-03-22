import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EnquirySchedule extends StatefulWidget {
  const EnquirySchedule({super.key});

  @override
  State<EnquirySchedule> createState() => _EnquiryScheduleState();
}

class _EnquiryScheduleState extends State<EnquirySchedule> {
  DateTime currentDate = DateTime.now();
  String? todaydate;
  String? date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<QuotationController>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return SpinKitCircle(
              color: P_Settings.loginPagetheme,
            );
          } else if (value.enqScheduleList.length == 0) {
            return Center(child: Lottie.asset("assets/noData.json"));
          } else {
            return ListView.builder(
              itemCount: value.enqScheduleList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    color: Color.fromARGB(255, 255, 254, 254),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        title: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  value.enqScheduleList[index]["company_name"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800]),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 4,
                              color: value.enqScheduleList[index]["l_color"] ==
                                          null ||
                                      value.enqScheduleList[index]["l_color"]
                                          .isEmpty
                                  ? Colors.grey[200]
                                  : parseColor(value.enqScheduleList[index]
                                          ["l_color"]
                                      .toString()),
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                      "Phone ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[500]),
                                    )),
                                SizedBox(
                                  width: 14,
                                  child: Text(":"),
                                ),
                                Expanded(
                                  child: Text(
                                    value.enqScheduleList[index]["contact_num"],
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[800]),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                  child: Icon(
                                    Icons.business,
                                    color: Colors.blue,
                                    size: 16,
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                      "Cust Info ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[500]),
                                    )),
                                SizedBox(
                                  width: 14,
                                  child: Text(":"),
                                ),
                                Expanded(
                                  child: Text(
                                    value.enqScheduleList[index]["cust_info"],
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[800]),
                                  ),
                                ),
                              ],
                            ),
                            value.enqScheduleList[index]["landmark"] == null ||
                                    value.enqScheduleList[index]["landmark"]
                                        .isEmpty
                                ? Container()
                                : SizedBox(
                                    height: 8,
                                  ),
                            value.enqScheduleList[index]["landmark"] == null ||
                                    value.enqScheduleList[index]["landmark"]
                                        .isEmpty
                                ? Container()
                                : Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        child: Icon(
                                          Icons.place,
                                          color: Colors.red,
                                          size: 16,
                                        ),
                                      ),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Text(
                                            "Landmark",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey[500]),
                                          )),
                                      SizedBox(
                                        width: 14,
                                        child: Text(":"),
                                      ),
                                      Expanded(
                                        child: Text(
                                          value.enqScheduleList[index]
                                              ["landmark"],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[800]),
                                        ),
                                      ),
                                    ],
                                  ),
                            value.enqScheduleList[index]["company_pin"] ==
                                        null ||
                                    value.enqScheduleList[index]["company_pin"]
                                        .isEmpty
                                ? Container()
                                : SizedBox(
                                    height: 8,
                                  ),
                            value.enqScheduleList[index]["company_pin"] ==
                                        null ||
                                    value.enqScheduleList[index]["company_pin"]
                                        .isEmpty
                                ? Container()
                                : Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        child: Icon(
                                          Icons.numbers,
                                          color: Colors.orange,
                                          size: 16,
                                        ),
                                      ),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Text(
                                            "Com pin",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey[500]),
                                          )),
                                      SizedBox(
                                        width: 14,
                                        child: Text(":"),
                                      ),
                                      Expanded(
                                        child: Text(
                                          value.enqScheduleList[index]
                                              ["company_pin"],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[800]),
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 8,
                            ),
                            InkWell(
                              onTap: () {
                                _selectDate(context, index, );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.07,
                                    child: Icon(
                                      Icons.calendar_month,
                                      color: Colors.brown,
                                      size: 16,
                                    ),
                                  ),
                                  Container(
                                      // width: MediaQuery.of(context).size.width *
                                      //     0.2,
                                      child: Text(
                                    "Choose Schedule date",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[500]),
                                  )),
                                  SizedBox(
                                    width: 4,
                                    // child: Text(":"),
                                  ),
                                  SizedBox(
                                    width: 14,
                                    child: Text(":"),
                                  ),
                                  Expanded(
                                    child: Text(
                                      value.enqScheduleList[index]["next_date"],
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey[800]),
                                    ),
                                  ),
                                ],
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
          }
        },
      ),
    );
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

////////////////////////////////////////////////////
  Future<void> _selectDate(
      BuildContext context, int index, String frmId, String enq) async {
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

    Provider.of<QuotationController>(context, listen: false)
        .saveNextEnqSchedule(context,date!,enq );
    
  }
}
