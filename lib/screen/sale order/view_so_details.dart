import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';
import '../../controller/quotationController.dart';

class ViewSODetails extends StatefulWidget {
 String title;
 ViewSODetails({required this.title});

  @override
  State<ViewSODetails> createState() => _ViewSODetailsState();
}

class _ViewSODetailsState extends State<ViewSODetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: Consumer<QuotationController>(
        builder: (context, value, child) => SizedBox(
          height: 50,
          child: Container(
            height: size.height * 0.06,
            color: Colors.yellow,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total : ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
        ),
      ),
      appBar: AppBar(
        title: Text(
          widget.title.toString().toUpperCase(),
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
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
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey[800]),
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
