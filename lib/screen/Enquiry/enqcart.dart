import 'package:flutter/material.dart';

import '../../components/commonColor.dart';
import '../../widgets/alertCommon/itemSelectionAlert.dart';
import '../../widgets/bottomsheets/itemSelectionSheet.dart';

class EnqCart extends StatefulWidget {
  const EnqCart({super.key});

  @override
  State<EnqCart> createState() => _EnqCartState();
}

class _EnqCartState extends State<EnqCart> {
  ItemSlectionBottomsheet itemsheet = ItemSlectionBottomsheet();
  ItemSelectionAlert popup = ItemSelectionAlert();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Enquiry Page"),
      //   backgroundColor: P_Settings.loginPagetheme,
      // ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return customTile(size);
        },
      ),
    );
  }

  Widget customTile(Size size) {
    return Container(
      // color: Colors.yellow,
      // height: size.height * 0.16,
      child: InkWell(
        onTap: () {
          // itemsheet.showItemSheet(context);
          popup.buildPopupDialog(
            context,
          );
        },
        child: Card(
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
                          "assets/burger.jpg",
                          height: 120,
                          width: 120,
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
                          Text(
                            "CODE ",
                            style: TextStyle(
                                fontSize: 17, color: Colors.grey[700]),
                          ),
                          Text(
                            "Item Name",
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
                          Text(
                            "Qty : ",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            "Rate : ",
                            style: TextStyle(
                              fontSize: 17,
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
                    Row(
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
        ),
      ),
    );
  }
}
