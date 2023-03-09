// import 'package:bestengineer/components/commonColor.dart';
// import 'package:bestengineer/screen/Dashboard/curveCli.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// import '../../controller/controller.dart';

// class ServiceDashboard extends StatefulWidget {
//   const ServiceDashboard({super.key});

//   @override
//   State<ServiceDashboard> createState() => _ServiceDashboardState();
// }

// class _ServiceDashboardState extends State<ServiceDashboard> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   RefreshController _refreshController =
//       RefreshController(initialRefresh: false);
//   void _onRefresh() async {
//     await Future.delayed(Duration(milliseconds: 1000));
//     Provider.of<Controller>(context, listen: false)
//         .getServiceDashboardValues(context);
//         _refreshController.refreshCompleted();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.grey[200],
//       body: SmartRefresher(
//         controller: _refreshController,
//         enablePullDown: true,
//         onRefresh: _onRefresh,
//         child: SafeArea(
//             child: SingleChildScrollView(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               CustomPaint(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                 ),
//                 painter: HeaderCurvedContainer(),
//               ),
//               Positioned(
//                 top: 60,
//                 child: Consumer<Controller>(
//                   builder: (context, value, child) {
//                     return Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                               height: size.height * 0.28,
//                               width: size.width * 0.45,
//                               child: Card(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       height: size.height * 0.07,
//                                       width: size.width * 0.2,
//                                       child: Image.asset(
//                                         "assets/service2.png",
//                                         // fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 12.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "Total Service",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 12.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           value.isServceDahboardLoading
//                                               ? SpinKitThreeBounce(
//                                                   color:
//                                                       P_Settings.loginPagetheme,
//                                                   size: 13)
//                                               : Text(
//                                                   value.totService.toString(),
//                                                   style: TextStyle(
//                                                       fontSize: 26,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: P_Settings
//                                                           .loginPagetheme),
//                                                 )
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       20.0), //<-- SEE HERE
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: size.height * 0.28,
//                               width: size.width * 0.45,
//                               child: Card(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       height: size.height * 0.07,
//                                       width: size.width * 0.2,
//                                       child: Image.asset(
//                                         "assets/service1.png",
//                                         // fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 12.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "Today's Service",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 12.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           value.isServceDahboardLoading
//                                               ? SpinKitThreeBounce(
//                                                   color:
//                                                       P_Settings.loginPagetheme,
//                                                   size: 13)
//                                               : Text(
//                                                   value.todayService.toString(),
//                                                   style: TextStyle(
//                                                       fontSize: 26,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: P_Settings
//                                                           .loginPagetheme),
//                                                 )
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       20.0), //<-- SEE HERE
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: size.height * 0.00,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                               height: size.height * 0.28,
//                               width: size.width * 0.45,
//                               child: Card(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       height: size.height * 0.07,
//                                       width: size.width * 0.2,
//                                       child: Image.asset(
//                                         "assets/install.png",
//                                         // fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 12.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "Today's Installation",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 12.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           value.isServceDahboardLoading
//                                               ? SpinKitThreeBounce(
//                                                   color:
//                                                       P_Settings.loginPagetheme,
//                                                   size: 13)
//                                               : Text(
//                                                   value.todayInstall.toString(),
//                                                   style: TextStyle(
//                                                       fontSize: 26,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: P_Settings
//                                                           .loginPagetheme),
//                                                 )
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       20.0), //<-- SEE HERE
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: size.height * 0.28,
//                               width: size.width * 0.45,
//                               child: Card(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       height: size.height * 0.07,
//                                       width: size.width * 0.2,
//                                       child: Image.asset(
//                                         "assets/calendar.png",
//                                         // fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 12.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "Schedule",
//                                             style: TextStyle(
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 12.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           value.isServceDahboardLoading
//                                               ? SpinKitThreeBounce(
//                                                   color:
//                                                       P_Settings.loginPagetheme,
//                                                   size: 13)
//                                               : Text(
//                                                   value.scheduleCount
//                                                       .toString(),
//                                                   style: TextStyle(
//                                                       fontSize: 26,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: P_Settings
//                                                           .loginPagetheme),
//                                                 )
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       20.0), //<-- SEE HERE
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }
