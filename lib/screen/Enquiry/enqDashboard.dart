import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/screen/Enquiry/SerchedProductList.dart';
import 'package:bestengineer/screen/Enquiry/productList.dart';
import 'package:bestengineer/widgets/alertCommon/customerPopup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/alertCommon/itemSelectionAlert.dart';

class EnqDashboard extends StatefulWidget {
  const EnqDashboard({super.key});

  @override
  State<EnqDashboard> createState() => _EnqDashboardState();
}

class _EnqDashboardState extends State<EnqDashboard> {
  ItemSelectionAlert itempopup = ItemSelectionAlert();
  CustomerPopup cusPopup = CustomerPopup();
  TextEditingController search = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).getProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  Provider.of<Controller>(context, listen: false)
                      .setSelectedCustomer(false);
                  Provider.of<Controller>(context, listen: false)
                      .searchCustomerList(context);
                  cusPopup.buildcusPopupDialog(context, size);
                },
                title: Text("Customer Details"),
              ),
              Padding(padding: EdgeInsets.all(8)),
              ListTile(
                onTap: () {
                  itempopup.buildPopupDialog(
                    context,
                  );
                },
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Product Details"),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: size.height * 0.045,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: P_Settings.loginPagetheme),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "New Item",
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                        Container(
                            width: size.width * 0.6,
                            height: size.height * 0.045,
                            child: TextField(
                              controller: search,
                              onChanged: (val) {
                                if (val != null && val.isNotEmpty) {
                                  value.setIssearch(true);
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    search.clear();
                                    value.setIssearch(false);
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
              value.isSearch ? SearchedProductList() : ProductListPage()
            ],
          );
        },
      ),
    );
  }
}
