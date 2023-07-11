import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/dateFind.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NextSchedulePopup {
  final _formKey = GlobalKey<FormState>();
  DateFind dateFind = DateFind();
  // String? todaydate;
  String? selected;
  var cusout;
  String? custId;
  Future buildPendingPopup(BuildContext context, Size size, String form_id,
      String c_id, String type, String date) {
    // todaydate = DateFormat('dd-MM-yyyy').format(DateTime.now());
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:13.0),
                              child: Text("Executive  :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  color: Color.fromARGB(255, 165, 163, 163)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          height: size.height * 0.045,
                          width: size.width * 0.62,
                          child: DropdownButton<String>(
                            // value: selected,
                            // isDense: true,

                            hint: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                value.staffSelected == null
                                    ? "Select Staff"
                                    : value.staffSelected.toString(),
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            isExpanded: true,
                            autofocus: false,
                            underline: SizedBox(),
                            elevation: 0,
                            items: value.staff_list
                                .map((item) => DropdownMenuItem<String>(
                                    value: item["USERS_ID"],
                                    child: Container(
                                      // width: size.width * 0.4,
                                      child: Text(
                                        item["NAME"],
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    )))
                                .toList(),
                            onChanged: (item) {
                              print("clicked---$item");

                              if (item != null) {
                                selected = item;
                                value.setStaffSelected(selected!);
                                print("se;ected---$item");
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:13.0),
                              child: Text("Select Date :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 49),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    // String df;
                                    // String tf;
                                    dateFind.selectDateFind(
                                        context, "from date");
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
                                      ? date.toString()
                                      : value.fromDate.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<QuotationController>(
                      builder: (context, value, child) => Container(
                        width: size.width*0.2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: P_Settings.loginPagetheme),
                          child: const Text('SAVE'),
                          // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          // textColor: Theme.of(context).accentColor,
                          onPressed: () {
                            String id;
                            if (selected == null) {
                              id = value.staffSelId.toString();
                            } else {
                              id = selected.toString();
                            }
                            String d;
                            if (value.fromDate == null) {
                              d = date.toString();
                            } else {
                              d = value.fromDate.toString();
                            }
                            if (type == "quotation") {
                              Provider.of<QuotationController>(context,
                                      listen: false)
                                  .saveNextScheduleDate(
                                      d.toString(), form_id, c_id, context, id);
                            } else {
                              Provider.of<QuotationController>(context,
                                      listen: false)
                                  .saveNextScheduleServiceDate(
                                      d.toString(), form_id, c_id, context, id);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ElevatedButton(
              //   child: const Text('OK'),
              //   // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //   // textColor: Theme.of(context).accentColor,
              //   onPressed: () {
              //     //widget.onOk();
              //   },
              // ),
            ],
          );
        });
  }
}
