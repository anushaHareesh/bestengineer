import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/dateFind.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/widgets/alertCommon/deletePopup.dart';
import 'package:bestengineer/widgets/alertCommon/set_schedule_date_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PendingList {
  final _formKey = GlobalKey<FormState>();
  DateFind dateFind = DateFind();
  String? todaydate;
  String? selected;
  var cusout;
  String? custId;
  Future buildPendingPopup(
    BuildContext context,
    Size size,
  ) {
    // int datable1Columns = 20;
    // double rowHeight1 =
    //     (MediaQuery.of(context).size.height - 56) / datable1Columns;
    todaydate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return showDialog(
        useSafeArea: true,
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text(
                //   "Pending List",
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                // ),
                IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ),

            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            // insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Colors.grey[100],
            content: Consumer<QuotationController>(
              builder: (context, value, child) {
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
                  child: Container(
                    width: double.maxFinite,
                    child: value.isPendingListLoading
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SpinKitCircle(
                                color: P_Settings.loginPagetheme,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              value.pendingQuotationList.length > 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: Text(
                                            "Quotation List",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              value.pendingQuotationList.length > 0
                                  ? Container(
                                      width: size.width,
                                      height: value.pendingQuotationList
                                                  .length ==
                                              1
                                          ? size.height * 0.12
                                          : value.pendingQuotationList.length ==
                                                  2
                                              ? size.height * 0.18
                                              : value.pendingQuotationList
                                                          .length ==
                                                      3
                                                  ? size.height * 0.24
                                                  : value.pendingQuotationList
                                                              .length ==
                                                          4
                                                      ? size.height * 0.3
                                                      : size.height * 0.36,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: DataTable(
                                          // dataRowHeight: rowHeight1,
                                          horizontalMargin: 10,
                                          columnSpacing: 0,
                                          // border: const TableBorder(verticalInside: BorderSide(width: 1, style: BorderStyle.solid)),
                                          headingRowHeight: 40,
                                          headingRowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Color.fromARGB(
                                                      255, 230, 229, 229)),
                                          showCheckboxColumn: false,
                                          columns: [
                                            // DataColumn(label: Text('Series')),
                                            DataColumn(
                                                label: Container(
                                              width: size.width * 0.38,
                                              child: Text(
                                                'CUSTOMER',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            DataColumn(
                                                label: Container(
                                              width: size.width * 0.2,
                                              child: Text(
                                                'STAFF',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            DataColumn(
                                                label: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                'SCHEDULE DATE',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                          ],
                                          rows: value.pendingQuotationList
                                              .map(
                                                (itemRow) => DataRow(
                                                  color: MaterialStateColor
                                                      .resolveWith((states) {
                                                    return itemRow["status"] ==
                                                            "1"
                                                        ? Color.fromARGB(
                                                            255, 252, 249, 106)
                                                        : Colors
                                                            .white; //make tha magic!
                                                  }),
                                                  cells: [
                                                    DataCell(
                                                      ConstrainedBox(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxWidth:
                                                                    size.width *
                                                                        0.38),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          // mainAxisSize:
                                                          //     MainAxisSize.max,
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            // Text(
                                                            //     "djfjdhnf jfjdnj jdfffffffff djfjjnjfnjd jjfjzdnjfnjd",
                                                            //     overflow:
                                                            //         TextOverflow
                                                            //             .ellipsis),
                                                            Text(
                                                                itemRow[
                                                                    "company_name"],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                            Text(
                                                              "( ${itemRow["s_invoice_no"]} ) / ${itemRow["days"]} days",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      placeholder: false,
                                                      // onTap: (){_getSelectedRowInfo(itemRow.itemName,itemRow.itemPrice);},
                                                    ),
                                                    DataCell(
                                                      onTap: () async {
                                                        value
                                                            .getStaffs(context,itemRow["to_staff"]);
                                                        value.staffSelected =
                                                            itemRow["to_staff"];
                                                        NextSchedulePopup next =
                                                            NextSchedulePopup();
                                                        next.buildPendingPopup(
                                                            context,
                                                            MediaQuery.of(
                                                                    context)
                                                                .size,
                                                            itemRow[
                                                                "s_invoice_id"],
                                                            itemRow["enq_id"],
                                                            "quotation",
                                                            itemRow[
                                                                "next_date"]);
                                                      },
                                                      Container(
                                                        width: size.width * 0.2,
                                                        child: Text(
                                                          itemRow["to_staff"],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                      placeholder: false,
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(itemRow[
                                                              "next_date"])),
                                                      placeholder: false,
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              value.pendingServiceList.length > 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: Text(
                                            "Service List",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                                fontSize: 19),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              value.pendingServiceList.length > 0
                                  ? Container(
                                      height: value.pendingServiceList.length ==
                                              1
                                          ? size.height * 0.12
                                          : value.pendingServiceList.length == 2
                                              ? size.height * 0.18
                                              : value.pendingServiceList
                                                          .length ==
                                                      3
                                                  ? size.height * 0.24
                                                  : value.pendingServiceList
                                                              .length ==
                                                          4
                                                      ? size.height * 0.32
                                                      : size.height * 0.36,
                                      width: size.width,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: DataTable(
                                          horizontalMargin: 10,
                                          columnSpacing: 0,
                                          // border: const TableBorder(verticalInside: BorderSide(width: 1, style: BorderStyle.solid)),
                                          headingRowHeight: 40,
                                          headingRowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Color.fromARGB(
                                                      255, 230, 229, 229)),
                                          showCheckboxColumn: false,
                                          columns: [
                                            // DataColumn(label: Text('Series')),
                                            DataColumn(
                                                label: Container(
                                              width: size.width * 0.38,
                                              child: Text(
                                                'CUSTOMER',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            DataColumn(
                                                label: Container(
                                              width: size.width * .2,
                                              child: Text(
                                                'STAFF',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            DataColumn(
                                                label: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                'SCHEDULE DATE',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                          ],
                                          rows: value.pendingServiceList
                                              .map(
                                                (itemRow) => DataRow(
                                                  color: MaterialStateColor
                                                      .resolveWith((states) {
                                                    return itemRow["flg"] ==
                                                                "2" ||
                                                            itemRow["flg"] ==
                                                                "5"
                                                        ? Color.fromARGB(
                                                            255, 252, 249, 106)
                                                        : Colors
                                                            .white; //make tha magic!
                                                  }),
                                                  cells: [
                                                    DataCell(
                                                      ConstrainedBox(
                                                          constraints:
                                                              BoxConstraints(
                                                                  maxWidth:
                                                                      size.width *
                                                                          0.38),
                                                          child: Text(
                                                              itemRow["type"])),
                                                      placeholder: false,
                                                      // onTap: (){_getSelectedRowInfo(itemRow.itemName,itemRow.itemPrice);},
                                                    ),
                                                    DataCell(
                                                      onTap: () async {
                                                        value.staffSelected =
                                                            itemRow["to_staff"];
                                                        value
                                                            .getStaffs(context, itemRow["to_staff"]);
                                                        NextSchedulePopup next =
                                                            NextSchedulePopup();
                                                        next.buildPendingPopup(
                                                            context,
                                                            MediaQuery.of(
                                                                    context)
                                                                .size,
                                                            itemRow["form_id"],
                                                            itemRow["c_id"],
                                                            "",
                                                            itemRow[
                                                                "ser_date"]);
                                                      },
                                                      Container(
                                                        width: size.width * .2,
                                                        child: Text(
                                                          itemRow["to_staff"],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                      placeholder: false,
                                                    ),
                                                    DataCell(
                                                      Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(itemRow[
                                                              "ser_date"])),
                                                      placeholder: false,
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),

                    //  ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: value.pendingServiceList.length,
                    //   itemBuilder: (context, index) {
                    //     return Card(
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(3),
                    //         child: ListTile(
                    //           title: Column(
                    //             children: [
                    //               Text(
                    //                 "${value.pendingServiceList[index]["type"]}",
                    //                 style: TextStyle(
                    //                     fontSize: 13,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //               Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text(
                    //                     value.pendingServiceList[index]
                    //                         ["series"],
                    //                     style: TextStyle(
                    //                         fontSize: 13,
                    //                         fontWeight: FontWeight.bold),
                    //                   ),
                    //                   // Text(
                    //                   //   "Type : ${value.pendingServiceList[index]["type"]}",
                    //                   //   style: TextStyle(
                    //                   //       fontSize: 13,
                    //                   //       fontWeight: FontWeight.bold),
                    //                   // )
                    //                 ],
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   Text(
                    //                       "Assigned Staff  : ${value.pendingServiceList[index]["to_staff"]}")
                    //                 ],
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // )
                  ),
                );
              },
            ),

            // actions: <Widget>[
            //   ElevatedButton(
            //     child: const Text('CANCEL'),
            //     // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //     // textColor: Theme.of(context).accentColor,
            //     onPressed: () {
            //       //widget.onCancel();
            //     },
            //   ),
            //   ElevatedButton(
            //     child: const Text('OK'),
            //     // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //     // textColor: Theme.of(context).accentColor,
            //     onPressed: () {
            //       //widget.onOk();
            //     },
            //   ),
            // ],
          );
        });
  }
}
