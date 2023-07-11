import 'package:bestengineer/components/commonColor.dart';
// import 'package:bestengineer/components/dateFind.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';

import 'package:bestengineer/screen/Enquiry/enqHistDetails.dart';
import 'package:bestengineer/screen/Enquiry/productList.dart';
import 'package:bestengineer/screen/Quotation/directQuotation.dart';
import 'package:bestengineer/widgets/bottomsheets/removereason.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../widgets/alertCommon/deletePopup.dart';

class EnQHistory extends StatefulWidget {
  const EnQHistory({super.key});

  @override
  State<EnQHistory> createState() => _EnQHistoryState();
}

class _EnQHistoryState extends State<EnQHistory> {
  // DateFind dateFind = DateFind();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? date;
  DateTime now = DateTime.now();
  List<String> s = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final TextEditingController _controller = new TextEditingController();
  String? todaydate;
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    Provider.of<ProductController>(context, listen: false).getEnqhistoryData(
      context,
      "",
      // s[0],
      // s[0],
    );
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    s = date!.split(" ");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductController>(context, listen: false)
          .setDate(s[0], s[0]);
      Provider.of<ProductController>(context, listen: false)
          .setEnqSearch(false);
    });

    Provider.of<ProductController>(context, listen: false).getEnqhistoryData(
      context,
      "",
      // s[0],
      // s[0],
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: size.height * 0.05,
              margin: EdgeInsets.only(left: 6, right: 6),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  print("val----$value");
                  if (value != null && value.isNotEmpty) {
                    Provider.of<ProductController>(context, listen: false)
                        .setEnqSearch(true);
                    Provider.of<ProductController>(context, listen: false)
                        .searchEnqList(value);
                  }
                },
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    suffixIcon: IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        Provider.of<ProductController>(context, listen: false)
                            .setEnqSearch(false);
                        _controller.clear();
                      },
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800], fontSize: 13),
                    hintText: "Search with Customer Name ... ",
                    fillColor: Colors.white70),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<ProductController>(
              builder: (context, value, child) {
                return value.isLoading
                    ? Container(
                        height: size.height * 0.8,
                        child: SpinKitCircle(
                          color: P_Settings.loginPagetheme,
                        ),
                      )
                    : value.enQhistoryList.length == 0 ||
                            value.isEnqSearch &&
                                value.newenQhistoryList.length == 0
                        ? Container(
                            height: size.height * 0.8,
                            child: Center(
                              child: Lottie.asset("assets/noData.json",
                                  width: size.width * 0.45),
                            ))
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: value.isEnqSearch
                                  ? value.newenQhistoryList.length
                                  : value.enQhistoryList.length,
                              itemBuilder: (context, index) {
                                if (value.isEnqSearch) {
                                  return searchbuildCard(size, index);
                                } else {
                                  return buildCard(size, index);
                                }
                              },
                            ),
                          );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(Size size, int index) {
    return Consumer<ProductController>(
      builder: (context, value, child) {
        return Card(
          elevation: 3,
          color: Colors.grey[100],
          child: ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, top: 7),
                        child: Text(
                            value.enQhistoryList[index].companyName
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   "Code   : ",
                      //   style:
                      //       TextStyle(color: Colors.grey),
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 0),
                        child: Text(
                          "${[value.enQhistoryList[index].enqCode.toString()]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                              fontSize: 13),
                        ),
                      ),

                      Row(
                        children: [
                          Text(
                            "Added on : ",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                          Text(
                            value.enQhistoryList[index].addedOn.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        "Contact Person  : ",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            value.enQhistoryList[index].ownerName
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: Row(
                //     children: [
                //       Text(
                //         "Added on : ",
                //         style:
                //             TextStyle(color: Colors.grey),
                //       ),
                //       Text(
                //         value.enQhistoryList[index].addedOn
                //             .toString(),
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //              color: Colors.grey[700],
                //             fontSize: 15),
                //       ),
                //     ],
                //   ),
                // ),
                Divider(
                  thickness: 4,
                  color: value.enQhistoryList[index].l_color == null ||
                          value.enQhistoryList[index].l_color!.isEmpty
                      ? Colors.grey[200]
                      : parseColor(
                          value.enQhistoryList[index].l_color.toString()),
                ),
                InkWell(
                  onTap: () {
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

                    RemoveReason reason = RemoveReason();
                    reason.showDeleteReasonSheet(
                        context,
                        index,
                        value.enQhistoryList[index].enqCode.toString(),
                        value.enQhistoryList[index].enqId.toString());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Remove",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.red,
                            ),
                          ),
                          Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 14,
                          )
                        ],
                      ),
                      value.enQhistoryList[index].verify_status == "0"
                          ? Container(
                              height: size.height * 0.05,
                              child: TextButton(
                                onPressed: () {
                                  Provider.of<QuotationController>(context,
                                          listen: false)
                                      .getQuotationFromEnqList(
                                          context,
                                          value.enQhistoryList[index].enqId
                                              .toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DirectQuotation(
                                              enqcode: value
                                                  .enQhistoryList[index].enqCode
                                                  .toString(),
                                              enqId: value
                                                  .enQhistoryList[index].enqId
                                                  .toString(),
                                            )),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "[Make Quotation]",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: P_Settings.loginPagetheme,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      InkWell(
                        onTap: () {
                          Provider.of<ProductController>(context, listen: false)
                              .getEnqhistoryDetails(context,
                                  value.enQhistoryList[index].enqId.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EnQHistoryDetails(
                                      enqId: value.enQhistoryList[index].enqId
                                          .toString(),
                                      enqCode: value
                                          .enQhistoryList[index].enqCode
                                          .toString(),
                                    )),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              "View",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Image.asset(
                                "assets/eye.png",
                                height: 20,
                                color: Colors.green,
                              ),
                            )
                          ],
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

  //////////////////////////////
  Widget searchbuildCard(Size size, int index) {
    return Consumer<ProductController>(
      builder: (context, value, child) {
        return Card(
          child: ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, top: 7),
                        child: Text(
                            value.newenQhistoryList[index].companyName
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 14)),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   "Code   : ",
                      //   style:
                      //       TextStyle(color: Colors.grey),
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 0),
                        child: Text(
                          "${[
                            value.newenQhistoryList[index].enqCode.toString()
                          ]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                              fontSize: 13),
                        ),
                      ),

                      Row(
                        children: [
                          Text(
                            "Added on : ",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                          Text(
                            value.newenQhistoryList[index].addedOn.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        "Contact Person  : ",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            value.newenQhistoryList[index].ownerName
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: Row(
                //     children: [
                //       Text(
                //         "Added on : ",
                //         style:
                //             TextStyle(color: Colors.grey),
                //       ),
                //       Text(
                //         value.enQhistoryList[index].addedOn
                //             .toString(),
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //              color: Colors.grey[700],
                //             fontSize: 15),
                //       ),
                //     ],
                //   ),
                // ),
                Divider(
                  thickness: 4,
                  color: value.newenQhistoryList[index].l_color == null ||
                          value.newenQhistoryList[index].l_color!.isEmpty
                      ? Colors.grey[200]
                      : parseColor(
                          value.newenQhistoryList[index].l_color.toString()),
                ),
                InkWell(
                  onTap: () {
                    // String df;
                    // String tf;

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

                    RemoveReason reason = RemoveReason();
                    reason.showDeleteReasonSheet(
                        context,
                        index,
                        value.newenQhistoryList[index].enqCode.toString(),
                        value.newenQhistoryList[index].enqId.toString());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Remove",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.red,
                            ),
                          ),
                          Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 14,
                          )
                        ],
                      ),
                      value.newenQhistoryList[index].verify_status == "0"
                          ? Container(
                              height: size.height * 0.05,
                              child: TextButton(
                                onPressed: () {
                                  Provider.of<QuotationController>(context,
                                          listen: false)
                                      .getQuotationFromEnqList(
                                          context,
                                          value.newenQhistoryList[index].enqId
                                              .toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DirectQuotation(
                                              enqcode: value
                                                  .newenQhistoryList[index]
                                                  .enqCode
                                                  .toString(),
                                              enqId: value
                                                  .newenQhistoryList[index]
                                                  .enqId
                                                  .toString(),
                                            )),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "[Make Quotation]",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: P_Settings.loginPagetheme,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      InkWell(
                        onTap: () {
                          Provider.of<ProductController>(context, listen: false)
                              .getEnqhistoryDetails(
                                  context,
                                  value.newenQhistoryList[index].enqId
                                      .toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EnQHistoryDetails(
                                      enqId: value
                                          .newenQhistoryList[index].enqId
                                          .toString(),
                                      enqCode: value
                                          .newenQhistoryList[index].enqCode
                                          .toString(),
                                    )),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              "View",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Image.asset(
                                "assets/eye.png",
                                height: 20,
                                color: Colors.green,
                              ),
                            )
                          ],
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
