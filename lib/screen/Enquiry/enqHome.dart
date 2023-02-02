import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/screen/Enquiry/enqDashboard.dart';
import 'package:bestengineer/screen/Enquiry/enqcart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

class EnqHome extends StatefulWidget {
  const EnqHome({super.key});

  @override
  State<EnqHome> createState() => _EnqHomeState();
}

class _EnqHomeState extends State<EnqHome> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  List<Widget> drawerOpts = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        leading: Builder(
          builder: (context) => Consumer<Controller>(
            builder: (context, value, child) {
              return IconButton(
                  icon: new Icon(
                    Icons.menu,
                    color: P_Settings.whiteColor,
                  ),
                  onPressed: () async {
                    drawerOpts.clear();
                    for (var i = 0;
                        i < 5;
                        // Provider.of<Controller>(context, listen: false)
                        //     .customMenuList
                        //     .length;
                        i++) {
                      // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];

                      drawerOpts.add(Consumer<Controller>(
                        builder: (context, value, child) {
                          // print(
                          //     "menulist[menu]-------${value.menuList[i]["menu_name"]}");
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, top: 10, bottom: 8),
                            child: InkWell(
                              onTap: () async {
                                // alertDialoge(
                                //     context,
                                //     size,
                                //     value.customMenuList[i].date_criteria!,
                                //     value.customMenuList[i].tabName!);

                                _key.currentState!.closeDrawer();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "jdsd",
                                    // value.customMenuList[i].tabName!
                                    //     .toUpperCase(),
                                    style: GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.w500,
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ));
                    }
                    _key.currentState!.openDrawer();
                  });
            },
          ),
        ),
      ),
      drawer: Consumer<Controller>(
        builder: (context, value, child) {
          return Drawer(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.045,
                      ),
                      Container(
                        height: size.height * 0.1,
                        width: size.width * 1,
                        color: P_Settings.loginPagetheme,
                        child: Row(
                          children: [
                            SizedBox(
                              height: size.height * 0.07,
                              width: size.width * 0.03,
                            ),
                            Icon(
                              Icons.list_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(width: size.width * 0.01),
                            Text(
                              "Menus",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 13,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 8.0, right: 8, top: 13, bottom: 8),
                      //   child: InkWell(
                      //     onTap: () {
                      //       String br;
                      //       if (value.brId == null) {
                      //         br = "0";
                      //       } else {
                      //         br = value.brId!;
                      //       }
                      //       Provider.of<Controller>(context, listen: false)
                      //           .loadReportData(
                      //               context,
                      //               value.tabId.toString(),
                      //               value.fromDate.toString(),
                      //               value.todate.toString(),
                      //               br);
                      //       Provider.of<Controller>(context, listen: false)
                      //           .setMenuClick(false);
                      //       Navigator.pop(_key.currentContext!);
                      //     },
                      //     child: Row(
                      //       children: [
                      //         Text(
                      //           "DASHBOARD",
                      //           style: TextStyle(fontSize: 17),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Column(children: drawerOpts),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return customContainer();
        },
      ),
    );
  }

  Widget customContainer() {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return EnqDashboard();

        // return SingleChildScrollView(
        //   // physics: NeverScrollableScrollPhysics(),
        //   child: Container(
        //     child: value.menuClick ? CustomReport() : TabbarBodyView(),
        //   ),
        // );
      },
    );
  }
}
