import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';
import '../../controller/productController.dart';
import '../../controller/quotationController.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 6),
                        // width: size.width * 0.68,
                        height: size.height * 0.045,
                        child: TextField(
                          // controller: _controller,
                          onChanged: (val) {
                            if (val != null && val.isNotEmpty) {
                              Provider.of<ProductController>(context,
                                      listen: false)
                                  .searchProduct(context, val);
                              // Provider.of<ProductController>(context,
                              //         listen: false)
                              //     .setIssearch(true);
                              // Provider.of<ProductController>(context,
                              //         listen: false)
                              //     .geProductList(context);
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 19,
                              ),
                              onPressed: () {
                                // search.clear();
                                Provider.of<ProductController>(context,
                                        listen: false)
                                    .adddNewItem = false;
                                Provider.of<ProductController>(context,
                                        listen: false)
                                    .setIssearch(false);
                              },
                            ),
                            hintText: "Search item here",
                            hintStyle: TextStyle(fontSize: 13),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ), //<-- SEE HERE
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ), //<-- SEE HERE
                            ),
                          ),
                        )),
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: value.quotationList.length,
                  //     // physics: NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemBuilder: (context, index) {
                  //       // return buildCard(index, size);
                  //       return Container(
                  //         child: Text("dksdjs"),
                  //       );
                  //       // return Card(
                  //       //   // color: P_Settings.fillcolor,
                  //       //   child: ListTile(
                  //       //     title: Column(
                  //       //       children: [
                  //       //         Padding(
                  //       //           padding: const EdgeInsets.only(top: 8.0),
                  //       //           child: Row(
                  //       //             mainAxisAlignment: MainAxisAlignment.center,
                  //       //             children: [
                  //       //               // Text("Qt No:  ",
                  //       //               //     style: TextStyle(fontSize: 13)),
                  //       //               Flexible(
                  //       //                 child: Text(
                  //       //                   value.quotationList[index]["qt_no"],
                  //       //                   style: TextStyle(
                  //       //                       fontWeight: FontWeight.bold,
                  //       //                       fontSize: 13,
                  //       //                       color: Colors.grey[600]),
                  //       //                 ),
                  //       //               ),
                  //       //             ],
                  //       //           ),
                  //       //         ),
                  //       //         Divider(),
                  //       //         ListTile(
                  //       //           visualDensity: VisualDensity(
                  //       //               horizontal: 0, vertical: -4),
                  //       //           leading: Image.asset(
                  //       //             "assets/man.png",
                  //       //             height: size.height * 0.04,
                  //       //           ),
                  //       //           trailing: Wrap(
                  //       //             runAlignment: WrapAlignment.end,
                  //       //             spacing: 17,
                  //       //             // runSpacing: 20,
                  //       //             children: [
                  //       //               Icon(
                  //       //                 Icons.edit,
                  //       //                 size: 18,
                  //       //                 color: Colors.blue,
                  //       //               ),
                  //       //               InkWell(
                  //       //                 onTap: () {
                  //       //                   DeleteQuotation quot =
                  //       //                       DeleteQuotation();
                  //       //                   quot.showdeleteQuotSheet(
                  //       //                     context,
                  //       //                     value.quotationList[index]["qt_no"],
                  //       //                   );
                  //       //                 },
                  //       //                 child: Icon(
                  //       //                   Icons.delete,
                  //       //                   size: 18,
                  //       //                   color: Colors.red,
                  //       //                 ),
                  //       //               ),
                  //       //             ],
                  //       //           ),
                  //       //           title: Column(
                  //       //             children: [
                  //       //               Row(
                  //       //                 children: [
                  //       //                   Flexible(
                  //       //                     child: Text(
                  //       //                       value.quotationList[index]
                  //       //                           ["cname"],
                  //       //                       style: TextStyle(
                  //       //                         fontSize: 14,
                  //       //                         color: Colors.grey[700],
                  //       //                       ),
                  //       //                     ),
                  //       //                   )
                  //       //                 ],
                  //       //               ),
                  //       //             ],
                  //       //           ),
                  //       //           subtitle: Row(
                  //       //             mainAxisAlignment:
                  //       //                 MainAxisAlignment.spaceBetween,
                  //       //             children: [
                  //       //               Text(
                  //       //                 value.quotationList[index]["phone_1"],
                  //       //                 style: TextStyle(
                  //       //                   fontSize: 12,
                  //       //                   color: Colors.grey[700],
                  //       //                 ),
                  //       //               ),
                  //       //             ],
                  //       //           ),
                  //       //         ),
                  //       //         value.quotationList[index]["company_add1"] ==
                  //       //                 null
                  //       //             ? Container()
                  //       //             : Row(
                  //       //                 children: [
                  //       //                   Text(
                  //       //                     "Compnay info: ",
                  //       //                     style: TextStyle(
                  //       //                       fontSize: 14,
                  //       //                       color: Colors.grey[600],
                  //       //                     ),
                  //       //                   ),
                  //       //                   Flexible(
                  //       //                     child: Text(
                  //       //                       // "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkh",
                  //       //                       value.quotationList[index]
                  //       //                           ["company_add1"],
                  //       //                       style: TextStyle(
                  //       //                         fontSize: 14,
                  //       //                         color: Colors.grey[700],
                  //       //                       ),
                  //       //                     ),
                  //       //                   ),
                  //       //                 ],
                  //       //               ),
                  //       //         Padding(
                  //       //           padding: const EdgeInsets.only(top: 8.0),
                  //       //           child: Row(
                  //       //             children: [
                  //       //               Text(
                  //       //                 "Choose Schedule Date : ",
                  //       //                 style: TextStyle(
                  //       //                   fontSize: 14,
                  //       //                   color: Colors.grey[600],
                  //       //                 ),
                  //       //               ),
                  //       //               Consumer<QuotationController>(
                  //       //                 builder: (context, value, child) {
                  //       //                   return Row(
                  //       //                     children: [
                  //       //                       InkWell(
                  //       //                         onTap: () async {
                  //       //                           _selectDate(context, index);
                  //       //                           // dateFind.selectDateFind(
                  //       //                           //     context, "to date");
                  //       //                         },
                  //       //                         child:
                  //       //                             Icon(Icons.calendar_month,
                  //       //                                 // color: Colors.blue,
                  //       //                                 size: 17),
                  //       //                       ),
                  //       //                       Padding(
                  //       //                         padding: const EdgeInsets.only(
                  //       //                             left: 10.0),
                  //       //                         child: Text(
                  //       //                           value.qtScheduldate[index]
                  //       //                               .toString(),
                  //       //                           style: TextStyle(
                  //       //                             fontSize: 12,
                  //       //                             fontWeight: FontWeight.bold,
                  //       //                             color: Colors.grey[700],
                  //       //                           ),
                  //       //                         ),
                  //       //                       ),
                  //       //                       // Text(
                  //       //                       //   value.quotationList[index]["qdate"],
                  //       //                       //   style: TextStyle(
                  //       //                       //       fontWeight: FontWeight.bold,
                  //       //                       //       fontSize: 15,
                  //       //                       //       color: Colors.blue),
                  //       //                       // )
                  //       //                     ],
                  //       //                   );
                  //       //                 },
                  //       //               )
                  //       //             ],
                  //       //           ),
                  //       //         ),
                  //       //         Divider(),
                  //       //         Row(
                  //       //           mainAxisAlignment:
                  //       //               MainAxisAlignment.spaceBetween,
                  //       //           children: [
                  //       //             Row(
                  //       //               children: [
                  //       //                 Icon(
                  //       //                   size: 17,
                  //       //                   Icons.calendar_month,
                  //       //                   color:
                  //       //                       Color.fromARGB(255, 110, 110, 7),
                  //       //                 ),
                  //       //                 Padding(
                  //       //                   padding:
                  //       //                       const EdgeInsets.only(left: 8.0),
                  //       //                   child: Text(
                  //       //                     value.quotationList[index]["qdate"],
                  //       //                     style: TextStyle(
                  //       //                         fontSize: 12,
                  //       //                         color: Colors.grey[800]),
                  //       //                   ),
                  //       //                 )
                  //       //               ],
                  //       //             ),
                  //       //             Row(
                  //       //               children: [
                  //       //                 Text(
                  //       //                   "Amount  :  ",
                  //       //                   style: TextStyle(fontSize: 13),
                  //       //                 ),
                  //       //                 Text(
                  //       //                   '\u{20B9}${value.quotationList[index]["amount"]}',
                  //       //                   style: TextStyle(
                  //       //                       color: Colors.red,
                  //       //                       fontSize: 13,
                  //       //                       fontWeight: FontWeight.bold),
                  //       //                 ),
                  //       //               ],
                  //       //             ),
                  //       //           ],
                  //       //         )
                  //       //       ],
                  //       //     ),
                  //       //   ),
                  //       // );
                  //     },
                  //   ),
                  // ),
                ],)
              );
            }
                
  }

