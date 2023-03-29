import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/screen/Enquiry/addNewProduct.dart';
import 'package:bestengineer/widgets/alertCommon/deletePopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/quotationController.dart';
import '../../widgets/bottomsheets/quotationItemSheet.dart';
import '../../widgets/bottomsheets/remarksheet.dart';

class EnqScheduleQuotation extends StatefulWidget {
  String? row_id;
  String? enqId;
  String enqCode;
  EnqScheduleQuotation(
      {required this.row_id, required this.enqId, required this.enqCode});

  @override
  State<EnqScheduleQuotation> createState() => _EnqScheduleQuotationState();
}

class _EnqScheduleQuotationState extends State<EnqScheduleQuotation> {
  String? sdate;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String? date;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? selected;
  DateTime now = DateTime.now();
  DateTime currentDate = DateTime.now();
  String? userGp;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    sdate = DateFormat('dd-MM-yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Consumer<QuotationController>(
        builder: (context, value, child) => FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () {
            Provider.of<ProductController>(context, listen: false)
                .geProductList(context);
            Provider.of<ProductController>(context, listen: false)
                .setIssearch(false);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNewProduct(
                        com: value.customer_name.toString(),
                        cInfo: value.cus_info.toString(),
                        land: value.landmarked.toString(),
                        contactNum: value.phone.toString(),
                        cid: value.cust_id.toString(),
                        pin: value.company_pin.toString(),
                        prio: value.priority.toString(),
                        owner: value.c_person.toString(),
                        area: value.area.toString(),
                        enqId: value.enq_id.toString(),
                        page: "enquiry schedule",
                        type: "edit enq",
                        rwId: "0",
                      )),
            );
          },
          label: Text("Add Product"),
        ),
      ),
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      bottomNavigationBar: Container(
        height: size.height * 0.06,
        child: Consumer<QuotationController>(
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    RemarkSheet remark = RemarkSheet();
                    value.branchselected = null;
                    remark.showRemarkSheet(
                        _scaffoldKey.currentContext!,
                        sdate!,
                        widget.enqId.toString(),
                        _scaffoldKey,
                        _keyLoader,
                        "add",
                        "0");
                  },
                  child: Container(
                    // height: size.height*0.3,
                    width: size.width * 0.45,
                    color: P_Settings.loginPagetheme,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Make Quotation",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: P_Settings.whiteColor),
                            ),
                          ),
                          Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: size.height * 0.3,
                    color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total :",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: P_Settings.loginPagetheme),
                        ),
                        value.isDetailLoading
                            ? SpinKitThreeBounce(
                                color: P_Settings.loginPagetheme,
                                size: 12,
                              )
                            : Text(
                                "\u{20B9}${value.total.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        title: Text(
          widget.enqCode.toString(),
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[700],
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
                      // Container(
                      //   margin: EdgeInsets.only(
                      //     bottom: 6,
                      //     top: 6,
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [

                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(bottom: 0, top: 8, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Customer Details",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.red,
                                ),
                                // Text(
                                //   " Date",
                                //   style: TextStyle(
                                //       fontSize: 17, fontWeight: FontWeight.bold),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    sdate.toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              // side: BorderSide(
                              //     color: P_Settings.loginPagetheme),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, bottom: 18, top: 8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                            "assets/man.png",
                                            height: size.height * 0.09,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width * 0.6,
                                              child: Text(
                                                value.customer_name
                                                    .toString()
                                                    .toUpperCase(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                value.phone.toString(),
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 14),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Column(
                                    children: [
                                      value.cus_info == null ||
                                              value.cus_info!.isEmpty
                                          ? Container()
                                          : Row(
                                              children: [
                                                Icon(Icons.business,
                                                    color: Colors.orange,
                                                    size: 13),
                                                SizedBox(
                                                  width: size.width * 0.02,
                                                ),
                                                Text(
                                                  "Customer Info :",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                    width: size.width * 0.53,
                                                    child: Text(
                                                      value.cus_info.toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      // value.cus_info.toString(),
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      value.landmarked == null ||
                                              value.landmarked!.isEmpty
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.place,
                                                      color: Colors.red,
                                                      size: 13),
                                                  SizedBox(
                                                    width: size.width * 0.02,
                                                  ),
                                                  Text(
                                                    "Landmark    :",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Container(
                                                      width: size.width * 0.53,
                                                      child: Text(
                                                        value.landmarked
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      value.c_person == null ||
                                              value.c_person!.isEmpty
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.person,
                                                      color: Colors.blue,
                                                      size: 13),
                                                  SizedBox(
                                                    width: size.width * 0.02,
                                                  ),
                                                  Text(
                                                    "Contact Person :",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Container(
                                                      width: size.width * 0.51,
                                                      child: Text(
                                                        value.c_person
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8, top: 2, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Product Details",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      value.quotProdItem.length == 0
                          ? Center(
                              child: Lottie.asset("assets/cartem.json",
                                  height: size.height * 0.2),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: value.quotProdItem.length,
                              itemBuilder: (context, index) {
                                double tdiscamt = double.parse(
                                    value.quotProdItem[index]["disc_amt"]);
                                double t = double.parse(
                                    value.quotProdItem[index]["tax_amt"]);
                                double tnet = double.parse(
                                    value.quotProdItem[index]["net_total"]);
                                double gt = double.parse(
                                    value.quotProdItem[index]["gross"]);

                                return InkWell(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    userGp = prefs.getString('userGroup');
                                    value.rawCalculation(
                                        double.parse(
                                            value.rateEdit[index].text),
                                        int.parse(value.quotqty[index].text),
                                        double.parse(value
                                            .discount_prercent[index].text),
                                        double.parse(
                                            value.discount_amount[index].text),
                                        double.parse(value.quotProdItem[index]
                                            ["tax_perc"]),
                                        0.0,
                                        "0",
                                        0,
                                        index,
                                        true,
                                        "");
                                    editsheet.showItemSheet(
                                        context,
                                        index,
                                        value.quotProdItem[index],
                                        "add",
                                        "",
                                        "",
                                        userGp.toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, top: 2.0, right: 6),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        // side: BorderSide(
                                        //     color: P_Settings.loginPagetheme),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0,
                                            right: 12,
                                            top: 14,
                                            bottom: 14),
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
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8),
                                                  child: Row(
                                                    children: [
                                                      Text("Rate    : "),
                                                      Text(
                                                        '\u{20B9}${value.quotProdItem[index]["l_rate"].toString()}',
                                                        style: TextStyle(
                                                            // color: Colors.grey,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          "Discount  :       "),
                                                      Text(
                                                        "\u{20B9} ${tdiscamt.toStringAsFixed(2)}",
                                                        style: TextStyle(
                                                            // color: Colors.grey,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8),
                                                  child: Row(
                                                    children: [
                                                      Text("Qty      : "),
                                                      Text(
                                                        value
                                                            .quotProdItem[index]
                                                                ["qty"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            // color: Colors.grey,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8),
                                                  child: Row(
                                                    children: [
                                                      Text("Tax  :   "),
                                                      Text(
                                                        "\u{20B9} ${t.toStringAsFixed(2)}",
                                                        style: TextStyle(
                                                            // color: Colors.grey,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8),
                                                  child: Row(
                                                    children: [
                                                      Text("Gross  : "),
                                                      Text(
                                                        "\u{20B9} ${gt.toStringAsFixed(2)}",
                                                        style: TextStyle(
                                                            // color: Colors.grey,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (value.quotProdItem
                                                            .length >
                                                        1) {
                                                      DeletePopup popup =
                                                          DeletePopup();
                                                      popup.builddeletePopupDialog(
                                                          context,
                                                          value.quotProdItem[
                                                                  index][
                                                                  "product_name"]
                                                              .toString(),
                                                          value.quotProdItem[
                                                                  index]
                                                                  ["product_id"]
                                                              .toString(),
                                                          index,
                                                          "enqpdt",
                                                          value.quotProdItem[
                                                              index]["enq_id"],
                                                          "",
                                                          "",
                                                          "",
                                                          "1",
                                                          "");
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Remove",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      Icon(Icons.close,
                                                          size: 16,
                                                          color: Colors.red)
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Total Price : ",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                      "\u{20B9} ${tnet.toStringAsFixed(2)}",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
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

  Future<void> _selectDate(
    BuildContext context,
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
      setState(() {
        // date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
        date = DateFormat('dd-MM-yyyy').format(pickedDate);
        Provider.of<QuotationController>(context, listen: false)
            .setQtDate(date!);
      });
  }
}
