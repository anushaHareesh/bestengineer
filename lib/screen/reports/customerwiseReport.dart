import 'package:bestengineer/components/customSnackbar.dart';
import 'package:bestengineer/components/dateFind.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';
import '../../controller/quotationController.dart';

class CustomerWiseReport extends StatefulWidget {
  const CustomerWiseReport({super.key});

  @override
  State<CustomerWiseReport> createState() => _CustomerWiseReportState();
}

class _CustomerWiseReportState extends State<CustomerWiseReport> {
  String? selected;
  DateFind dateFind = DateFind();
  String? todaydate;
  DateTime now = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    selected = null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Consumer<QuotationController>(
        builder: (context, value, child) {
          return Column(
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

                    // Flexible(
                    //     child: Container(
                    //   height: size.height * 0.05,
                    //   child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         primary: P_Settings.loginPagetheme,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius:
                    //               BorderRadius.circular(2), // <-- Radius
                    //         ),
                    //       ),
                    //       onPressed: () {
                    //         String df;
                    //         String tf;

                    //         if (value.fromDate == null) {
                    //           df = todaydate.toString();
                    //         } else {
                    //           df = value.fromDate.toString();
                    //         }
                    //         if (value.todate == null) {
                    //           tf = todaydate.toString();
                    //         } else {
                    //           tf = value.todate.toString();
                    //         }

                    //         // Provider.of<Controller>(context, listen: false)
                    //         //     .historyData(
                    //         //         context, "", df, tf, widget.form_type);
                    //       },
                    //       child: Text(
                    //         "Apply",
                    //         style: GoogleFonts.aBeeZee(
                    //           textStyle: Theme.of(context).textTheme.bodyText2,
                    //           fontSize: 17,
                    //           fontWeight: FontWeight.bold,
                    //           color: P_Settings.whiteColor,
                    //         ),
                    //       )),
                    // ))
                  ],
                ),
                // dropDownCustom(size,""),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 163, 163, 163)),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        // width: size.width * 0.4,
                        height: size.height * 0.05,

                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            // value: selected,
                            // isDense: true,
                            hint: Text(
                              value.reportdealerselected == null
                                  ? "Select Customer.."
                                  : value.reportdealerselected!,
                              style: TextStyle(fontSize: 14),
                            ),
                            isExpanded: true,
                            autofocus: false,
                            underline: SizedBox(),
                            elevation: 0,
                            items: value.reportDealerList
                                .map((item) => DropdownMenuItem<String>(
                                    value: item["c_id"].toString(),
                                    child: Container(
                                      width: size.width * 0.4,
                                      child: Text(
                                        item["company_name"].toString(),
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    )))
                                .toList(),
                            onChanged: (item) {
                              print("clicked");

                              if (item != null) {
                                print("clicked------$item");
                                selected = item;
                                Provider.of<QuotationController>(context,
                                        listen: false)
                                    .setReportDealerDrop(selected!);
                                // print("se;ected---$item");
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
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
                            print("selected-----$selected");
                            if (selected == null || selected!.isEmpty) {
                              CustomSnackbar snackbar = CustomSnackbar();
                              snackbar.showSnackbar(
                                  context, "Please Select Customer !!!", "");
                            } else {
                              Provider.of<QuotationController>(context,
                                      listen: false)
                                  .getCustomerwiseReport(
                                      context, df, tf, selected!);
                            }
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
                    )
                  ],
                ),
              ),
              Divider(),
              value.isLoading
                  ? Container(
                      height: size.height * 0.67,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SpinKitCircle(
                            color: P_Settings.loginPagetheme,
                          ),
                        ],
                      ),
                    )
                  : value.customerwiseReport.length == 0
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
                            itemCount: value.customerwiseReport.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(
                                    value.customerwiseReport[index]
                                        ["product_name"],
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600]),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        "Warranty Start Date  :  ",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        value.customerwiseReport[index]
                                            ["waranty_start_date"],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ],
          );
        },
      ),
    );
  }
}
