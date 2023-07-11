import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaleOrderDetails extends StatefulWidget {
  String title;
  String so_id;
  String qtn_id;

  SaleOrderDetails(
      {required this.title, required this.so_id, required this.qtn_id});

  @override
  State<SaleOrderDetails> createState() => _SaleOrderDetailsState();
}

class _SaleOrderDetailsState extends State<SaleOrderDetails> {
  String? userGp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserGp();
  }

  getUserGp() async {
    final prefs = await SharedPreferences.getInstance();
    userGp = prefs.getString("userGroup");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: SizedBox(
          height: 50,
          child: Consumer<QuotationController>(
            builder: (context, value, child) => Row(
              children: [
                InkWell(
                  onTap: userGp == "1"
                      ? () async {
                          return await showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                // title: const Text('AlertDialog Title'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Do you want to Approve ${widget.title}'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Ok'),
                                    onPressed: () {
                                      Provider.of<QuotationController>(context,
                                              listen: false)
                                          .approveSaleOrder(context,
                                              widget.qtn_id, widget.so_id);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      : null,
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.32,
                    color: P_Settings.loginPagetheme,
                    child: Center(
                      child: Text(
                        "APPROVE",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: size.height * 0.06,
                    color: Colors.yellow,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total : ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Flexible(
                          child: Text(
                            // "3623673672367632723623ccc63.00",
                            "\u{20B9}${value.sale_order_net_amt.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          )),
      appBar: AppBar(
        title: Text(widget.title.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<QuotationController>(
        builder: (context, value, child) => value.saleOrderLoading
            ? SpinKitCircle(
                color: P_Settings.loginPagetheme,
              )
            : value.saleOrderDetails.length == 0
                ? Lottie.asset("assets/noData.json")
                : ListView.builder(
                    itemCount: value.saleOrderDetails.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ListTile(
                            title: Column(
                              children: [
                                Text(
                                  value.saleOrderDetails[index]["product_name"],
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey[800]),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Qty           : ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                        Text(
                                          value.saleOrderDetails[index]["qty"],
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "GST : ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                        Text(
                                          '\u{20B9}${value.saleOrderDetails[index]["tax"]}',
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.006,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Rate         : ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                        Text(
                                          '\u{20B9}${value.saleOrderDetails[index]["rate"]}',
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Disc : ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                        Text(
                                          '\u{20B9}${value.saleOrderDetails[index]["discount_amount"]}',
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.006,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Amount : ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                        Text(
                                          '\u{20B9}${value.saleOrderDetails[index]["amount"]}',
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    // Row(
                                    //   children: [Text("Amount : "), Text("12344444.444")],
                                    // ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Net Amount  :  \u{20B9}${value.saleOrderDetails[index]["net_rate"]} ",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    )
                                    // Row(
                                    //   children: [
                                    //     Text("Net Amount"),
                                    //     Text(value.saleOrderDetails[index]["net_rate"])
                                    //   ],
                                    // )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
