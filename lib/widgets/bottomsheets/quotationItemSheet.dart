import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';

class QuotationItemSheet {
  String? enqId;

  ValueNotifier<bool> rateError = ValueNotifier(false);
  TextEditingController desc = TextEditingController();
  showItemSheet(BuildContext context, int index, Map map, String type,
      String enid, String row_id, String ugp) {
    rateError.value = false;
    Size size = MediaQuery.of(context).size;

    String oldDesc;
    // oldDesc = list["description"];
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            // <-- SEE HERE
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Consumer<QuotationController>(builder: (context, value, child) {
          // value.qty[index].text=qty.toString();

          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (rateError.value == false) {
                                Navigator.pop(context);
                              }
                            },
                            icon: Icon(Icons.close)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              map["product_name"].toUpperCase(),
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                // color: P_Settings.loginPagetheme,
                              ),
                            ),
                          ),
                          // Spacer(),
                          // IconButton(
                          //     onPressed: () {
                          //       Navigator.pop(context);
                          //     },
                          //     icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    // ListTile(
                    //   title: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         map["product_info"],
                    //         style: GoogleFonts.aBeeZee(
                    //           textStyle: Theme.of(context).textTheme.bodyText2,
                    //           fontSize: 17,
                    //           // fontWeight: FontWeight.bold,
                    //           // color: P_Settings.loginPagetheme,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Row(
                        children: [
                          Text(
                            "Rate",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              // fontWeight: FontWeight.bold,
                              // color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: size.width * 0.2,
                            child: Row(
                              children: [
                                // Text("\u{20B9}"),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (val) {
                                      double rateval = double.parse(val);
                                      if (type == "add") {
                                        if (rateval <
                                            double.parse(
                                                value.quotProdItem[index]
                                                    ["base_rate"])) {
                                          rateError.value = true;
                                        } else {
                                          rateError.value = false;
                                          value.rawCalculation(
                                              double.parse(
                                                  value.rateEdit[index].text),
                                              int.parse(
                                                  value.quotqty[index].text),
                                              double.parse(value
                                                  .discount_prercent[index]
                                                  .text),
                                              double.parse(value
                                                  .discount_amount[index].text),
                                              double.parse(map["tax_perc"]),
                                              0.0,
                                              "0",
                                              0,
                                              index,
                                              true,
                                              "rate");
                                        }
                                      } else if (type == "edit") {
                                        if (rateval <
                                            double.parse(
                                                value.quotationEditList[index]
                                                    ["base_rate"])) {
                                          rateError.value = true;
                                        } else {
                                          rateError.value = false;
                                          value.rawCalculation(
                                              double.parse(
                                                  value.rateEdit[index].text),
                                              int.parse(
                                                  value.quotqty[index].text),
                                              double.parse(value
                                                  .discount_prercent[index]
                                                  .text),
                                              double.parse(value
                                                  .discount_amount[index].text),
                                              double.parse(map["tax_perc"]),
                                              0.0,
                                              "0",
                                              0,
                                              index,
                                              true,
                                              "rate");
                                        }
                                      }

                                      // else {
                                      //   if (rateval <
                                      //       double.parse(
                                      //           value.enqSceheduleQuotLIST[index]
                                      //               ["base_rate"])) {
                                      //     rateError.value = true;
                                      //   } else {
                                      //     rateError.value = false;
                                      //     value.rawCalculation(
                                      //         double.parse(
                                      //             value.rateEdit[index].text),
                                      //         int.parse(
                                      //             value.quotqty[index].text),
                                      //         double.parse(value
                                      //             .discount_prercent[index]
                                      //             .text),
                                      //         double.parse(value
                                      //             .discount_amount[index].text),
                                      //         double.parse(map["tax_perc"]),
                                      //         0.0,
                                      //         "0",
                                      //         0,
                                      //         index,
                                      //         true,
                                      //         "rate");
                                      //   }
                                      // }

                                      // value.fromApi = false;
                                    },
                                    textAlign: TextAlign.right,
                                    onTap: () {
                                      value.rateEdit[index].selection =
                                          TextSelection(
                                              baseOffset: 0,
                                              extentOffset: value
                                                  .rateEdit[index]
                                                  .value
                                                  .text
                                                  .length);
                                    },
                                    controller: value.rateEdit[index],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(0.0),
                                      isDense: true,
                                      // border: InputBorder.none,
                                    ),
                                    minLines: 1,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Row(
                        children: [
                          Text(
                            "Qty",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              // fontWeight: FontWeight.bold,
                              // color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              int qt = int.parse(value.quotqty[index].text);
                              // double.parse();
                              qt = qt + 1;
                              value.quotqty[index].text = qt.toString();
                              value.rawCalculation(
                                  double.parse(value.rateEdit[index].text),
                                  int.parse(value.quotqty[index].text),
                                  double.parse(
                                      value.discount_prercent[index].text),
                                  double.parse(
                                      value.discount_amount[index].text),
                                  double.parse(map["tax_perc"]),
                                  0.0,
                                  "0",
                                  0,
                                  index,
                                  true,
                                  "qty");
                              // value.inCrementQty(
                              //     int.parse(value.qty[index].text), index, "");
                            },
                            child: Container(
                                height: size.height * 0.04,
                                width: size.width * 0.06,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 205, 195, 195),
                                  ),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 14,
                                  color: P_Settings.loginPagetheme,
                                )),
                          ),
                          Container(
                            width: size.width * 0.06,
                            alignment: Alignment.center,
                            child: TextField(
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              controller: value.quotqty[index],

                              // value.qtyVal.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (int.parse(value.quotqty[index].text) > 1) {
                                int q =
                                    int.parse(value.quotqty[index].text) - 1;

                                print(
                                    "vv-----${value.quotqty[index].text}---$q");
                                value.quotqty[index].text = q.toString();
                                print(
                                    "jkhfdjkf--------${value.quotqty[index].text}");
                              } else {
                                int q = 1;
                                value.quotqty[index].text = q.toString();
                              }
                              // int qt = int.parse(value.quotqty[index].text);
                              // if (qt == 0) {
                              //   q = 1;
                              // } else {
                              //   q = qt - 1;
                              // }

                              value.rawCalculation(
                                  double.parse(value.rateEdit[index].text),
                                  int.parse(value.quotqty[index].text),
                                  double.parse(
                                      value.discount_prercent[index].text),
                                  double.parse(
                                      value.discount_amount[index].text),
                                  double.parse(map["tax_perc"]),
                                  0.0,
                                  "0",
                                  0,
                                  index,
                                  true,
                                  "qty");
                              // value.deCrementQty(
                              //     int.parse(value.qty[index].text), index, "");
                            },
                            child: Container(
                                height: size.height * 0.04,
                                width: size.width * 0.06,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 205, 195, 195),
                                  ),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 14,
                                  color: P_Settings.loginPagetheme,
                                )),
                          )
                        ],
                      ),
                    ),
                    // Padding(padding: EdgeInsets.all(8)),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      title: Row(
                        children: [
                          Text(
                            "Gross",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              // fontWeight: FontWeight.bold,
                              // color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(value.gross.toStringAsFixed(2)),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      title: Row(
                        children: [
                          Text(
                            "Tax per",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              // fontWeight: FontWeight.bold,
                              // color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(map["tax_perc"].toString()),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      title: Row(
                        children: [
                          Text(
                            "Tax amount",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              // fontWeight: FontWeight.bold,
                              // color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(value.tax.toStringAsFixed(2)),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      title: Row(
                        children: [
                          Text(
                            "Disc_per",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              // fontWeight: FontWeight.bold,
                              // color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: size.width * 0.2,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onTap: () {
                                value.discount_prercent[index].selection =
                                    TextSelection(
                                        baseOffset: 0,
                                        extentOffset: value
                                            .discount_prercent[index]
                                            .value
                                            .text
                                            .length);
                              },
                              onSubmitted: (val) {
                                value.rawCalculation(
                                    double.parse(value.rateEdit[index].text),
                                    int.parse(value.quotqty[index].text),
                                    double.parse(
                                        value.discount_prercent[index].text),
                                    double.parse(
                                        value.discount_amount[index].text),
                                    double.parse(map["tax_perc"]),
                                    0.0,
                                    "0",
                                    0,
                                    index,
                                    true,
                                    "disc_per");
                              },
                              textAlign: TextAlign.right,
                              controller: value.discount_prercent[index],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0.0),
                                isDense: true,
                                // border: InputBorder.none,
                              ),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      title: Row(
                        children: [
                          Text(
                            "Disc_amt",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              // fontWeight: FontWeight.bold,
                              // color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: size.width * 0.2,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onTap: () {
                                value.discount_amount[index].selection =
                                    TextSelection(
                                        baseOffset: 0,
                                        extentOffset: value
                                            .discount_amount[index]
                                            .value
                                            .text
                                            .length);
                              },
                              onSubmitted: (val) {
                                value.rawCalculation(
                                    double.parse(value.rateEdit[index].text),
                                    int.parse(value.quotqty[index].text),
                                    double.parse(
                                        value.discount_prercent[index].text),
                                    double.parse(
                                        value.discount_amount[index].text),
                                    double.parse(map["tax_perc"]),
                                    0.0,
                                    "0",
                                    0,
                                    index,
                                    true,
                                    "disc_amt");
                              },
                              textAlign: TextAlign.right,
                              controller: value.discount_amount[index],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0.0),
                                isDense: true,
                                // border: InputBorder.none,
                              ),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      title: Row(
                        children: [
                          Text(
                            "Base Rate",
                            style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 14,
                                color: Colors.grey[500]
                                // fontWeight: FontWeight.bold,
                                // color: P_Settings.loginPagetheme,
                                ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              map["base_rate"].toString(),
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ugp=="1"?  ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      title: Row(
                        children: [
                          Text(
                            "L/Cost",
                            style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 14,
                                color: Colors.grey[500]
                                // fontWeight: FontWeight.bold,
                                // color: P_Settings.loginPagetheme,
                                ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              map["l_cost"].toString(),
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ):Container(),
                    Container(
                      margin: EdgeInsets.only(left: 14, right: 14),
                      child: TextField(
                        onChanged: (val) {
                          print("val----$val");
                        },
                        style: TextStyle(color: Colors.grey[500]),
                        controller: desc,
                        decoration: InputDecoration(
                          hintText: "Type Description here ....",
                          hintStyle: TextStyle(fontSize: 13),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(
                                    255, 172, 170, 170)), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(
                                    255, 172, 170, 170)), //<-- SEE HERE
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Row(
                        children: [
                          Text(
                            "Net Total",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              // fontWeight: FontWeight.bold,
                              // color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              "\u{20B9}${value.net_amt.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ValueListenableBuilder(
                          valueListenable: rateError,
                          builder:
                              (BuildContext context, bool v, Widget? child) {
                            return Visibility(
                              visible: v,
                              child: Text(
                                "Rate should be greater than base rate!!!",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.3,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: P_Settings.loginPagetheme
                                  // primary: value.addNewItem
                                  //     ? Colors.green
                                  //     : P_Settings.loginPagetheme

                                  ),
                              onPressed: () async {
                                if (rateError.value == false) {
                                  if (type == "edit") {
                                    enqId = enid;
                                  } else if (type == "add") {
                                    enqId = map["enq_id"];
                                  }
                                  Provider.of<QuotationController>(context,
                                          listen: false)
                                      .updateQuotationData(
                                          context,
                                          "0",
                                          map["product_id"],
                                          value.quotqty[index].text,
                                          enqId.toString(),
                                          value.rateEdit[index].text,
                                          map["tax_perc"],
                                          value.tax.toString(),
                                          value.discount_prercent[index].text,
                                          value.discount_amount[index].text,
                                          value.net_amt.toString(),
                                          value.gross.toString(),
                                          type,
                                          row_id);
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  // print("bhdb----${value.res}");

                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
