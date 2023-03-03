import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:bestengineer/screen/Dashboard/serviceDashboard.dart';
import 'package:bestengineer/screen/Enquiry/EnqHistory.dart';
import 'package:bestengineer/screen/Enquiry/enquiryScreen.dart';
import 'package:bestengineer/screen/Enquiry/enqcart.dart';
import 'package:bestengineer/screen/Quotation/quotation_listScreen.dart';
import 'package:bestengineer/screen/Quotation/scheduleListScreen.dart';
import 'package:bestengineer/screen/Quotation/test.dart';
import 'package:bestengineer/screen/registration%20and%20login/login.dart';
import 'package:bestengineer/screen/service/serviceScheduleList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/controller.dart';
import 'package:badges/badges.dart' as badges;

import '../Dashboard/executiveDash.dart';
import '../Dashboard/searchAutocomplete.dart';
import '../Quotation/statusMonitoringQuotation.dart';

class EnqHome extends StatefulWidget {
  String? type;

  EnqHome({
    this.type,
  });

  @override
  State<EnqHome> createState() => _EnqHomeState();
}

class _EnqHomeState extends State<EnqHome> {
  bool val = true;
  Icon actionIcon = Icon(Icons.search);
  TextEditingController _controller = TextEditingController();
  Widget? appBarTitle;
  String? mobile_user_type;
  DateTime now = DateTime.now();
  List<String> s = [];
  String? todaydate;
  String? date;
  String? selected;
  int _selectedIndex = 0;
  String? staffName;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<Widget> drawerOpts = [];
  // final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  customNotification() {
    print("fhjzklfkdx");
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      // title: 'Reminder',
      descTextStyle: TextStyle(fontSize: 18),
      desc:
          'You have ${Provider.of<RegistrationController>(context, listen: false).scheduleListCount} schedules on tomorrow !!! ',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      // btnCancelOnPress: () {
      //   // Navigator.pushReplacement(
      //   //     context, MaterialPageRoute(builder: (context) => EnqHome(type:"from scheduleList")));
      //   Navigator.pop(_scaffoldKey.currentContext!);
      // },
      btnOkOnPress: () {
        Provider.of<RegistrationController>(context, listen: false)
            .scheduleOpend = true;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScheduleListScreen(
                    type: "from not",
                  )),
        );
        // Navigator.pop(context);
      },
    ).show();
  }

  String searchKey = "";
  List<Map<String, dynamic>>? newList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!mounted) return;
    date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    s = date!.split(" ");
    shared();
    appBarTitle = Text("");

    print(
        "zxzx--${Provider.of<RegistrationController>(context, listen: false).scheduleListCount}");
    Provider.of<Controller>(context, listen: false).getArea(context);
    Provider.of<RegistrationController>(context, listen: false).userDetails();
    Provider.of<QuotationController>(context, listen: false)
        .getQuotationList(context);
    Provider.of<Controller>(context, listen: false).gePriorityList(context);
    Provider.of<ProductController>(context, listen: false)
        .geProductList(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(
          "kjfs---${Provider.of<RegistrationController>(context, listen: false).scheduleOpend}");
      if (Provider.of<RegistrationController>(context, listen: false)
                  .scheduleListCount >
              0 &&
          Provider.of<RegistrationController>(context, listen: false)
                  .scheduleOpend ==
              false) {
        customNotification();
      }
    });
  }

  bool visible = false;

  void togle() {
    setState(() {
      visible = !visible;
    });
  }

  onChangedValue(String value) {
    print("value inside function ---${value}");
    setState(() {
      searchKey = value;
      // if (value.isEmpty) {
      //   Provider.of<Controller>(context, listen: false).setIssearch(false);
      //   _controller.clear();
      // } else {
      //   Provider.of<Controller>(context, listen: false).setIssearch(true);
      //   // _controller.clear();
      //   newList = Provider.of<Controller>(context, listen: false)
      //       .productList!
      //       .where((code) => code["product_code"]
      //           .toUpperCase()
      //           .startsWith(value.toUpperCase()))
      //       .toList();
      // }
    });
  }

  _onSelectItem(String? menu) {
    if (!mounted) return;
    print("menu----$menu");
    if (this.mounted) {
      setState(() {
        Provider.of<RegistrationController>(context, listen: false).menu_index =
            menu!;
      });
    }
    Navigator.of(context).pop(); // close the drawer
  }

  _getDrawerItemWidget(String? pos) {
    print("pos---${pos}");

    switch (pos) {
      case "D1":
        {
          print("d111----");
          Provider.of<Controller>(context, listen: false)
              .getDashboardValues(context);

          return ExecutiveDashBoard();
        }
      case "E1":
        {
          // Provider.of<Controller>(context, listen: false)
          //     .gePriorityList(context);
          // Provider.of<ProductController>(context, listen: false)
          //     .geProductList(context);
          return EnquiryScreen();
        }
      case "E2":
        {
          Provider.of<ProductController>(context, listen: false)
              .getEnqhistoryData(
            context,
            "",
          );
          return EnQHistory();
        }

      case "Q1":
        {
          Provider.of<QuotationController>(context, listen: false)
              .getQuotationList(
            context,
          );

          return QuotatationListScreen();
        }
      case "SL1":
        {
          // Provider.of<RegistrationController>(context, listen: false)
          //     .getScheduleList(
          //   context,
          // );
          return ScheduleListScreen(
            type: "from menu",
          );
        }

      case "DS":
        {
          Provider.of<Controller>(context, listen: false)
              .getServiceDashboardValues(context);
          return ServiceDashboard();
        }

      case "SR":
        {
          print("srghhh");
          Provider.of<RegistrationController>(context, listen: false)
              .getServiceScheduleList(
            context,"from menu"
          );
          return ServiceScheduleList(type: "from menu");
        }

      // case "logout":
      //   logout();
    }
  }

  shared() async {
    final prefs = await SharedPreferences.getInstance();
    mobile_user_type = prefs.getString("mobile_user_type");
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('st_username');
    await prefs.remove('st_pwd');
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (mobile_user_type == "1") {
      if (widget.type == "return from quataion" ||
          widget.type == "from scheduleList") {
        print("from cart");
        if (val) {
          Provider.of<RegistrationController>(context, listen: false)
              .menu_index = "D1";
          val = false;
        }
      }
    } else if (mobile_user_type == "2") {
      if (widget.type == "from service scheduleList") {
        if (val) {
          Provider.of<RegistrationController>(context, listen: false)
              .menu_index = "DS";
          val = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    drawerOpts.clear();
    for (var i = 0;
        i <
            Provider.of<RegistrationController>(context, listen: false)
                .menuList
                .length;
        i++) {
      // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];

      drawerOpts.add(Consumer<RegistrationController>(
        builder: (context, value, child) {
          // print(
          //     "menulist[menu]-------${value.menuList[i]["menu_name"]}");
          return Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 10, bottom: 0),
            child: InkWell(
              onTap: () {
                _onSelectItem(value.menuList[i]["menu_index"]);
              },
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon(
                      //   Icons.history,
                      //   // color: Colors.red,
                      // ),
                      Container(
                        child: Text(
                          value.menuList[i]["menu_name"],
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        "assets/right.png",
                        height: 28,
                        color: Colors.grey[700],
                      )
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        },
      ));
    }
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 250, 248, 248),
        key: _key,
        appBar: Provider.of<RegistrationController>(context, listen: false)
                        .menu_index ==
                    "D1" ||
                Provider.of<RegistrationController>(context, listen: false)
                        .menu_index ==
                    "DS"
            ? AppBar(
                title: appBarTitle,
                backgroundColor: P_Settings.loginPagetheme,
                elevation: 0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(),
                ),
                actions: [
                  Provider.of<RegistrationController>(context, listen: false)
                              .menu_index ==
                          "DS"
                      ? Container()
                      : IconButton(
                          icon: actionIcon,
                          onPressed: () {
                            // togle();
                            togle();
                            // setState(() {
                            if (this.actionIcon.icon == Icons.search) {
                              _controller.clear();
                              this.actionIcon = Icon(Icons.close);
                              this.appBarTitle = SearchAutoComplete();

                              // TextField(
                              //     controller: _controller,
                              //     style: new TextStyle(
                              //       color: Colors.white,
                              //     ),
                              //     decoration: InputDecoration(
                              //       prefixIcon:
                              //           Icon(Icons.search, color: Colors.white),
                              //       hintText: "Search...cxzcxzxz",
                              //       hintStyle: TextStyle(color: Colors.white),
                              //     ),
                              //     onChanged: ((value) {
                              //       // print(value);
                              //       onChangedValue(value);
                              //     }),
                              //     cursorColor: Colors.black);
                            } else {
                              if (this.actionIcon.icon == Icons.close) {
                                this.actionIcon = Icon(Icons.search);
                                this.appBarTitle = Text("");
                                // Provider.of<Controller>(context, listen: false)
                                //     .setIssearch(false);
                              }
                            }
                            // });
                          },
                        ),
                  Visibility(
                    visible: visible,
                    child: IconButton(
                        onPressed: () {
                          togle();
                          this.actionIcon = Icon(Icons.search);
                          this.appBarTitle = Text("");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuotationStatusMonitoring(
                                  title: Provider.of<Controller>(context,
                                          listen: false)
                                      .searchQotSelected
                                      .toString()),
                            ),
                          );
                          // // setState(() {
                          // //   isSearch = true;
                          // // });
                          // Provider.of<Controller>(context, listen: false)
                          //     .productDetails(
                          //         _controller.text, "0", "0", context, "1");
                          // if (Provider.of<Controller>(context, listen: false)
                          //         .isSearch ==
                          //     true) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ProductDetails(
                          //           // itemName: Provider.of<Controller>(context, listen: false).productList![index]["cat_name"],
                          //           // colorid: Provider.of<Controller>(context, listen: false).productList![index]["color_ids"],
                          //           ),
                          //     ),
                          //   );
                          // }
                        },
                        icon: Icon(Icons.done)),
                  )
                ],
              )
            : AppBar(
                actions: [
                  // Provider.of<RegistrationController>(context, listen: false)
                  //                 .menu_index ==
                  //             "E2" ||
                  //         Provider.of<RegistrationController>(context,
                  //                     listen: false)
                  //                 .menu_index ==
                  //             "Q1"
                  //     ? Container()
                  //     : Container(
                  //         margin: EdgeInsets.only(right: 8),
                  //         child: InkWell(
                  //             onTap: () {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) => EnQHistory()),
                  //               );
                  //             },
                  //             child: Icon(
                  //               Icons.history,
                  //               size: 20,
                  //               color: Colors.red,
                  //             )),
                  //       ),
                  Provider.of<RegistrationController>(context, listen: false)
                                  .menu_index ==
                              "E2" ||
                          Provider.of<RegistrationController>(context,
                                      listen: false)
                                  .menu_index ==
                              "Q1" ||
                          Provider.of<RegistrationController>(context,
                                      listen: false)
                                  .menu_index ==
                              "SL1" ||
                          Provider.of<RegistrationController>(context,
                                      listen: false)
                                  .menu_index ==
                              "DS" ||
                          Provider.of<RegistrationController>(context,
                                      listen: false)
                                  .menu_index ==
                              "SR"
                      ? Container()
                      : InkWell(
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
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800]),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                ],
                title: Text(
                  Provider.of<RegistrationController>(context, listen: false)
                              .menu_index ==
                          "Q1"
                      ? "QUOTATION LIST"
                      : Provider.of<RegistrationController>(context,
                                      listen: false)
                                  .menu_index ==
                              "E2"
                          ? "ENQUIRY LIST"
                          : Provider.of<RegistrationController>(context,
                                          listen: false)
                                      .menu_index ==
                                  "E1"
                              ? "ENQUIRY"
                              : Provider.of<RegistrationController>(context,
                                              listen: false)
                                          .menu_index ==
                                      "SL1"
                                  ? "SCHEDULE LIST"
                                  : Provider.of<RegistrationController>(context,
                                                  listen: false)
                                              .menu_index ==
                                          "SR"
                                      ? " SERVICE SCHEDULE LIST"
                                      : "",
                  style: TextStyle(fontSize: 15),
                ),
                backgroundColor:
                    Provider.of<RegistrationController>(context, listen: false)
                                    .menu_index ==
                                "E2" ||
                            Provider.of<RegistrationController>(context,
                                        listen: false)
                                    .menu_index ==
                                "Q1" ||
                            Provider.of<RegistrationController>(context,
                                        listen: false)
                                    .menu_index ==
                                "SL1"|| Provider.of<RegistrationController>(context,
                                        listen: false)
                                    .menu_index ==
                                "SR"
                        ? P_Settings.loginPagetheme
                        : P_Settings.whiteColor,
                elevation: 1,
                leading: Consumer<RegistrationController>(
                  builder: (context, value, child) {
                    return IconButton(
                        onPressed: () {
                          _key.currentState!.openDrawer();
                        },
                        icon: Icon(Icons.menu,
                            color: value.menu_index == "E2" ||
                                    value.menu_index == "Q1" ||
                                    value.menu_index == "SL1" ||value.menu_index=="SR"
                                ? P_Settings.whiteColor
                                : Colors.grey[800]));
                  },
                ),
                // leading: Builder(
                //   builder: (context) => Consumer<RegistrationController>(
                //     builder: (context, value, child) {
                //       return IconButton(
                //           icon: new Icon(Icons.menu,
                //               color: value.menu_index == "E2" ||
                //                       value.menu_index == "Q1"
                //                   ? P_Settings.whiteColor
                //                   : Colors.grey[800]),
                //           onPressed: () async {
                //             SharedPreferences prefs =
                //                 await SharedPreferences.getInstance();
                //             staffName = await prefs.getString("staff_name");
                //             drawerOpts.clear();
                //             for (var i = 0; i < value.menuList.length; i++) {
                //               // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];

                //               drawerOpts.add(Consumer<RegistrationController>(
                //                 builder: (context, value, child) {
                //                   // print(
                //                   //     "menulist[menu]-------${value.menuList[i]["menu_name"]}");
                //                   return Padding(
                //                     padding: const EdgeInsets.only(
                //                         left: 8.0,
                //                         right: 8,
                //                         top: 10,
                //                         bottom: 0),
                //                     child: InkWell(
                //                       onTap: () {
                //                         _onSelectItem(
                //                             value.menuList[i]["menu_index"]);
                //                       },
                //                       child: Column(
                //                         children: [
                //                           Row(
                //                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                             children: [
                //                               // Icon(
                //                               //   Icons.history,
                //                               //   // color: Colors.red,
                //                               // ),
                //                               Container(
                //                                 child: Text(
                //                                   value.menuList[i]
                //                                       ["menu_name"],
                //                                   style: TextStyle(
                //                                       fontWeight:
                //                                           FontWeight.w500,
                //                                       fontSize: 17),
                //                                 ),
                //                               ),
                //                               Spacer(),
                //                               Image.asset(
                //                                 "assets/right.png",
                //                                 height: 28,
                //                                 color: Colors.grey[700],
                //                               )
                //                             ],
                //                           ),
                //                           Divider(),
                //                         ],
                //                       ),
                //                     ),
                //                   );
                //                 },
                //               ));
                //             }
                //             _key.currentState!.openDrawer();
                //           });
                //     },
                //   ),
                // ),
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
                          height: size.height * 0.035,
                        ),
                        Container(
                          width: double.infinity,
                          height: size.height * 0.17,
                          child: DrawerHeader(
                              decoration: BoxDecoration(
                                color: P_Settings.loginPagetheme,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage("assets/man.png"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      Provider.of<RegistrationController>(
                                              context,
                                              listen: false)
                                          .staff_name
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     _onSelectItem("dash");
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //         left: 8.0, right: 8, top: 8),
                        //     child: Row(
                        //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Container(
                        //           // margin: EdgeInsets.only(left: 10),
                        //           child: Text(
                        //             "Dashboard",
                        //             style: TextStyle(
                        //                 fontWeight: FontWeight.w500,
                        //                 fontSize: 17),
                        //           ),
                        //         ),
                        //         Spacer(),
                        //         Image.asset("assets/right.png",
                        //             height: 28, color: Colors.grey[700])
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Divider(),
                        Column(children: drawerOpts),
                        InkWell(
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.remove('st_username');
                            await prefs.remove('st_pwd');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, top: 8),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.logout),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ),
                                Spacer(),
                                Image.asset("assets/right.png",
                                    height: 28, color: Colors.grey[700])
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
        body: _getDrawerItemWidget(
            Provider.of<RegistrationController>(context, listen: false)
                .menu_index),
      ),
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
                                value: item["area_id"],
                                child: Container(
                                  width: size.width * 0.4,
                                  child: Text(
                                    item["area_name"],
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

  Future<bool> _onBackPressed(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to exit from this app'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }
}
