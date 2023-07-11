import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/widgets/alertCommon/deletePopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';
import '../../widgets/alertCommon/itemSelectionAlert.dart';

import '../../widgets/bottomsheets/itemSelectionSheet.dart';

class EnqCart extends StatefulWidget {
  const EnqCart({super.key});

  @override
  State<EnqCart> createState() => _EnqCartState();
}

class _EnqCartState extends State<EnqCart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DeletePopup deletePopup = DeletePopup();
  ItemSlectionBottomsheet itemsheet = ItemSlectionBottomsheet();
  ItemSelectionAlert popup = ItemSelectionAlert();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: P_Settings.whiteColor,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.grey[800],
            )),
        title: Text(
          "Enquiry Cart",
          style: TextStyle(
              fontSize: 17,
              color: Colors.grey[800],
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: P_Settings.whiteColor,
        elevation: 1,
      ),
      body: Consumer<ProductController>(
        builder: (context, value, child) {
          if (value.isCartLoading) {
            return SpinKitCircle(
              color: P_Settings.loginPagetheme,
            );
          } else {
            if (value.bagList.length == 0) {
              return Center(
                child: Lottie.asset("assets/cartem.json",
                    height: size.height * 0.3),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                      child: ListView.builder(
                        itemCount: value.bagList.length,
                        itemBuilder: (context, index) {
                          return customTile(size, index);
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (value.bagList.length > 0) {
                        showDialog(
                            context: _scaffoldKey.currentContext!,
                            barrierDismissible: false,
                            builder: (BuildContext ctx) {
                              return new AlertDialog(
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Do you want to confirm ?"),
                                  ],
                                ),
                                actions: <Widget>[
                                  Consumer<ProductController>(
                                    builder: (context, value, child) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: P_Settings
                                                      .loginPagetheme),
                                              onPressed: () {
                                                Navigator.of(_scaffoldKey
                                                        .currentContext!) 
                                                    .pop();
                                                showDailogue(context, true,
                                                    _keyLoader, 1);
                                                value.saveCartDetails(
                                                    _scaffoldKey
                                                        .currentContext!,
                                                    "0");

                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .customer_id = null;
                                                      Provider.of<Controller>(context,
                                                        listen: false)
                                                    .dupcustomer_id = null;
                                              },
                                              child: Text("Ok")),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: P_Settings
                                                        .loginPagetheme),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel")),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: size.height * 0.05,
                      color: P_Settings.loginPagetheme,
                    ),
                  )
                ],
              );
            }
          }
        },
      ),
    );
  }

  Widget customTile(Size size, int index) {
    return Container(
      // color: Colors.yellow,
      // height: size.height * 0.16,
      child: InkWell(
        child: Consumer<ProductController>(
          builder: (context, value, child) {
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  // side: BorderSide(
                  //   color: P_Settings.fillcolor,
                  // ),
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(20),
                  //     topLeft: Radius.circular(70),
                  //     topRight: Radius.circular(20))
                  ),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 8, bottom: 8, top: 8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                // color: Colors.yellow,
                                borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            )),
                            child: Image.asset(
                              "assets/noImg.png",
                              height: 90,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        width: size.width * 0.64,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              value.bagList[index]["item_name"].toString(),
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Container(
                            //   margin: EdgeInsets.only(top: 5),
                            //   child: Text(
                            //     "Decsriptionnnxcx nbdsjfksfhkdfjdk xcbxn",
                            //     style: TextStyle(
                            //       color: Colors.grey[600],
                            //         fontSize: 15, ),
                            //   ),
                            // ),
                            SizedBox(
                              height: size.height * 0.006,
                            ),

                            Row(
                              children: [
                                Text(
                                  "Qty     : ",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Container(
                                    height: size.height * 0.03,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            value.inCrementQty(
                                                int.parse(
                                                    value.cartQty[index].text),
                                                index,
                                                "cart");
                                            Provider.of<ProductController>(
                                                    context,
                                                    listen: false)
                                                .addDeletebagItem(
                                                    value.bagList[index]
                                                            ["item_name"]
                                                        .toString(),
                                                    value.bagList[index]
                                                            ["item_id"]
                                                        .toString(),
                                                    value.cartQty[index].text,
                                                    value.bagList[index]
                                                        ["description"],
                                                    "1",
                                                    value.bagList[index]
                                                        ["cart_id"],
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .dupcustomer_id
                                                        .toString(),
                                                    context);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 205, 195, 195),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                size: 14,
                                                color:
                                                    P_Settings.loginPagetheme,
                                              )),
                                        ),
                                        Container(
                                          width: size.width * 0.06,
                                          child: TextField(
                                            readOnly: true,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            controller: value.cartQty[index],
                                            // value.qtyVal.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            value.deCrementQty(
                                                int.parse(
                                                    value.cartQty[index].text),
                                                index,
                                                "cart");
                                            Provider.of<ProductController>(
                                                    context,
                                                    listen: false)
                                                .addDeletebagItem(
                                                    value.bagList[index]
                                                            ["item_name"]
                                                        .toString(),
                                                    value.bagList[index]
                                                            ["item_id"]
                                                        .toString(),
                                                    value.cartQty[index].text,
                                                    value.bagList[index]
                                                        ["description"],
                                                    "1",
                                                    value.bagList[index]
                                                        ["cart_id"],
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .dupcustomer_id
                                                        .toString(),
                                                    context);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 205, 195, 195),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                size: 14,
                                                color:
                                                    P_Settings.loginPagetheme,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.006,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   "Rate   : ",
                                //   style: TextStyle(
                                //     fontSize: 15,
                                //   ),
                                // ),
                                value.bagList[index]["s_rate_1"] == null
                                    ? Container()
                                    : Text(
                                        '\u{20B9}${value.bagList[index]["s_rate_1"]}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w600,
                                        )),
                                InkWell(
                                  onTap: () {
                                    deletePopup.builddeletePopupDialog(
                                        context,
                                        value.bagList[index]["item_name"]
                                            .toString(),
                                        value.bagList[index]["item_id"]
                                            .toString(),
                                        index,
                                        "cart",
                                        "",
                                        "",
                                        "",
                                        "","","");
                                  },
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Remove",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.red,
                                            fontSize: 15),
                                      ),
                                      Icon(Icons.close,
                                          color: Colors.red, size: 18)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Divider(),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       InkWell(
                  //         onTap: () {
                  //           deletePopup.builddeletePopupDialog(
                  //               context, "jhxhj");
                  //         },
                  //         child: Row(
                  //           children: [
                  //             Text(
                  //               "Remove",
                  //               style: TextStyle(
                  //                   fontStyle: FontStyle.italic,
                  //                   color: Colors.red,
                  //                   fontSize: 15),
                  //             ),
                  //             Icon(Icons.close, color: Colors.red, size: 18)
                  //           ],
                  //         ),
                  //       ),
                  //       // Padding(
                  //       //   padding: const EdgeInsets.only(right: 8.0),
                  //       //   child: Row(
                  //       //     children: [
                  //       //       Text(
                  //       //         "Total : 200",
                  //       //         style: TextStyle(
                  //       //             fontStyle: FontStyle.italic,
                  //       //             color: Colors.red,
                  //       //             fontWeight: FontWeight.bold,
                  //       //             fontSize: 17),
                  //       //       )
                  //       //     ],
                  //       //   ),
                  //       // )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

showDailogue(BuildContext context, bool isLoading, GlobalKey key, int content) {
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;

        return new WillPopScope(
            onWillPop: () async => true,
            child: SimpleDialog(
                key: key,
                backgroundColor: Colors.white,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            "Loading .... ",
                            style: TextStyle(color: Colors.black),
                          ),
                          CircularProgressIndicator(
                            color: Colors.green,
                          )
                        ]),
                  )
                ]));
      });
}
