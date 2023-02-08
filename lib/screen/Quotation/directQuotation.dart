import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/widgets/bottomsheets/enqItemEdit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/bottomsheets/quotationItemSheet.dart';

class DirectQuotation extends StatefulWidget {
  String enqcode;

  DirectQuotation({required this.enqcode});

  @override
  State<DirectQuotation> createState() => _DirectQuotationState();
}

class _DirectQuotationState extends State<DirectQuotation> {
  //  EnqDataEditsheet editsheet = EnqDataEditsheet();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? selected;
  QuotationItemSheet editsheet = QuotationItemSheet();
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.enqcode.toString(),
          style: TextStyle(color: Colors.grey[700]),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            )),
        backgroundColor: P_Settings.whiteColor,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Consumer<QuotationController>(
          builder: (context, value, child) {
            if (value.isDetailLoading) {
              return Container(
                height: size.height * 0.8,
                child: SpinKitCircle(
                  color: P_Settings.loginPagetheme,
                ),
              );
            } else {
              return Consumer<QuotationController>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: P_Settings.fillcolor,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, bottom: 20, top: 8),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Customer Details ",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Company Name :",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[600]),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: size.height * 0.05,
                                  margin: EdgeInsets.only(
                                      left: 9, right: 9, top: 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: value.cname,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: P_Settings.whiteColor,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Contact Person :",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[600]),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: size.height * 0.05,
                                  margin: EdgeInsets.only(
                                      left: 9, right: 9, top: 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: value.cperson,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: P_Settings.whiteColor,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Contact Num :",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[600]),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: size.height * 0.05,
                                  margin: EdgeInsets.only(
                                      left: 9, right: 9, top: 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: value.phone,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: P_Settings.whiteColor,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Customer Info :",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[600]),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  // height: size.height * 0.05,
                                  margin: EdgeInsets.only(
                                      left: 9, right: 9, top: 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: value.cinfo,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: P_Settings.whiteColor,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Landmark :",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[600]),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: size.height * 0.05,
                                  margin: EdgeInsets.only(
                                      left: 9, right: 9, top: 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: value.landmarked,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: P_Settings.whiteColor,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey), //<-- SEE HERE
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Priority :",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[600]),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 9, right: 9, top: 10),
                                      height: size.height * 0.04,
                                      width: size.width * 0.09,
                                      decoration: BoxDecoration(
                                          color: parseColor(
                                              value.color1.toString())),
                                    )
                                    // Container(
                                    //   height: size.height * 0.05,
                                    //   margin: EdgeInsets.only(
                                    //       left: 9, right: 9, top: 10),
                                    //   child: TextFormField(
                                    //     readOnly: true,
                                    //     controller: value.landmarked,
                                    //     decoration: InputDecoration(
                                    //       filled: true,
                                    //       fillColor: P_Settings.whiteColor,
                                    //       contentPadding: EdgeInsets.symmetric(
                                    //           horizontal: 10, vertical: 8),
                                    //       focusedBorder: OutlineInputBorder(
                                    //         borderSide: BorderSide(
                                    //             width: 1,
                                    //             color: Colors.grey), //<-- SEE HERE
                                    //       ),
                                    //       enabledBorder: OutlineInputBorder(
                                    //         borderSide: BorderSide(
                                    //             width: 1,
                                    //             color: Colors.grey), //<-- SEE HERE
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Product Details",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.quotProdItem.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              
                              value.rawCalculation(
                                  double.parse(value.rateEdit[index].text),
                                  int.parse(value.quotqty[index].text),
                                  double.parse(
                                      value.discount_prercent[index].text),
                                  double.parse(
                                      value.discount_amount[index].text),
                                  double.parse(
                                      value.quotProdItem[index]["tax_perc"]),
                                  0.0,
                                  "0",
                                  0,
                                  index,
                                  true,
                                  "");
                              editsheet.showItemSheet(
                                  context, index, value.quotProdItem[index]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 9, top: 2.0, right: 9),
                              child: Card(
                                // color: P_Settings.fillcolor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8, top: 14, bottom: 14),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              // "sdsbdhsbdhszbddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
                                              value.quotProdItem[index]
                                                      ["product_name"]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 8),
                                            child: Row(
                                              children: [
                                                Text("Rate  : "),
                                                Text(
                                                  value.fromApi
                                                      ? '\u{20B9}${value.quotProdItem[index]["l_rate"].toString()}'
                                                      : '\u{20B9}${value.rateEdit[index].text.toString()}',
                                                  style: GoogleFonts.aBeeZee(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                    fontSize: 17,
                                                    // fontWeight: FontWeight.bold,
                                                    // color: P_Settings.loginPagetheme,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 8),
                                            child: Row(
                                              children: [
                                                Text("Discount  : "),
                                                Text(
                                                  value.disc_amt.toString(),
                                                  style: TextStyle(
                                                      // color: Colors.grey,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 8),
                                            child: Row(
                                              children: [
                                                Text("Qty  : "),
                                                Text(
                                                  value.quotProdItem[index]
                                                          ["qty"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      // color: Colors.grey,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 8),
                                            child: Row(
                                              children: [
                                                Text("Tax  : "),
                                                Text(
                                                  value.tax.toString(),
                                                  style: TextStyle(
                                                      // color: Colors.grey,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 8),
                                            child: Row(
                                              children: [
                                                Text("Gross  : "),
                                                Text(
                                                  value.gross.toString(),
                                                  style: TextStyle(
                                                      // color: Colors.grey,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   margin: EdgeInsets.only(top: 8),
                                          //   child: Row(
                                          //     children: [
                                          //       Text("Tax  : "),
                                          //       Text(
                                          //         value.quotProdItem[index]
                                          //                 ["qty"]
                                          //             .toString(),
                                          //         style: TextStyle(
                                          //             // color: Colors.grey,
                                          //             fontSize: 17,
                                          //             fontWeight:
                                          //                 FontWeight.bold),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text("Total Price : "),
                                          Text(
                                              value.net_amt.toStringAsFixed(2)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );

                          // ListTile(
                          //   onTap: () {
                          //     editsheet.showNewItemSheet(context);
                          //   },
                          //   title:
                          // );
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
