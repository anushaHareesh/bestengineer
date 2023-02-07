import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/screen/Enquiry/EnqHistory.dart';
import 'package:bestengineer/screen/Enquiry/enqDashboard.dart';
import 'package:bestengineer/screen/Enquiry/enqcart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import 'package:badges/badges.dart' as badges;

class EnqHome extends StatefulWidget {
  const EnqHome({super.key});

  @override
  State<EnqHome> createState() => _EnqHomeState();
}

class _EnqHomeState extends State<EnqHome> {
  String? selected;
  List<String> area = ["jkdsd", "djsdj"];
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  List<Widget> drawerOpts = [];
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).getArea(context);
    Provider.of<ProductController>(context, listen: false)
        .getbagData(context, "0");
    Provider.of<Controller>(context, listen: false).gePriorityList(context);
    Provider.of<ProductController>(context, listen: false)
        .geProductList(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 248, 248),
      key: _key,
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EnQHistory()),
                  );
                },
                child: Icon(
                  Icons.history,
                  size: 20,
                  color: Colors.red,
                )),
          ),
          InkWell(
            onTap: () {
              buildPopupDialog(context, size);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Consumer<Controller>(
                builder: (context, value, child) {
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.place,
                        size: 17,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        value.selected == null
                            ? "Choose Area"
                            : value.selected.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
        backgroundColor: P_Settings.whiteColor,
        elevation: 1,
        leading: Builder(
          builder: (context) => Consumer<Controller>(
            builder: (context, value, child) {
              return IconButton(
                  icon: new Icon(Icons.menu, color: Colors.grey[800]),
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
      // bottomNavigationBar: SizedBox(
      //     height: 50,
      //     child: InkWell(
      //       onTap: () {
      //         Provider.of<ProductController>(context, listen: false)
      //             .getbagData(context, "0");
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => EnqCart()),
      //         );
      //       },
      //       child: Container(
      //         color: P_Settings.loginPagetheme,
      //         child: Consumer<ProductController>(
      //           builder: (context, value, child) {
      //             return Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text(
      //                   "View Data",
      //                   style: TextStyle(
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.bold,
      //                       color: P_Settings.whiteColor),
      //                 ),
      //                 SizedBox(
      //                   width: size.width * 0.04,
      //                 ),
      //                 badges.Badge(
      //                     badgeStyle: badges.BadgeStyle(
      //                         // badgeGradient: badges.BadgeGradient.radial(colors: Colors.primaries),
      //                         shape: badges.BadgeShape.circle,
      //                         badgeColor: Colors.red),
      //                     position:
      //                         badges.BadgePosition.topEnd(top: -10, end: -22),
      //                     badgeContent: value.isCartLoading
      //                         ? SpinKitChasingDots(
      //                             color: P_Settings.loginPagetheme,
      //                             size: 8,
      //                           )
      //                         : Text(
      //                             value.cartCount.toString(),
      //                             style: TextStyle(color: Colors.white),
      //                           ),
      //                     child: Icon(
      //                       Icons.shopping_cart,
      //                       color: Colors.white,
      //                     ))
      //               ],
      //             );
      //           },
      //         ),
      //       ),
      //     )),
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

  //////////////////////////////////////////////////////////////////
  buildPopupDialog(BuildContext context, Size size) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: Consumer<Controller>(builder: (context, value, child) {
                // if (value.isLoading) {
                //   return CircularProgressIndicator();
                // } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.grey[200],
                      height: size.height * 0.04,
                      child: DropdownButton<String>(
                        value: selected,
                        // isDense: true,
                        hint: Text("Select"),
                        // isExpanded: true,
                        autofocus: false,
                        underline: SizedBox(),
                        elevation: 0,
                        items: value.area_list
                            .map((item) => DropdownMenuItem<String>(
                                value: item.areaId.toString(),
                                child: Container(
                                  width: size.width * 0.4,
                                  child: Text(
                                    item.areaName.toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )))
                            .toList(),
                        onChanged: (item) {
                          print("clicked");

                          if (item != null) {
                            setState(() {
                              selected = item;
                            });
                            print("se;ected---$item");
                          }
                        },
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: P_Settings.loginPagetheme),
                        onPressed: () async {
                          String tabId;
                          Provider.of<Controller>(context, listen: false)
                              .setDropdowndata(selected!);
                          Provider.of<Controller>(context, listen: false)
                              .getCustomerList(context, selected!);

                          // if (value.menuClick == true) {
                          //   tabId = value.customIndex!;
                          // } else {
                          //   tabId = value.tab_index!;
                          // }
                          // print("gahghgd------${value.customIndex}");
                          // Provider.of<Controller>(context, listen: false)
                          //     .loadReportData(context, tabId, value.fromDate!,
                          //         value.todate!, value.brId!, "");

                          Navigator.pop(context);
                        },
                        child: Text("Apply"))
                  ],
                );
                // }
              }),
            );
          });
        });
  }
}
