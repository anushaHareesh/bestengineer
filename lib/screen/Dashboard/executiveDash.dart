import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bestengineer/components/commonColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import 'curveCli.dart';

class ExecutiveDashBoard extends StatefulWidget {
  const ExecutiveDashBoard({super.key});

  @override
  State<ExecutiveDashBoard> createState() => _ExecutiveDashBoardState();
}

class _ExecutiveDashBoardState extends State<ExecutiveDashBoard> {
  customNotification() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Reminder',
      desc: 'Hy ksjkjdskjdsdjk',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    ).show();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     action: SnackBarAction(
    //       label: 'Dissmiss',
    //       textColor: Colors.red,
    //       onPressed: () {
    //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //       },
    //     ),
    //     // margin: EdgeInsets.only(bottom: 100.0),
    //     backgroundColor: Colors.transparent,
    //     behavior: SnackBarBehavior.floating,
    //     elevation: 0,
    //     content: Stack(
    //       children: [
    //         Container(
    //           height: 60,
    //           decoration: BoxDecoration(
    //               color: Color.fromARGB(255, 190, 132, 6),
    //               borderRadius: BorderRadius.all(Radius.circular(15))),
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Row(
    //               children: [
    //                 SizedBox(width: 50),
    //                 Expanded(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         "hellooo haiiii",
    //                         style: TextStyle(
    //                             fontSize: 16,
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.white),
    //                         maxLines: 2,
    //                         overflow: TextOverflow.ellipsis,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //             bottom: 15,
    //             left: 12,
    //             child: ClipRRect(
    //               clipBehavior: Clip.none,
    //               child: Stack(children: [
    //                 Image.asset(
    //                   "assets/chat.png",
    //                   height: 29,
    //                   width: 28,
    //                 )
    //               ]),
    //               borderRadius:
    //                   BorderRadius.only(bottomLeft: Radius.circular(20)),
    //             ))
    //       ],
    //     ),
    //   ),
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      customNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              painter: HeaderCurvedContainer(),
            ),
            Positioned(
              top: 60,
              child: Consumer<Controller>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: size.height * 0.28,
                            width: size.width * 0.45,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * 0.07,
                                    width: size.width * 0.2,
                                    child: Image.asset(
                                      "assets/enquiry.png",
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Enquiry",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        value.isDahboardLoading
                                            ? SpinKitThreeBounce(
                                                color:
                                                    P_Settings.loginPagetheme,
                                                size: 13)
                                            : Text(
                                                value.enqCount.toString(),
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.bold,
                                                    color: P_Settings
                                                        .loginPagetheme),
                                              )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20.0), //<-- SEE HERE
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.28,
                            width: size.width * 0.45,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * 0.07,
                                    width: size.width * 0.2,
                                    child: Image.asset(
                                      "assets/quot.png",
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Quotation",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        value.isDahboardLoading
                                            ? SpinKitThreeBounce(
                                                color:
                                                    P_Settings.loginPagetheme,
                                                size: 13)
                                            : Text(
                                                value.quotationCount.toString(),
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.bold,
                                                    color: P_Settings
                                                        .loginPagetheme),
                                              )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20.0), //<-- SEE HERE
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.00,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: size.height * 0.28,
                            width: size.width * 0.45,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * 0.07,
                                    width: size.width * 0.2,
                                    child: Image.asset(
                                      "assets/files.png",
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Verified Enquiry",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        value.isDahboardLoading
                                            ? SpinKitThreeBounce(
                                                color:
                                                    P_Settings.loginPagetheme,
                                                size: 13)
                                            : Text(
                                                value.verifedEnqCount
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.bold,
                                                    color: P_Settings
                                                        .loginPagetheme),
                                              )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20.0), //<-- SEE HERE
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.28,
                            width: size.width * 0.45,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: size.height * 0.07,
                                    width: size.width * 0.2,
                                    child: Image.asset(
                                      "assets/calendar.png",
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Schedule",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        value.isDahboardLoading
                                            ? SpinKitThreeBounce(
                                                color:
                                                    P_Settings.loginPagetheme,
                                                size: 13)
                                            : Text(
                                                value.scheduleCount.toString(),
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.bold,
                                                    color: P_Settings
                                                        .loginPagetheme),
                                              )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20.0), //<-- SEE HERE
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
