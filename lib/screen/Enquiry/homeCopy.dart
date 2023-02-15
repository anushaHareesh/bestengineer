// import 'dart:io';

// import 'package:bestengineer/components/commonColor.dart';
// import 'package:bestengineer/controller/productController.dart';
// import 'package:bestengineer/controller/quotationController.dart';
// import 'package:bestengineer/screen/Enquiry/EnqHistory.dart';
// import 'package:bestengineer/screen/Enquiry/enqDashboard.dart';
// import 'package:bestengineer/screen/Enquiry/enqcart.dart';
// import 'package:bestengineer/screen/Quotation/quotation_listScreen.dart';
// import 'package:bestengineer/screen/registration%20and%20login/login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../controller/controller.dart';
// import 'package:badges/badges.dart' as badges;

// import '../Dashboard/executiveDash.dart';

// class EnqHome extends StatefulWidget {
//   String? type;
//   EnqHome({this.type});

//   @override
//   State<EnqHome> createState() => _EnqHomeState();
// }

// class _EnqHomeState extends State<EnqHome> {
//   bool val = true;
//   DateTime now = DateTime.now();
//   List<String> s = [];
//   String? todaydate;
//   String? date;
//   String? selected;
//   int _selectedIndex = 0;
//   String? staffName;
//   final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
//   List<Widget> drawerOpts = [];
//   final GlobalKey<State> _keyLoader = new GlobalKey<State>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
//     todaydate = DateFormat('dd-MM-yyyy').format(now);
//     s = date!.split(" ");
//     Provider.of<Controller>(context, listen: false).getMenu(context);
//     Provider.of<Controller>(context, listen: false).getArea(context);
//     Provider.of<Controller>(context, listen: false).gePriorityList(context);
//     Provider.of<ProductController>(context, listen: false)
//         .geProductList(context);
//   }

//   _onSelectItem(String? menu) {
//     if (!mounted) return;
//     print("menu----$menu");
//     if (this.mounted) {
//       setState(() {
//         Provider.of<Controller>(context, listen: false).menu_index = menu!;
//       });
//     }
//     Navigator.of(context).pop(); // close the drawer
//   }

//   _getDrawerItemWidget(String? pos) {
//     print("pos---${pos}");
//     switch (pos) {
//       case "E":
//         {
//           Provider.of<Controller>(context, listen: false).getArea(context);
//           Provider.of<Controller>(context, listen: false)
//               .gePriorityList(context);
//           Provider.of<ProductController>(context, listen: false)
//               .geProductList(context);
//           return EnqDashboard();
//         }
//       case "EL":
//         {
//           Provider.of<ProductController>(context, listen: false)
//               .getEnqhistoryData(
//             context,
//             "",
//           );
//           return EnQHistory();
//         }
//       case "DL":
//         return ExecutiveDashBoard();
//       case "QL":
//         {
//           Provider.of<QuotationController>(context, listen: false)
//               .getQuotationList(context, todaydate!);
//           return QuotatationListScreen();
//         }

//       // case "logout":
//       //   logout();
//     }
//   }

//   logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('st_username');
//     await prefs.remove('st_pwd');
//     return Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => LoginPage()));
//     print('Pressed');
//   }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     if (widget.type == "return from quataion") {
//       print("from cart");
//       if (val) {
//         Provider.of<Controller>(context, listen: false).menu_index = "E";
//         val = false;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return WillPopScope(
//       onWillPop: () => _onBackPressed(context),
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Color.fromARGB(255, 250, 248, 248),
//         key: _key,
//         appBar: Provider.of<Controller>(context, listen: false).menu_index ==
//                 "DL"
//             ? AppBar(
//                 backgroundColor: P_Settings.loginPagetheme,
//                 elevation: 0,
//                 flexibleSpace: Container(
//                   decoration: BoxDecoration(),
//                 ),
//                 actions: [
//                   PopupMenuButton(
//                       // add icon, by default "3 dot" icon
//                       // icon: Icon(Icons.book)
//                       itemBuilder: (context) {
//                     return [
//                       PopupMenuItem<int>(
//                         value: 0,
//                         child: Text("Logout"),
//                       ),
//                     ];
//                   }, onSelected: (value) async {
//                     if (value == 0) {
//                       final prefs = await SharedPreferences.getInstance();
//                       await prefs.remove('st_username');
//                       await prefs.remove('st_pwd');
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) => LoginPage()));
//                       print('Pressed');
//                     }
//                   }),
//                 ],
//               )
//             : AppBar(
//                 actions: [
//                   Provider.of<Controller>(context, listen: false).menu_index ==
//                               "EL" ||
//                           Provider.of<Controller>(context, listen: false)
//                                   .menu_index ==
//                               "QL"
//                       ? Container()
//                       : Container(
//                           margin: EdgeInsets.only(right: 8),
//                           child: InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => EnQHistory()),
//                                 );
//                               },
//                               child: Icon(
//                                 Icons.history,
//                                 size: 20,
//                                 color: Colors.red,
//                               )),
//                         ),
//                   Provider.of<Controller>(context, listen: false).menu_index ==
//                               "EL" ||
//                           Provider.of<Controller>(context, listen: false)
//                                   .menu_index ==
//                               "QL"
//                       ? Container()
//                       : InkWell(
//                           onTap: () {
//                             buildPopupDialog(context, size);
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 12.0),
//                             child: Consumer<Controller>(
//                               builder: (context, value, child) {
//                                 return Row(
//                                   // mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Icon(
//                                       Icons.place,
//                                       size: 17,
//                                       color: Colors.red,
//                                     ),
//                                     SizedBox(
//                                       width: 8,
//                                     ),
//                                     Text(
//                                       value.selected == null
//                                           ? "Choose Area"
//                                           : value.selected.toString(),
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey[800]),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                 ],
//                 title: Text(
//                   Provider.of<Controller>(context, listen: false).menu_index ==
//                           "QL"
//                       ? "Quotation List"
//                       : Provider.of<Controller>(context, listen: false)
//                                   .menu_index ==
//                               "EL"
//                           ? "Enquiry List"
//                           : "",
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 backgroundColor: Provider.of<Controller>(context, listen: false)
//                                 .menu_index ==
//                             "EL" ||
//                         Provider.of<Controller>(context, listen: false)
//                                 .menu_index ==
//                             "QL"
//                     ? P_Settings.loginPagetheme
//                     : P_Settings.whiteColor,
//                 elevation: 1,
//                 leading: Builder(
//                   builder: (context) => Consumer<Controller>(
//                     builder: (context, value, child) {
//                       return IconButton(
//                           icon: new Icon(Icons.menu,
//                               color: Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .menu_index ==
//                                           "EL" ||
//                                       Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .menu_index ==
//                                           "QL"
//                                   ? P_Settings.whiteColor
//                                   : Colors.grey[800]),
//                           onPressed: () async {
//                             SharedPreferences prefs =
//                                 await SharedPreferences.getInstance();
//                             staffName = await prefs.getString("staff_name");
//                             drawerOpts.clear();
//                             for (var i = 0;
//                                 i <
//                                     Provider.of<Controller>(context,
//                                             listen: false)
//                                         .menuList
//                                         .length;
//                                 i++) {
//                               // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];

//                               drawerOpts.add(Consumer<Controller>(
//                                 builder: (context, value, child) {
//                                   // print(
//                                   //     "menulist[menu]-------${value.menuList[i]["menu_name"]}");
//                                   return Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 8.0,
//                                         right: 8,
//                                         top: 10,
//                                         bottom: 0),
//                                     child: InkWell(
//                                       onTap: () {
//                                         _onSelectItem(
//                                             value.menuList[i]["prefix"]);
//                                       },
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               // Icon(
//                                               //   Icons.history,
//                                               //   // color: Colors.red,
//                                               // ),
//                                               Container(
//                                                 child: Text(
//                                                   value.menuList[i]
//                                                       ["menu_name"],
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       fontSize: 17),
//                                                 ),
//                                               ),
//                                               Spacer(),
//                                               Image.asset(
//                                                 "assets/right.png",
//                                                 height: 28,
//                                                 color: Colors.grey[700],
//                                               )
//                                             ],
//                                           ),
//                                           Divider(),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ));
//                             }
//                             _key.currentState!.openDrawer();
//                           });
//                     },
//                   ),
//                 ),
//               ),

