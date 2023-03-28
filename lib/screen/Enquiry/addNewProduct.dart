import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/screen/Enquiry/SerchedProductList.dart';
import 'package:bestengineer/screen/Enquiry/productList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewProduct extends StatefulWidget {
//  Map<String,dynamic>? map;
//  AddNewProduct({required this.map});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 10, top: 20, right: 10),
                    // width: size.width * 0.68,
                    height: MediaQuery.of(context).size.height * 0.045,
                    child: TextField(
                      controller: search,
                      onChanged: (val) {
                        if (val != null && val.isNotEmpty) {
                          Provider.of<ProductController>(context, listen: false)
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              ),
            ],
          ),
          SizedBox(height: 10,),

          Divider(),
          SizedBox(height: 3,),
          Consumer<ProductController>(
            builder: (context, value, child) {
              return Expanded(
                  child: value.isSearch
                      ? SearchedProductList()
                      : ProductListPage(type: "edit enq",));
            },
          ),
        ],
      ),
    );
  }
}
