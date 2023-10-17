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
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EnquiryScreen extends StatefulWidget {
  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen>
    with SingleTickerProviderStateMixin {
  // Duration? animationDuration;
  CustomerPopup cusPopup = CustomerPopup();
  TextEditingController search = TextEditingController();
  NewItemSheet itemBottom = NewItemSheet();
  AnimationController? _animationController;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
    Provider.of<ProductController>(context, listen: false)
        .geProductList(context);
    super.initState();
    print('enqnnmn----');
  }

////////////////////////////////////////////////////////////////
  // void _onRefresh() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   Provider.of<ProductController>(context, listen: false)
  //       .geProductList(context);
  //   _refreshController.refreshCompleted();
  // }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
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
                    .getbagData(
                        context,
                        "0",
                        Provider.of<Controller>(context, listen: false)
                            .dupcustomer_id!);
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
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      value.customer_id == null
                          ? Container()
                          : badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                  // badgeGradient: badges.BadgeGradient.radial(colors: Colors.primaries),
                                  shape: badges.BadgeShape.circle,
                                  badgeColor: Colors.red),
                              position: badges.BadgePosition.topEnd(
                                  top: -10, end: -22),
                              badgeContent: value.isCartLoading ||
                                      value.customer_id == null ||
                                      value.cartCount == null ||
                                      Provider.of<Controller>(context,
                                                  listen: false)
                                              .dupcustomer_id ==
                                          null
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
        // physics: ClampingScrollPhysics(),
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
                            ? "Select Customer"
                            : "Customer Details",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (value.selected == null) {
                            // _showCustomFlash();
                          } else {
                            Provider.of<Controller>(context, listen: false)
                                .setSelectedCustomer(false);
                            value.dropSelected = null;
                            cusPopup.buildcusPopupDialog(
                              context,
                              MediaQuery.of(context).size,
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
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: SpinKitCircle(
                          color: P_Settings.loginPagetheme,
                        ),
                      )
                    : value.customer_id == null
                        ? Container()
                        : customerData(MediaQuery.of(context).size),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.045,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: P_Settings.loginPagetheme),
                                    onPressed: value.adddNewItem
                                        ? () {
                                            itemBottom.showNewItemSheet(
                                                context, value.val.toString());
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
                                height:
                                    MediaQuery.of(context).size.height * 0.045,
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
                                        print("haiiiiii");
                                        Provider.of<ProductController>(context,
                                                listen: false)
                                            .adddNewItem = false;
                                        Provider.of<ProductController>(context,
                                                listen: false)
                                            .setIssearch(false);
                                        Provider.of<ProductController>(context,
                                                listen: false)
                                            .geProductList(context);
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
                      return SearchedProductList(
                        type: "",
                        cInfo: "",
                        cid: "",
                        com: "",
                        contactNum: "",
                        land: "",
                        owner: "",
                        pin: "",
                        prio: "",
                        cus_id: "",
                        area: "",
                        enq_id: "",
                        rwId: "",
                      );
                    } else {
                      return ProductListPage(
                        type: "",
                        cInfo: "",
                        cid: "",
                        com: "",
                        contactNum: "",
                        land: "",
                        owner: "",
                        pin: "",
                        prio: "",
                        cus_id: "",
                        area: "",
                        enq_id: "",
                        rwId: "",
                      );
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

  //////////////////////////////////////////////////////////////////////
  // Widget customerData(Size size) {
  //   return Consumer<Controller>(
  //     builder: (context, value, child) {
  //       Provider.of<ProductController>(context, listen: false)
  //           .getbagData(context, "0", value.dupcustomer_id!);
  //       return Card(
  //         // margin: EdgeInsets.only(top: 10, right: 16),
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 8.0, bottom: 8),
  //           child: ListTile(
  //             title: Row(
  //               children: [
  //                 Column(
  //                   children: [
  //                     Icon(
  //                       Icons.person,
  //                       size: 20,
  //                       color: Colors.orange,
  //                     ),
  //                     Icon(
  //                       Icons.phone,
  //                       size: 20,
  //                       color: Colors.pink,
  //                     ),
  //                     // Image.asset(
  //                     //   "assets/man.png",
  //                     //   height: size.height * 0.06,
  //                     // ),
  //                     // SizedBox(
  //                     //   height: size.height * 0.005,
  //                     // ),
  //                     value.address == null || value.address!.isEmpty
  //                         ? Container()
  //                         : Icon(
  //                             Icons.business,
  //                             size: 20,
  //                             color: Colors.green,
  //                           ),
  //                     value.landmark == null || value.landmark!.isEmpty
  //                         ? Container()
  //                         : Icon(
  //                             Icons.place,
  //                             size: 20,
  //                             color: Colors.red,
  //                           ),
  //                     value.owner_name == null || value.owner_name!.isEmpty
  //                         ? Container()
  //                         : Icon(
  //                             Icons.person,
  //                             size: 20,
  //                             color: Colors.blue,
  //                           ),
  //                     // Text(
  //                     //   "Contact Info :",
  //                     //   // value.customerName.toString().toUpperCase(),
  //                     //   overflow: TextOverflow.ellipsis,
  //                     //   // value.customerName.toString(),
  //                     //   style: TextStyle(
  //                     //       color: Colors.grey[800],
  //                     //       fontWeight: FontWeight.w500),
  //                     // ),
  //                   ],
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(left: 10),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         width: size.width * 0.7,
  //                         child: Flexible(
  //                           child: Text(
  //                             // "Anusha k ghajkkxgvxvzvzvvzvFzFZg",
  //                             value.customerName.toString().toUpperCase(),
  //                             overflow: TextOverflow.ellipsis,
  //                             // value.customerName.toString(),
  //                             style: TextStyle(
  //                                 color: Colors.grey[800],
  //                                 fontSize: 14,
  //                                 fontWeight: FontWeight.w500),
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: size.width * 0.7,
  //                         child: Flexible(
  //                           child: Text(
  //                             value.customerPhone.toString(),
  //                             style: TextStyle(
  //                                 color: Colors.grey[800],
  //                                 fontSize: 14,
  //                                 fontWeight: FontWeight.w500),
  //                           ),
  //                         ),
  //                       ),
  //                       // SizedBox(
  //                       //   height: size.height * 0.005,
  //                       // ),
  //                       value.address == null || value.address!.isEmpty
  //                           ? Container()
  //                           : Container(
  //                               width: size.width * 0.7,
  //                               child: Flexible(
  //                                 child: Text(
  //                                   value.address.toString().toUpperCase(),
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: TextStyle(
  //                                       fontSize: 14,
  //                                       color: Colors.grey[800],
  //                                       fontWeight: FontWeight.w500),
  //                                 ),
  //                               ),
  //                             ),
  //                       value.landmark == null || value.landmark!.isEmpty
  //                           ? Container()
  //                           : Container(
  //                               width: size.width * 0.7,
  //                               child: Flexible(
  //                                 child: Text(
  //                                   value.landmark.toString().toUpperCase(),
  //                                   style: TextStyle(
  //                                       fontSize: 14,
  //                                       color: Colors.grey[800],
  //                                       fontWeight: FontWeight.w500),
  //                                 ),
  //                               ),
  //                             ),
  //                       value.owner_name == null || value.owner_name!.isEmpty
  //                           ? Container()
  //                           : Container(
  //                               width: size.width * 0.7,
  //                               child: Flexible(
  //                                 child: Text(
  //                                   value.owner_name.toString().toUpperCase(),
  //                                   style: TextStyle(
  //                                       fontSize: 14,
  //                                       color: Colors.grey[800],
  //                                       fontWeight: FontWeight.w500),
  //                                 ),
  //                               ),
  //                             ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

///////////////////////////////////////////////////////////////////////////
  Widget customerData(Size size) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        print("valueknjk-----${value.dupcustomer_id}");
        Provider.of<ProductController>(context, listen: false)
            .getbagData(context, "0", value.dupcustomer_id!);
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
              shape: RoundedRectangleBorder(
                // side: BorderSide(
                //     color: P_Settings.loginPagetheme),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/man.png",
                              height: size.height * 0.09,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.customerName.toString().toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(value.customerPhone.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          // width: size.width*0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              value.address == null || value.address!.isEmpty
                                  ? Container()
                                  : Icon(Icons.business,
                                      color: Colors.orange, size: 13),
                              value.landmark == null || value.landmark!.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Icon(Icons.place,
                                          color: Colors.red, size: 13),
                                    ),
                              value.owner_name == null ||
                                      value.owner_name!.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Icon(Icons.person,
                                          color: Colors.blue, size: 13),
                                    )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 4),
                          width: size.width * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              value.address == null || value.address!.isEmpty
                                  ? Container()
                                  : Text(
                                      "Customer Info     ",
                                      style: TextStyle(fontSize: 13),
                                    ),
                              value.landmark == null || value.landmark!.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Landmark   ",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                              value.owner_name == null ||
                                      value.owner_name!.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Contact  Person ",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              value.address == null || value.address!.isEmpty
                                  ? Container()
                                  : Text(
                                      // "skjfkjdfkldfjlkdxfjkldxfjlkxdjflkxdfjjjjjjjjjjjjjjjjjjjjjjcxc",
                                      value.address.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13)),
                              value.landmark == null || value.landmark!.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(value.landmark.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13)),
                                    ),
                              value.owner_name == null ||
                                      value.owner_name!.isEmpty
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(value.owner_name.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13)),
                                    ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
    }
//   void _showCustomFlash({FlashBehavior style = FlashBehavior.fixed}) {
//     showFlash(
//       context: context,
//       duration: const Duration(seconds: 3),
//       persistent: true,
//       builder: (_, controller) {
//         return Flash(
//           controller: controller,
//           barrierDismissible: true,
//           behavior: style,
//           position: FlashPosition.top,
//           backgroundGradient: LinearGradient(
//             colors: [P_Settings.loginPagetheme, P_Settings.fillcolor],
//           ),
//           child: FlashBar(
//             // title: Text('Hey User!'),
//             content: Text(
//               'Please Choose an Area',
//               style: TextStyle(color: Colors.white, fontSize: 15),
//             ),
//             primaryAction: TextButton(
//               onPressed: () {},
//               child: Text('DISMISS', style: TextStyle(color: Colors.white)),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
