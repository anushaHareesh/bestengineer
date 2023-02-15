// import 'package:bestengineer/components/commonColor.dart';
// import 'package:bestengineer/components/dateFind.dart';
// import 'package:bestengineer/controller/controller.dart';
// import 'package:bestengineer/controller/productController.dart';
// import 'package:bestengineer/controller/quotationController.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import '../../widgets/bottomsheets/deleteQuotation.dart';

// class QuotatationListScreen extends StatefulWidget {
//   const QuotatationListScreen({super.key});

//   @override
//   State<QuotatationListScreen> createState() => _QuotatationListScreenState();
// }

// class _QuotatationListScreenState extends State<QuotatationListScreen> {
//   DateFind dateFind = DateFind();
//   DateTime now = DateTime.now();
//   DateTime currentDate = DateTime.now();

//   List<String> s = [];
//   String? todaydate;
//   String? date;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
//     date = DateFormat('dd-MM-yyyy').format(now);
//     // s = date!.split(" ");
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       // appBar: AppBar(
//       //   backgroundColor: P_Settings.loginPagetheme,
//       // ),
//       body: SafeArea(
//         child: Consumer<QuotationController>(
//           builder: (context, value, child) {
//             if (value.isQuotLoading) {
//               return SpinKitCircle(
//                 color: P_Settings.loginPagetheme,
//               );
//             } else {
//               return Column(
//                 children: [
//                   // Padding(
//                   //   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//                   //   child: Row(
//                   //     mainAxisAlignment: MainAxisAlignment.center,
//                   //     children: [
//                   //       Text(
//                   //         "Quotation List",
//                   //         style: TextStyle(
//                   //             fontSize: 16,
//                   //             fontWeight: FontWeight.bold,
//                   //             color: Colors.grey[600]),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: value.quotationList.length,
//                       // physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           // color: P_Settings.fillcolor,
//                           child: ListTile(
//                             title: Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 8.0),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       // Text("Qt No:  ",
//                                       //     style: TextStyle(fontSize: 13)),
//                                       Flexible(
//                                         child: Text(
//                                           value.quotationList[index]["qt_no"],
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 13,
//                                               color: Colors.grey[600]),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Divider(),
//                                 ListTile(
//                                   visualDensity: VisualDensity(
//                                       horizontal: 0, vertical: -4),
//                                   leading: Image.asset(
//                                     "assets/man.png",
//                                     height: size.height * 0.04,
//                                   ),
//                                   trailing: Wrap(
//                                     runAlignment: WrapAlignment.end,
//                                     spacing: 17,
//                                     // runSpacing: 20,
//                                     children: [
//                                       Icon(
//                                         Icons.edit,
//                                         size: 18,
//                                         color: Colors.blue,
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           DeleteQuotation quot =
//                                               DeleteQuotation();
//                                           quot.showdeleteQuotSheet(
//                                             context,
//                                             value.quotationList[index]["qt_no"],
//                                           );
//                                         },
//                                         child: Icon(
//                                           Icons.delete,
//                                           size: 18,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   title: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Flexible(
//                                             child: Text(
//                                               value.quotationList[index]
//                                                   ["cname"],
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                                 color: Colors.grey[700],
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   subtitle: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         value.quotationList[index]["phone_1"],
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.grey[700],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 value.quotationList[index]["company_add1"] ==
//                                         null
//                                     ? Container()
//                                     : Row(
//                                         children: [
//                                           Text(
//                                             "Compnay info: ",
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey[600],
//                                             ),
//                                           ),
//                                           Flexible(
//                                             child: Text(
//                                               // "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkh",
//                                               value.quotationList[index]
//                                                   ["company_add1"],
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                                 color: Colors.grey[700],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 8.0),
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         "Choose Schedule Date : ",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                       Consumer<QuotationController>(
//                                         builder: (context, value, child) {
//                                           return Row(
//                                             children: [
//                                               InkWell(
//                                                 onTap: () async {
//                                                   _selectDate(context,index);
//                                                   // dateFind.selectDateFind(
//                                                   //     context, "to date");
//                                                 },
//                                                 child:
//                                                     Icon(Icons.calendar_month,
//                                                         // color: Colors.blue,
//                                                         size: 17),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10.0),
//                                                 child: Text(
//                                                   value.qtScheduldate[index].toString(),
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.grey[700],
//                                                   ),
//                                                 ),
//                                               ),
//                                               // Text(
//                                               //   value.quotationList[index]["qdate"],
//                                               //   style: TextStyle(
//                                               //       fontWeight: FontWeight.bold,
//                                               //       fontSize: 15,
//                                               //       color: Colors.blue),
//                                               // )
//                                             ],
//                                           );
//                                         },
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Divider(),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           size: 17,
//                                           Icons.calendar_month,
//                                           color:
//                                               Color.fromARGB(255, 110, 110, 7),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 8.0),
//                                           child: Text(
//                                             value.quotationList[index]["qdate"],
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.grey[800]),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Amount  :  ",
//                                           style: TextStyle(fontSize: 13),
//                                         ),
//                                         Text(
//                                           '\u{20B9}${value.quotationList[index]["amount"]}',
//                                           style: TextStyle(
//                                               color: Colors.red,
//                                               fontSize: 13,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context,int index) async {
//     final DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: currentDate,
//         firstDate: DateTime(2015),
//         lastDate: DateTime(2050),
//         builder: (BuildContext context, Widget? child) {
//           return Theme(
//               data: ThemeData.light().copyWith(
//                 colorScheme: ColorScheme.light()
//                     .copyWith(primary: P_Settings.loginPagetheme),
//               ),
//               child: child!);
//         });
//     if (pickedDate != null && pickedDate != currentDate)
//       setState(() {
//         // date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
//         date = DateFormat('dd-MM-yyyy').format(pickedDate);
//           Provider.of<QuotationController>(context, listen: false).setScheduledDate(index,date!);
//       });
//   }
// }