//         drawer: Consumer<Controller>(
//           builder: (context, value, child) {
//             return Drawer(
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   return SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: size.height * 0.035,
//                         ),
//                         Container(
//                           width: double.infinity,
//                           height: size.height * 0.17,
//                           child: DrawerHeader(
//                               decoration: BoxDecoration(
//                                 color: P_Settings.loginPagetheme,
//                               ),
//                               child: Row(
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundColor: Colors.transparent,
//                                     radius: 30,
//                                     backgroundImage:
//                                         AssetImage("assets/man.png"),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 8.0),
//                                     child: Text(
//                                       staffName.toString(),
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   )
//                                 ],
//                               )),
//                         ),
//                         // InkWell(
//                         //   onTap: () {
//                         //     _onSelectItem("dash");
//                         //   },
//                         //   child: Padding(
//                         //     padding: const EdgeInsets.only(
//                         //         left: 8.0, right: 8, top: 8),
//                         //     child: Row(
//                         //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //       children: [
//                         //         Container(
//                         //           // margin: EdgeInsets.only(left: 10),
//                         //           child: Text(
//                         //             "Dashboard",
//                         //             style: TextStyle(
//                         //                 fontWeight: FontWeight.w500,
//                         //                 fontSize: 17),
//                         //           ),
//                         //         ),
//                         //         Spacer(),
//                         //         Image.asset("assets/right.png",
//                         //             height: 28, color: Colors.grey[700])
//                         //       ],
//                         //     ),
//                         //   ),
//                         // ),
//                         // Divider(),
//                         Column(children: drawerOpts),
//                         // InkWell(
//                         //   onTap: () {
//                         //     _onSelectItem("logout");
//                         //   },
//                         //   child: Padding(
//                         //     padding: const EdgeInsets.only(
//                         //         left: 8.0, right: 8, top: 8),
//                         //     child: Row(
//                         //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //       children: [
//                         //         Icon(Icons.logout),
//                         //         Container(
//                         //           margin: EdgeInsets.only(left: 10),
//                         //           child: Text(
//                         //             "Logout",
//                         //             style: TextStyle(
//                         //                 fontWeight: FontWeight.w500,
//                         //                 fontSize: 17),
//                         //           ),
//                         //         ),
//                         //         Spacer(),
//                         //         Image.asset("assets/right.png",
//                         //             height: 28, color: Colors.grey[700])
//                         //       ],
//                         //     ),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//         ),
//         body: _getDrawerItemWidget(
//             Provider.of<Controller>(context, listen: false).menu_index),
//         // body: Consumer<Controller>(
//         //   builder: (context, value, child) {
//         //     return customContainer();
//         //   },
//         // ),
//       ),
//     );
//   }

//   Widget customContainer() {
//     return Consumer<Controller>(
//       builder: (context, value, child) {
//         return EnqDashboard();

//         // return SingleChildScrollView(
//         //   // physics: NeverScrollableScrollPhysics(),
//         //   child: Container(
//         //     child: value.menuClick ? CustomReport() : TabbarBodyView(),
//         //   ),
//         // );
//       },
//     );
//   }

//   //////////////////////////////////////////////////////////////////
//   buildPopupDialog(BuildContext context, Size size) {
//     return showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState) {
//             return AlertDialog(
//               content: Consumer<Controller>(builder: (context, value, child) {
//                 // if (value.isLoading) {
//                 //   return CircularProgressIndicator();
//                 // } else {
//                 return Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       color: Colors.grey[200],
//                       height: size.height * 0.04,
//                       child: DropdownButton<String>(
//                         value: selected,
//                         // isDense: true,
//                         hint: Text("Select"),
//                         // isExpanded: true,
//                         autofocus: false,
//                         underline: SizedBox(),
//                         elevation: 0,
//                         items: value.area_list
//                             .map((item) => DropdownMenuItem<String>(
//                                 value: item.areaId.toString(),
//                                 child: Container(
//                                   width: size.width * 0.4,
//                                   child: Text(
//                                     item.areaName.toString(),
//                                     style: TextStyle(fontSize: 14),
//                                   ),
//                                 )))
//                             .toList(),
//                         onChanged: (item) {
//                           print("clicked");

//                           if (item != null) {
//                             setState(() {
//                               selected = item;
//                             });
//                             print("se;ected---$item");
//                           }
//                         },
//                       ),
//                     ),
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             primary: P_Settings.loginPagetheme),
//                         onPressed: () async {
//                           String tabId;
//                           Provider.of<Controller>(context, listen: false)
//                               .setDropdowndata(selected!);
//                           Provider.of<Controller>(context, listen: false)
//                               .getCustomerList(context, selected!);

//                           // if (value.menuClick == true) {
//                           //   tabId = value.customIndex!;
//                           // } else {
//                           //   tabId = value.tab_index!;
//                           // }
//                           // print("gahghgd------${value.customIndex}");
//                           // Provider.of<Controller>(context, listen: false)
//                           //     .loadReportData(context, tabId, value.fromDate!,
//                           //         value.todate!, value.brId!, "");

//                           Navigator.pop(context);
//                         },
//                         child: Text("Apply"))
//                   ],
//                 );
//                 // }
//               }),
//             );
//           });
//         });
//   }

//   Future<bool> _onBackPressed(BuildContext context) async {
//     return await showDialog(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           // title: const Text('AlertDialog Title'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: const <Widget>[
//                 Text('Do you want to exit from this app'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//             ),
//             TextButton(
//               child: const Text('Ok'),
//               onPressed: () {
//                 exit(0);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
