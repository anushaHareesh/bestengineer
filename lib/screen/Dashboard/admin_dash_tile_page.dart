import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/widgets/bottomsheets/showComplaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminDashTilePage extends StatefulWidget {
  String tileId;
  AdminDashTilePage({required this.tileId});

  @override
  State<AdminDashTilePage> createState() => _AdminDashTilePageState();
}

class _AdminDashTilePageState extends State<AdminDashTilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        title: Text(
          widget.tileId == "1"
              ? "Pending Enquiry"
              : widget.tileId == "2"
                  ? "Pending Quotation"
                  : widget.tileId == "3"
                      ? "Confirmed Quotation"
                      : "Pending Service",
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Consumer<QuotationController>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return SpinKitCircle(
              color: P_Settings.loginPagetheme,
            );
          } else if (value.adminDashTileDetail.length == 0) {
            return Center(child: Lottie.asset("assets/noData.json"));
          } else {
            return ListView.builder(
              itemCount: value.adminDashTileDetail.length,
              itemBuilder: (context, index) {
                if (widget.tileId == "1") {
                  return penEnquiry(index);
                } else if (widget.tileId == "2" || widget.tileId == "3") {
                  return penQuotation(index);
                } else {
                  return pendingService(index);
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget penEnquiry(int index) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Consumer<QuotationController>(
        builder: (context, value, child) {
          return Card(
            color: Color.fromARGB(255, 250, 249, 249),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 1, right: 3, top: 8.0, bottom: 8),
              child: ListTile(
                trailing: Wrap(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.red,
                      size: 16,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8.0),
                    //   child: Text(
                    //     "Enq Code : ",
                    //     style:
                    //         TextStyle(fontSize: 12, color: Colors.grey[400]),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        value.adminDashTileDetail[index]["date"],
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),
                title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              // "jbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb hjjjjjjjjjjjjjjjjjjjj jhnhnhnhnhnhnhnhnhnhnhn",

                              value.adminDashTileDetail[index]["company_name"],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700]),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      // color:
                      //     value.adminDashTileDetail[index]["l_color"] == null ||
                      //             value.adminDashTileDetail[index]["l_color"]
                      //                 .isEmpty
                      //         ? Colors.grey[200]
                      //         : parseColor(
                      //             value.adminDashTileDetail[index]["l_color"]),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.numbers,
                          color: Colors.green,
                          size: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Enq Code        :   ",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[400]),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            // "engjjjc  ,nvkc   nkvnkcxjvnkx kkjxc",
                            value.adminDashTileDetail[index]["enq_code"],
                            style: TextStyle(fontSize: 13),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.purple,
                          size: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Prepared By  :    ",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[400]),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            value.adminDashTileDetail[index]["NAME"],
                            style: TextStyle(fontSize: 13),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //////////////////////////////////////////////////////
  Widget penQuotation(int index) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Consumer<QuotationController>(
        builder: (context, value, child) {
          return Card(
            color: Color.fromARGB(255, 250, 249, 249),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 1, right: 3, top: 8.0, bottom: 8),
              child: ListTile(
                title: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_2,
                          color: Colors.blue,
                          size: 16,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Customer   :  ",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[500]),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Flexible(
                          child: Text(
                              value.adminDashTileDetail[index]
                                  ["s_customer_name"],
                              style: TextStyle(fontSize: 14)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.numbers,
                          color: Colors.green,
                          size: 16,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Inv No          :  ",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[500]),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Flexible(
                          child: Text(
                            // "bcjbccxncmxn kxxk xmkljkldjksdjk jhkjjjjjjjjjjjjjjjjjjjjjjjjjjjjj",

                            value.adminDashTileDetail[index]["s_invoice_no"],
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                    widget.tileId == "3"
                        ? SizedBox(
                            height: 6,
                          )
                        : Container(),
                    widget.tileId == "3"
                        ? Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.brown,
                                size: 16,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "added on    :  ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[500]),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Flexible(
                                child: Text(
                                  // "bcjbccxncmxn kxxk xmkljkldjksdjk jhkjjjjjjjjjjjjjjjjjjjjjjjjjjjjj",

                                  value.adminDashTileDetail[index]["added_on"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic),
                                ),
                              )
                            ],
                          )
                        : Container(),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Prepared By : ",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[500]),
                            ),
                            Container(
                              width: 160,
                              child: Text(
                                // "sdksdkskd kfkdjfjkdfndklf dkfnkdjnfkjd kdklfdklkl fkjdk",
                                "${value.adminDashTileDetail[index]["NAME"]}",
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Total : ",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700]),
                            ),
                            Text(
                              "\u{20B9} ${value.adminDashTileDetail[index]["s_total_net_amount"]}",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget pendingService(int index) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Consumer<QuotationController>(
        builder: (context, value, child) {
          return Card(
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
                            // "bsbjnbsdbsndbsjzdbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb bjbjbjhb hjbjhjhhbhj"
                            value.adminDashTileDetail[index]["cust_name"]
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 4,
                      color:
                          value.adminDashTileDetail[index]["l_color"] == null ||
                                  value.adminDashTileDetail[index]["l_color"]
                                      .isEmpty
                              ? Colors.grey[200]
                              : parseColor(
                                  value.adminDashTileDetail[index]["l_color"]),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          child: Text(
                            "Type",
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          width: 14,
                          child: Text(":"),
                        ),
                        Expanded(
                          child: Text(
                              // "hbhjsbdjnzsbnjbcndbcnjbbbbbbbbbbbbbbbbb bjhhhhhhhhhhh bjhhhhhhhhhhhhhhhhhhhh",
                              value.adminDashTileDetail[index]["type"],
                              style: TextStyle(
                                fontSize: 14,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _makePhoneCall(
                              value.adminDashTileDetail[index]["cust_phn"],
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.05,
                            child: Icon(
                              Icons.phone,
                              color: Colors.green,
                              size: 16,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 4,
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.23,
                          child: Text(
                            "Phone",
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          width: 14,
                          child: Text(":"),
                        ),
                        Expanded(
                          child: Text(
                              // "hbhjsbdjnzsbnjbcndbcnjbbbbbbbbbbbbbbbbb bjhhhhhhhhhhh bjhhhhhhhhhhhhhhhhhhhh",
                              value.adminDashTileDetail[index]["cust_phn"],
                              style: TextStyle(
                                fontSize: 14,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.05,
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ),
                        // SizedBox(
                        //   width: 4,
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.23,
                          child: Text(
                            "Instalation date",
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          width: 14,
                          child: Text(":"),
                        ),
                        Expanded(
                          child: Text(
                              // "hbhjsbdjnzsbnjbcndbcnjbbbbbbbbbbbbbbbbb bjhhhhhhhhhhh bjhhhhhhhhhhhhhhhhhhhh",
                              value.adminDashTileDetail[index]
                                  ["installation_date"],
                              style: TextStyle(
                                fontSize: 14,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.05,
                          child: Icon(
                            Icons.person_2_outlined,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                        // SizedBox(
                        //   width: 14,
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.23,
                          child: Text(
                            "Staff",
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          child: Text(":"),
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                              // "hbhjsbdjnzsbnjbcndbcnjbbbbbbbbbbbbbbbbb bjhhhhhhhhhhh bjhhhhhhhhhhhhhhhhhhhh",
                              value.adminDashTileDetail[index]["stf"],
                              style: TextStyle(
                                fontSize: 14,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.05,
                          child: Icon(
                            Icons.note,
                            color: Colors.brown,
                            size: 16,
                          ),
                        ),
                        // SizedBox(
                        //   width: 4,
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.23,
                          child: Text(
                            "Status",
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          width: 14,
                          child: Text(":"),
                        ),
                        Expanded(
                          child: Text(
                              // "hbhjsbdjnzsbnjbcndbcnjbbbbbbbbbbbbbbbbb bjhhhhhhhhhhh bjhhhhhhhhhhhhhhhhhhhh",
                              value.adminDashTileDetail[index]["sts"],
                              style: TextStyle(
                                fontSize: 14,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    value.adminDashTileDetail[index]["complaints"] == null ||
                            value.adminDashTileDetail[index]["complaints"]
                                .isEmpty
                        ? Container()
                        : InkWell(
                            onTap: () {
                              ShowComplaintsSheet com = ShowComplaintsSheet();
                              com.showComplaintSheet(
                                  context,
                                  value.adminDashTileDetail[index]["cust_name"]
                                      .toString(),
                                  value.adminDashTileDetail[index]["complaints"]
                                      .toString());
                            },
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  child: Text("Show Complaints",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 13)),
                                ),
                                SizedBox(
                                  width: 14,
                                  child: Text(":"),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/notes.png",
                                    height: 16,
                                    // color: Colors.brown,
                                  ),
                                )
                                // Expanded(
                                //   child: RichText(
                                //     text: TextSpan(
                                //       // text: '• ',
                                //       style: TextStyle(
                                //         fontSize: 14,
                                //         color: Colors.grey[800],
                                //       ),
                                //       children: <TextSpan>[
                                //         TextSpan(
                                //             text: rem,
                                //             style: GoogleFonts
                                //                 .ptSansNarrow(
                                //                     textStyle:
                                //                         TextStyle(
                                //               fontSize: 13,
                                //               color: Colors.grey[800],
                                //             ))),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
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
}
