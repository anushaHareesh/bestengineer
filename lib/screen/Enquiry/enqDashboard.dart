import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/screen/Enquiry/SerchedProductList.dart';
import 'package:bestengineer/screen/Enquiry/enqcart.dart';
import 'package:bestengineer/screen/Enquiry/productList.dart';
import 'package:bestengineer/widgets/alertCommon/customerPopup.dart';
import 'package:bestengineer/widgets/bottomsheets/newItemSheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../widgets/alertCommon/itemSelectionAlert.dart';
import '../../widgets/bottomsheets/itemSelectionSheet.dart';

class EnqDashboard extends StatefulWidget {
  @override
  State<EnqDashboard> createState() => _EnqDashboardState();
}

class _EnqDashboardState extends State<EnqDashboard> {
  // ItemSelectionAlert itempopup = ItemSelectionAlert();
  CustomerPopup cusPopup = CustomerPopup();
  TextEditingController search = TextEditingController();
  NewItemSheet itemBottom = NewItemSheet();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
                      "Customer Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<Controller>(context, listen: false)
                            .setSelectedCustomer(false);

                        cusPopup.buildcusPopupDialog(
                          context,
                          size,
                        );
                      },
                      child: Icon(
                        Icons.ads_click,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              customerData(size),
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
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                                    style: TextStyle(fontSize: 18),
                                  )),
                            );
                          },
                        ),
                        Container(
                            width: size.width * 0.65,
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
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.close),
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
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(8)),
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
                              "Products List",
                              style: TextStyle(
                                  fontSize: 20,
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
              // : ListTile(
              //     title: Column(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Products List",
              //               style: TextStyle(
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.bold,
              //                   color: P_Settings.loginPagetheme),
              //             ),

              //             // IconButton(
              //             //     onPressed: () {
              //             //       Navigator.push(
              //             //         context,
              //             //         MaterialPageRoute(
              //             //             builder: (context) => EnqCart()),
              //             //       );
              //             //     },
              //             //     icon: Icon(
              //             //       Icons.shopping_cart,
              //             //       color: Colors.red,
              //             //     ))
              //           ],
              //         ),
              //         // Divider(
              //         //   thickness: 1,
              //         //   indent: 40,
              //         //   endIndent: 40,
              //         // )
              //       ],
              //     ),
              //   ),

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
    );
  }

  Widget customerData(Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.only(left: 20, right: 16),
            child: ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, top: 8, bottom: 8),
                            child: Row(
                              children: [
                                // Text(
                                //   "Customer Name",
                                //   style: TextStyle(
                                //     color: Colors.grey[500], fontSize: 14),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Container(
                                    width: size.width * 0.7,
                                    child: Text("Anusha K"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                // Text(
                                //   "Customer Info",
                                //   style: TextStyle(
                                //       color: Colors.grey[500], fontSize: 14),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 26.0),
                                  child: Text(
                                    "Thottada Kannur",
                                    style: TextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Row(
                              children: [
                                // Text(
                                //   "Phone number",
                                //   style: TextStyle(
                                //       color: Colors.grey[500], fontSize: 14),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 26.0),
                                  child: Text(
                                    "9061259261",
                                    style: TextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Row(
                              children: [
                                // Text(
                                //   "Landmark",
                                //   style: TextStyle(
                                //       color: Colors.grey[500], fontSize: 14),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 26.0),
                                  child: Text(
                                    "Near Chemmanur",
                                    style: TextStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                          )
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 8.0, top: 8),
                          //   child: Row(
                          //     children: [
                          //       // Text(
                          //       //   "Priority",
                          //       //   style: TextStyle(
                          //       //       color: Colors.grey[500], fontSize: 14),
                          //       // ),
                          //       Padding(
                          //         padding: const EdgeInsets.only(left: 26.0),
                          //         child: Text(
                          //           "1",
                          //           style: TextStyle(),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                  Row()
                ],
              ),
            ),
          ),
          Positioned(
              top: 39,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/man.png"),
                backgroundColor: Colors.transparent,
                radius: 30,
                // child: Icon(
                //   Icons.person,
                // ),
              )),
        ],
      ),
    );
  }
}
