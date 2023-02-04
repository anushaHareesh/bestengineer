import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/widgets/alertCommon/deletePopup.dart';
import 'package:flutter/material.dart';
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
  DeletePopup deletePopup = DeletePopup();
  ItemSlectionBottomsheet itemsheet = ItemSlectionBottomsheet();
  ItemSelectionAlert popup = ItemSelectionAlert();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Enquiry Cart"),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return customTile(size);
          },
        ),
      ),
    );
  }

  Widget customTile(Size size) {
    return Container(
      // color: Colors.yellow,
      // height: size.height * 0.16,
      child: InkWell(
        child: Consumer<Controller>(
          builder: (context, value, child) {
            return Card(
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Flexible(
                  //         child: Text(
                  //           "Name.....",
                  //           overflow: TextOverflow.ellipsis,
                  //           maxLines: 1,
                  //           softWrap: false,
                  //           style:
                  //               TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                // color: Colors.yellow,
                                borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            )),
                            child: Image.asset(
                              "assets/noImg.png",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Positioned(
                          //   top: 112,
                          //   left: 29,
                          //   child: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //       primary: P_Settings.loginPagetheme,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(10), // <-- Radius
                          //       ),
                          //     ),
                          //     onPressed: () {},
                          //     child: Text("ADD"),
                          //   ),
                          // )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Container(
                          width: size.width * 0.58,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Text(
                              //   "CODE ",
                              //   style: TextStyle(
                              //       fontSize: 17, color: Colors.grey[700]),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Item Name",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              // RichText(
                              //   text: TextSpan(
                              //     text:
                              //         "Item Namefzlklkkldmklxmc,lxmvcvm.cmv.,cmv.,cmv,.cmv.",
                              //     style: DefaultTextStyle.of(context).style,
                              //     children: const <TextSpan>[
                              //       TextSpan(
                              //           // text: 'bold',
                              //           style:
                              //               TextStyle(fontWeight: FontWeight.bold)),
                              //     ],
                              //   ),
                              // ),
                              // Flexible(
                              //   child: Text(
                              //     "Item Namefzlklkkldmklxmc,lxmv,.cvm.cmv.,cmv.,cmv,.cmv.",
                              //     style:
                              //         TextStyle(fontSize: 17, color: Colors.grey[500]),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Qty     : ",
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // value.inCrementQty();
                                      },
                                      child: Container(
                                        height: size.height * 0.03,
                                        decoration: BoxDecoration(
                                            color: P_Settings.lightPurple,
                                            borderRadius:
                                                BorderRadius.circular(10)
                                            //more than 50% of width makes circle
                                            ),
                                        width: size.width * 0.1,
                                        child: Icon(Icons.add,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: Text(
                                        "",
                                        // value.qtyVal.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // value.deCrementQty();
                                      },
                                      child: Container(
                                        height: size.height * 0.03,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: P_Settings.lightPurple,
                                        ),
                                        width: size.width * 0.1,
                                        child: Icon(Icons.remove,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Rate   : ",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            deletePopup.builddeletePopupDialog(
                                context, "jhxhj");
                          },
                          child: Row(
                            children: [
                              Text(
                                "Remove",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.red,
                                    fontSize: 15),
                              ),
                              Icon(Icons.close, color: Colors.red, size: 18)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "Total : 200",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
