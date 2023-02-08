import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/widgets/bottomsheets/enqItemEdit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../controller/controller.dart';
import '../../controller/productController.dart';

class EnQHistoryDetails extends StatefulWidget {
  String enqId;
  String enqCode;
  EnQHistoryDetails({required this.enqId,required this.enqCode});

  @override
  State<EnQHistoryDetails> createState() => _EnQHistoryDetailsState();
}

class _EnQHistoryDetailsState extends State<EnQHistoryDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  EnqDataEditsheet editsheet = EnqDataEditsheet();
  String? selected;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.enqCode.toString(),style: TextStyle(color: Colors.grey[700]),),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            )),
        backgroundColor: P_Settings.whiteColor,
      ),
      // bottomNavigationBar: SizedBox(
      //     height: 50,
      //     child: InkWell(
      //       onTap: () {
      //         Provider.of<ProductController>(context, listen: false)
      //             .setCustomerName(
      //                 "0",
      //                 Provider.of<ProductController>(context, listen: false)
      //                     .cname
      //                     .text,
      //                 Provider.of<ProductController>(context, listen: false)
      //                     .cinfo
      //                     .text,
      //                 Provider.of<ProductController>(context, listen: false)
      //                     .phone
      //                     .text,
      //                 Provider.of<ProductController>(context, listen: false)
      //                     .cperson
      //                     .text,
      //                 Provider.of<ProductController>(context, listen: false)
      //                     .landmarked
      //                     .text,
      //                 Provider.of<Controller>(context, listen: false)
      //                     .prioId
      //                     .toString());
      //         showDialog(
      //             context: _scaffoldKey.currentContext!,
      //             barrierDismissible: false,
      //             builder: (BuildContext ctx) {
      //               return new AlertDialog(
      //                 content: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text("Confirm Update?"),
      //                   ],
      //                 ),
      //                 actions: <Widget>[
      //                   Consumer<ProductController>(
      //                     builder: (context, value, child) {
      //                       return Row(
      //                         mainAxisAlignment: MainAxisAlignment.end,
      //                         children: [
      //                           ElevatedButton(
      //                               style: ElevatedButton.styleFrom(
      //                                   primary: P_Settings.loginPagetheme),
      //                               onPressed: () {
      //                                 Navigator.of(_scaffoldKey.currentContext!)
      //                                     .pop();

      //                                 value.saveCartDetails(
      //                                     _scaffoldKey.currentContext!,widget.enqId);
      //                               },
      //                               child: Text("Ok")),
      //                           Padding(
      //                             padding: const EdgeInsets.only(left: 8.0),
      //                             child: ElevatedButton(
      //                                 style: ElevatedButton.styleFrom(
      //                                     primary: P_Settings.loginPagetheme),
      //                                 onPressed: () {
      //                                   Navigator.pop(context);
      //                                 },
      //                                 child: Text("Cancel")),
      //                           )
      //                         ],
      //                       );
      //                     },
      //                   ),
      //                 ],
      //               );
      //             });

      //       },
      //       child: Container(
      //         color: P_Settings.loginPagetheme,
      //         child: Consumer<ProductController>(
      //           builder: (context, value, child) {
      //             return Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text(
      //                   "Update",
      //                   style: TextStyle(
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.bold,
      //                       color: P_Settings.whiteColor),
      //                 ),
      //                 SizedBox(
      //                   width: size.width * 0.04,
      //                 ),
      //               ],
      //             );
      //           },
      //         ),
      //       ),
      //     )),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Consumer<ProductController>(
          builder: (context, value, child) {
            if (value.isDetailLoading) {
              return Container(
                height: size.height * 0.8,
                child: SpinKitCircle(
                  color: P_Settings.loginPagetheme,
                ),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: P_Settings.fillcolor,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, bottom: 20, top: 8),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Customer Details ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Company Name :",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: size.height * 0.05,
                              margin: EdgeInsets.only(left: 9, right: 9, top: 10),
                              child: TextFormField(
                                readOnly: true,
                                controller: value.cname,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: P_Settings.whiteColor,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Contact Person :",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: size.height * 0.05,
                              margin: EdgeInsets.only(left: 9, right: 9, top: 10),
                              child: TextFormField(
                                
                                readOnly: true,
                                controller: value.cperson,
                                decoration: InputDecoration(
                                   filled: true,
                                  fillColor: P_Settings.whiteColor,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Contact Num :",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: size.height * 0.05,
                              margin: EdgeInsets.only(left: 9, right: 9, top: 10),
                              child: TextFormField(
                                readOnly: true,
                                controller: value.phone,
                                decoration: InputDecoration(
                                   filled: true,
                                  fillColor: P_Settings.whiteColor,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Customer Info :",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              // height: size.height * 0.05,
                              margin: EdgeInsets.only(left: 9, right: 9, top: 10),
                              child: TextFormField(
                                readOnly: true,
                                controller: value.cinfo,
                                decoration: InputDecoration(
                                   filled: true,
                                  fillColor: P_Settings.whiteColor,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Landmark :",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: size.height * 0.05,
                              margin: EdgeInsets.only(left: 9, right: 9, top: 10),
                              child: TextFormField(
                  
                                readOnly: true,
                                controller: value.landmarked,
                                decoration: InputDecoration(
                                   filled: true,
                                  fillColor: P_Settings.whiteColor,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                            // Container(
                            //   margin: EdgeInsets.only(top: 8),
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         "Priority Level",
                            //         style: TextStyle(
                            //           fontSize: 16,
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // Consumer<Controller>(
                            //   builder: (context, value, child) {
                            //     return Container(
                            //       height: size.height * 0.05,
                            //       margin:
                            //           EdgeInsets.only(left: 9, right: 9, top: 10),
                            //       decoration: BoxDecoration(
                            //           borderRadius:
                            //               BorderRadius.all(Radius.circular(5)),
                            //           border: Border.all(
                            //             color: Colors.grey,
                            //           )),
                            //       child: ButtonTheme(
                            //         alignedDropdown: true,
                            //         child: DropdownButton<String>(
                            //           // value: selected,
                            //           hint: Padding(
                            //             padding: const EdgeInsets.only(left: 2.0),
                            //             child: Text(
                            //               value.dropSelected == null
                            //                   ? "Select Priority level"
                            //                   : value.dropSelected!,
                            //               style: TextStyle(fontSize: 14),
                            //             ),
                            //           ),
                  
                            //           isExpanded: true,
                            //           autofocus: false,
                            //           underline: SizedBox(),
                            //           elevation: 0,
                            //           items: value.priorityList
                            //               .map((item) => DropdownMenuItem<String>(
                            //                   value: item.lId.toString(),
                            //                   child: Container(
                            //                     // width: size.width * 0.2,
                            //                     child: Padding(
                            //                       padding: const EdgeInsets.only(
                            //                           left: 2.0),
                            //                       child: Text(
                            //                         item.level.toString(),
                            //                         style:
                            //                             TextStyle(fontSize: 14),
                            //                       ),
                            //                     ),
                            //                   )))
                            //               .toList(),
                            //           onChanged: (item) {
                            //             print("clicked");
                  
                            //             if (item != null) {
                            //               selected = item;
                  
                            //               print("se;ected---$item");
                            //               value.setPrioDrop(selected!);
                            //             }
                            //           },
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Product Details",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: value.enQhistoryDetail.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // editsheet.showNewItemSheet(context, index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left:9,top: 2.0,right:9),
                          child: Card(
                            // color: P_Settings.fillcolor,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0,right: 8,top:14,bottom: 14),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          // "sdsbdhsbdhszbddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
                                          value.enQhistoryDetail[index].productName
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                     
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        Text("Qty  : "),
                                        Text(
                                          value.enQhistoryDetail[index].qty
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
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
            }
          },
        ),
      ),
    );
  }
}
