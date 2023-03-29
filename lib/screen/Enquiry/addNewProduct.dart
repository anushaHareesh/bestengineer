import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/screen/Enquiry/SerchedProductList.dart';
import 'package:bestengineer/screen/Enquiry/productList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewProduct extends StatefulWidget {
  String owner;
  String com;
  String cid;
  String contactNum;
  String cInfo;
  String land;
  String prio;
  String pin;
  String enqId;
  String area;
  String page;
  String type;
  String rwId;

  // String tax;
  // String taxP;
  // String amt;
  // String disc_per;
  // String disc_amt;
  // String rate;
  // String net_rate;
  AddNewProduct({
    required this.owner,
    required this.com,
    required this.cid,
    required this.contactNum,
    required this.cInfo,
    required this.land,
    required this.prio,
    required this.pin,
    required this.enqId,
    required this.area,
    required this.page,
    required this.type,
    required this.rwId,

    // required this.amt,
    // required this.disc_amt,
    // required this.disc_per,
    // required this.tax,
    // required this.net_rate,
    // required this.taxP,
    // required this.rate
  });

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (widget.type == "edit enq") {
                Provider.of<QuotationController>(context, listen: false)
                    .getQuotationFromEnqList(context, widget.enqId);
              } else {
                Provider.of<QuotationController>(context, listen: false)
                    .quotationEdit(context, widget.rwId, widget.enqId);
              }

              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
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
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 3,
          ),
          Consumer<ProductController>(
            builder: (context, value, child) {
              return Expanded(
                  child: value.isSearch
                      ? SearchedProductList(
                          type: widget.type,
                          cInfo: widget.cInfo,
                          cid: widget.cid,
                          com: widget.com,
                          contactNum: widget.contactNum,
                          land: widget.land,
                          owner: widget.owner,
                          pin: widget.pin,
                          prio: widget.prio,
                          cus_id: widget.cid,
                          enq_id: widget.enqId,
                          area: widget.area,
                          rwId: widget.rwId,
                        )
                      : ProductListPage(
                          type: widget.type,
                          cInfo: widget.cInfo,
                          cid: widget.cid,
                          com: widget.com,
                          contactNum: widget.contactNum,
                          land: widget.land,
                          owner: widget.owner,
                          pin: widget.pin,
                          prio: widget.prio,
                          cus_id: widget.cid,
                          enq_id: widget.enqId,
                          area: widget.area,
                          rwId: widget.rwId,
                        ));
            },
          ),
        ],
      ),
    );
  }
}
