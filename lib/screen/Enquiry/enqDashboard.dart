import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/customSnackbar.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/screen/Enquiry/SerchedProductList.dart';
import 'package:bestengineer/screen/Enquiry/enqcart.dart';
import 'package:bestengineer/screen/Enquiry/productList.dart';
import 'package:bestengineer/widgets/alertCommon/customerPopup.dart';
import 'package:bestengineer/widgets/bottomsheets/newItemSheet.dart';
import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../widgets/alertCommon/itemSelectionAlert.dart';
import '../../widgets/bottomsheets/itemSelectionSheet.dart';

class EnqDashboard extends StatefulWidget {
  @override
  State<EnqDashboard> createState() => _EnqDashboardState();
}

class _EnqDashboardState extends State<EnqDashboard>
    with SingleTickerProviderStateMixin {
  // Duration? animationDuration;
  CustomerPopup cusPopup = CustomerPopup();
  TextEditingController search = TextEditingController();
  NewItemSheet itemBottom = NewItemSheet();
  AnimationController? _animationController;
  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SizedBox(
          height: 50,
          child: InkWell(
            onTap: () {
              if (Provider.of<Controller>(context, listen: false).customer_id ==
                  null) {
                CustomSnackbar snackbar = CustomSnackbar();
                snackbar.showSnackbar(context, "Please Choose a Customer", "");
              } else {
                Provider.of<ProductController>(context, listen: false)
                    .getbagData(context, "0");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnqCart()),
                );
              }
            },
            child: Container(
              color: P_Settings.loginPagetheme,
              child: Consumer<ProductController>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "View Data",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.whiteColor),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                              // badgeGradient: badges.BadgeGradient.radial(colors: Colors.primaries),
                              shape: badges.BadgeShape.circle,
                              badgeColor: Colors.red),
                          position:
                              badges.BadgePosition.topEnd(top: -10, end: -22),
                          badgeContent:
                              value.isCartLoading || value.customer_id == null
                                  ? SpinKitChasingDots(
                                      color: P_Settings.loginPagetheme,
                                      size: 8,
                                    )
                                  : Text(
                                      value.cartCount.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ))
                    ],
                  );
                },
              ),
            ),
          )),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Consumer<Controller>(
          builder: (context, value, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16, right: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        value.customer_id == null
                            ? "Add Customer"
                            : "Customer Details",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (value.selected == null) {
                            _showCustomFlash();
                          } else {
                            Provider.of<Controller>(context, listen: false)
                                .setSelectedCustomer(false);
                            value.dropSelected = null;
                            cusPopup.buildcusPopupDialog(
                              context,
                              size,
                            );
                          }
                        },
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: P_Settings.loginPagetheme,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        // child: Image.asset(
                        //   "assets/plus.png",
                        //   height: size.height * 0.035,
                        // ),
                        // child: Icon(Icons.add,
                        //     size: 29, color: P_Settings.loginPagetheme),
                      ),
                      // FadeTransition(
                      //   opacity: _animationController!,
                      //   child: InkWell(
                      //     onTap: () {
                      //       Provider.of<Controller>(context, listen: false)
                      //           .setSelectedCustomer(false);
                      //       value.dropSelected = null;
                      //       cusPopup.buildcusPopupDialog(
                      //         context,
                      //         size,
                      //       );
                      //     },
                      //     child: Icon(Icons.add,size: 29,
                      //         color: P_Settings.loginPagetheme),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                value.isSavecustomer
                    ? Container(
                        height: size.height * 0.14,
                        child: SpinKitCircle(
                          color: P_Settings.loginPagetheme,
                        ),
                      )
                    : value.customer_id == null
                        ? Container()
                        : customerData(size),
                // ListTile(
                //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                //   trailing: Icon(
                //     Icons.ads_click,
                //     color: Colors.green,
                //   ),
                //   onTap: () {
                //     Provider.of<Controller>(context, listen: false)
                //         .setSelectedCustomer(false);
                //     Provider.of<Controller>(context, listen: false)
                //         .searchCustomerList(context);
                //     cusPopup.buildcusPopupDialog(context, size);
                //   },
                //   title: Text(
                //     "Customer Details",
                //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //   ),
                // ),
                Padding(padding: EdgeInsets.all(8)),

                ListTile(
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Product Details",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<ProductController>(
                            builder: (context, value, child) {
                              return Container(
                                height: size.height * 0.045,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: P_Settings.loginPagetheme),
                                    onPressed: value.adddNewItem
                                        ? () {
                                            itemBottom.showNewItemSheet(
                                              context,
                                            );
                                          }
                                        : null,
                                    child: Text(
                                      "New Item",
                                      style: TextStyle(fontSize: 15),
                                    )),
                              );
                            },
                          ),
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 6),
                                // width: size.width * 0.68,
                                height: size.height * 0.045,
                                child: TextField(
                                  controller: search,
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
                                        search.clear();
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(4)),
                // Text(
                //     "${Provider.of<ProductController>(context, listen: false).isSearch}"),
                // Text(
                //     "${Provider.of<ProductController>(context, listen: false).newList.length}"),
                Consumer<ProductController>(
                  builder: (context, value, child) {
                    if (value.isSearch && value.newList.length == 0) {
                      return Container();
                    } else {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Product  List",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme),
                              ),
                            ],
                          ),
                          // Divider(indent: 30,endIndent:30,thickness: 1,)
                        ],
                      );
                    }
                  },
                ),
                Padding(padding: EdgeInsets.all(3)),

                Consumer<ProductController>(
                  builder: (context, value, child) {
                    if (value.isSearch) {
                      return SearchedProductList();
                    } else {
                      return ProductListPage();
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget customerData(Size size) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return Card(
          // margin: EdgeInsets.only(left: 0, right: 16),
          child: ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 18,
                                color: Colors.blue,
                              ),
                              // Text(
                              //   "Name",
                              //   style: TextStyle(
                              //       color: Colors.grey[500], fontSize: 14),
                              // ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                width: size.width * 0.6,
                                child: Text(
                                  value.customerName.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  // value.customerName.toString(),
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        value.address == null || value.address!.isEmpty
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.business,
                                      size: 18,
                                      color: Colors.green,
                                    ),
                                    // Text(
                                    //   "Info",
                                    //   style: TextStyle(
                                    //       color: Colors.grey[500], fontSize: 14),
                                    // ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      width: size.width * 0.6,
                                      child: Text(
                                        value.address.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 18,
                                color: Colors.orange,
                              ),
                              // Text(
                              //   "Phone",
                              //   style: TextStyle(
                              //       color: Colors.grey[500], fontSize: 14),
                              // ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text(
                                  value.customerPhone.toString(),
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        value.landmark == null || value.landmark!.isEmpty
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.place,
                                      size: 18,
                                      color: Colors.red,
                                    ),
                                    // Text(
                                    //   "Landmark",
                                    //   style: TextStyle(
                                    //       color: Colors.grey[500], fontSize: 14),
                                    // ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(
                                        value.landmark.toString(),
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget customerData(Size size) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8.0),
  //     child: Consumer<Controller>(
  //       builder: (context, value, child) {
  //         return Stack(
  //           children: [
  //             Card(
  //               margin: EdgeInsets.only(left: 0, right: 16),
  //               child: ListTile(
  //                 title: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.only(
  //                                   left: 0, top: 8, bottom: 8),
  //                               child: Row(
  //                                 children: [
  //                                   Text(
  //                                     "Customer Name",
  //                                     style: TextStyle(
  //                                         color: Colors.grey[500],
  //                                         fontSize: 14),
  //                                   ),
  //                                   Padding(
  //                                     padding: const EdgeInsets.only(left: 0),
  //                                     child: Container(
  //                                       width: size.width * 0.7,
  //                                       child: Text(
  //                                         value.customerName.toString(),
  //                                         style: TextStyle(
  //                                             color: Colors.grey[700],
  //                                             fontWeight: FontWeight.w500),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(left: 8.0),
  //                               child: Row(
  //                                 children: [
  //                                   Text(
  //                                     "Customer Info",
  //                                     style: TextStyle(
  //                                         color: Colors.grey[500],
  //                                         fontSize: 14),
  //                                   ),
  //                                   Padding(
  //                                     padding: const EdgeInsets.only(left: 0),
  //                                     child: Text(
  //                                       value.address.toString(),
  //                                       style: TextStyle(
  //                                           color: Colors.grey[700],
  //                                           fontWeight: FontWeight.w500),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding:
  //                                   const EdgeInsets.only(left: 8.0, top: 8),
  //                               child: Row(
  //                                 children: [
  //                                   Text(
  //                                     "Phone number",
  //                                     style: TextStyle(
  //                                         color: Colors.grey[500],
  //                                         fontSize: 14),
  //                                   ),
  //                                   Padding(
  //                                     padding: const EdgeInsets.only(left: 0),
  //                                     child: Text(
  //                                       value.customerPhone.toString(),
  //                                       style: TextStyle(
  //                                           color: Colors.grey[700],
  //                                           fontWeight: FontWeight.w500),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding:
  //                                   const EdgeInsets.only(left: 8.0, top: 8),
  //                               child: Row(
  //                                 children: [
  //                                   Text(
  //                                     "Landmark",
  //                                     style: TextStyle(
  //                                         color: Colors.grey[500],
  //                                         fontSize: 14),
  //                                   ),
  //                                   Padding(
  //                                     padding: const EdgeInsets.only(left: 0),
  //                                     child: Text(
  //                                       value.landmark.toString(),
  //                                       style: TextStyle(
  //                                           color: Colors.grey[700],
  //                                           fontWeight: FontWeight.w500),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.all(8),
  //                             )
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                     Row()
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             // Positioned(
  //             //     top: 32,
  //             //     child: CircleAvatar(
  //             //       backgroundImage: AssetImage("assets/man.png"),
  //             //       backgroundColor: Colors.transparent,
  //             //       radius: 30,
  //             //       // child: Icon(
  //             //       //   Icons.person,
  //             //       // ),
  //             //     )),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  void _showCustomFlash({FlashBehavior style = FlashBehavior.fixed}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          // backgroundColor: Colors.white,
          // brightness: Brightness.light,
          // barrierColor: Colors.black38,
          barrierDismissible: true,
          behavior: style,
          position: FlashPosition.top,
          backgroundGradient: LinearGradient(
            colors: [P_Settings.loginPagetheme, P_Settings.fillcolor],
          ),
          child: FlashBar(
            // title: Text('Hey User!'),
            content: Text('Please Choose an Area',style: TextStyle(color: Colors.white,fontSize: 15),),
            primaryAction: TextButton(
              onPressed: () {},
              child: Text('DISMISS',
                          style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    );
  }
}
