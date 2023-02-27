import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/dateFind.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/screen/Quotation/quotationEdit.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../widgets/bottomsheets/deleteQuotation.dart';

class QuotatationListScreen extends StatefulWidget {
  const QuotatationListScreen({super.key});

  @override
  State<QuotatationListScreen> createState() => _QuotatationListScreenState();
}

class _QuotatationListScreenState extends State<QuotatationListScreen> {
  // final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  DateFind dateFind = DateFind();
  DateTime now = DateTime.now();
  DateTime currentDate = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<String> s = [];
  String? todaydate;
  String? date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
    date = DateFormat('dd-MM-yyyy').format(now);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuotationController>(context, listen: false)
          .setQuotSearch(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      // backgroundColor: Provider.of<QuotationController>(context, listen: false)
      //             .quotationList
      //             .length ==
      //         0
      //     ? Colors.white
      //     : Colors.grey[200],
      // appBar: AppBar(
      //   backgroundColor: P_Settings.loginPagetheme,
      // ),
      body: SafeArea(
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
                  Provider.of<QuotationController>(context, listen: false)
                      .setQuotSearch(true);
                  Provider.of<QuotationController>(context, listen: false)
                      .searchQuotationList(value);
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
                      Provider.of<QuotationController>(context, listen: false)
                          .setQuotSearch(false);
                      _controller.clear();
                    },
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Search here...",
                  fillColor: Colors.white70),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<QuotationController>(
            builder: (context, value, child) {
              if (value.isQuotLoading) {
                return Container(
                  height: size.height * 0.7,
                  child: SpinKitCircle(
                    color: P_Settings.loginPagetheme,
                  ),
                );
              } else if (value.quotationList.length == 0 ||
                  value.isQuotSearch && value.newquotationList.length == 0) {
                return Container(
                    height: size.height * 0.7,
                  child: Lottie.asset(
                    "assets/noData.json",
                    width: size.width * 0.45,
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: value.isQuotSearch
                        ? value.newquotationList.length
                        : value.quotationList.length,
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (value.isQuotSearch) {
                        return buildSearchCard(index, size);
                      } else {
                        return buildCard(index, size);
                      }
                    },
                  ),
                );
              }
            },
          ),
        ],
      )),
    );
  }

  Widget buildCard(int index, Size size) {
    return Consumer<QuotationController>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
          child: ExpansionTileCard(
            elevation: 4,
            baseColor: Color.fromARGB(255, 248, 246, 246),
            expandedColor: Color.fromARGB(255, 248, 246, 246),
            // key: cardA,
            leading: CircleAvatar(child: Image.asset("assets/man.png")),
            title: Text(value.quotationList[index]["cname"]),
            subtitle: Text(
              value.quotationList[index]["phone_1"],
            ),
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
                      Row(
                        children: [
                          Text(
                            "Quotation No:  ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            " [ ${value.quotationList[index]["qt_no"]} ]",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      value.quotationList[index]["company_add1"] == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Compnay info: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      // "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkh",
                                      value.quotationList[index]
                                          ["company_add1"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "Choose Schedule Date : ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            Consumer<QuotationController>(
                              builder: (context, value, child) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        _selectDate(
                                          context,
                                          index,
                                          value.quotationList[index]["enq_id"],
                                          value.quotationList[index]
                                              ["s_invoice_id"],
                                        );
                                        // dateFind.selectDateFind(
                                        //     context, "to date");
                                      },
                                      child: Icon(Icons.calendar_month,
                                          // color: Colors.blue,
                                          size: 17),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        value.qtScheduldate[index].toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    // Text(
                                    //   value.quotationList[index]["qdate"],
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 15,
                                    //       color: Colors.blue),
                                    // )
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Qt Date : ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    value.quotationList[index]["qdate"],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Amount  :  ",
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  '\u{20B9}${value.quotationList[index]["amount"]}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              DeleteQuotation quot = DeleteQuotation();
                              quot.showdeleteQuotSheet(
                                  context,
                                  value.quotationList[index]["qt_no"],
                                  value.quotationList[index]["s_invoice_id"]);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: P_Settings.loginPagetheme),
                                ),
                                Icon(Icons.close,
                                    size: 17, color: P_Settings.loginPagetheme)
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<QuotationController>(context,
                                      listen: false)
                                  .quotationEdit(
                                      context,
                                      value.quotationList[index]
                                          ["s_invoice_id"],
                                      value.quotationList[index]["enq_id"]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuotationEditScreen(
                                          row_id: value.quotationList[index]
                                              ["s_invoice_id"],
                                          enqId: value.quotationList[index]
                                              ["enq_id"],
                                        )),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Icon(
                                  Icons.edit,
                                  size: 17,
                                  color: Colors.green,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSearchCard(int index, Size size) {
    return Consumer<QuotationController>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
          child: ExpansionTileCard(
            elevation: 4,
            baseColor: Color.fromARGB(255, 248, 246, 246),
            expandedColor: Color.fromARGB(255, 248, 246, 246),
            // key: cardA,
            leading: CircleAvatar(child: Image.asset("assets/man.png")),
            title: Text(value.newquotationList[index]["cname"]),
            subtitle: Text(
              value.newquotationList[index]["phone_1"],
            ),
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
                      Row(
                        children: [
                          Text(
                            "Quotation No:  ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            " [ ${value.newquotationList[index]["qt_no"]} ]",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      value.newquotationList[index]["company_add1"] == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Compnay info: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      // "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkh",
                                      value.newquotationList[index]
                                          ["company_add1"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "Choose Schedule Date : ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            Consumer<QuotationController>(
                              builder: (context, value, child) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        _selectDate(
                                          _scaffoldKey.currentContext!,
                                          index,
                                          value.newquotationList[index]
                                              ["enq_id"],
                                          value.newquotationList[index]
                                              ["s_invoice_id"],
                                        );
                                        // dateFind.selectDateFind(
                                        //     context, "to date");
                                      },
                                      child: Icon(Icons.calendar_month,
                                          // color: Colors.blue,
                                          size: 17),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        value.qtScheduldate[index].toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    // Text(
                                    //   value.quotationList[index]["qdate"],
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 15,
                                    //       color: Colors.blue),
                                    // )
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Qt Date : ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    value.newquotationList[index]["qdate"],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Amount  :  ",
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  '\u{20B9}${value.newquotationList[index]["amount"]}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              DeleteQuotation quot = DeleteQuotation();
                              quot.showdeleteQuotSheet(
                                  context,
                                  value.newquotationList[index]["qt_no"],
                                  value.newquotationList[index]
                                      ["s_invoice_id"]);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: P_Settings.loginPagetheme),
                                ),
                                Icon(Icons.close,
                                    size: 17, color: P_Settings.loginPagetheme)
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<QuotationController>(context,
                                      listen: false)
                                  .quotationEdit(
                                      context,
                                      value.newquotationList[index]
                                          ["s_invoice_id"],
                                      value.newquotationList[index]["enq_id"]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuotationEditScreen(
                                          row_id: value.newquotationList[index]
                                              ["s_invoice_id"],
                                          enqId: value.newquotationList[index]
                                              ["enq_id"],
                                        )),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Icon(
                                  Icons.edit,
                                  size: 17,
                                  color: Colors.green,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate(
      BuildContext context, int index, String enqId, String invId) async {
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
        .setScheduledDate(index, date!, context, enqId, invId);
    // });
  }
}
