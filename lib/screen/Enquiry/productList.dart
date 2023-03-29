import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/customSnackbar.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../widgets/bottomsheets/itemSelectionSheet.dart';

class ProductListPage extends StatefulWidget {
  String? cus_id;
  String type;
  String owner;
  String com;
  String cid;
  String contactNum;
  String cInfo;
  String land;
  String prio;
  String pin;
  String enq_id;
  String area;
  String rwId;

  // String tax;
  // String taxP;
  // String amt;
  // String disc_per;
  // String disc_amt;
  // String rate;
  // String net_rate;

  ProductListPage(
      {this.cus_id,
      required this.type,
      required this.owner,
      required this.com,
      required this.cid,
      required this.contactNum,
      required this.cInfo,
      required this.land,
      required this.prio,
      required this.pin,
      required this.enq_id,
      required this.area,
      required this.rwId});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ItemSlectionBottomsheet itemBottom = ItemSlectionBottomsheet();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ProductController>(
      builder: (context, value, child) {
        if (value.isProdLoading) {
          return Container(
            height: size.height * 0.4,
            child: SpinKitCircle(color: P_Settings.loginPagetheme),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: value.productList.length,
            itemBuilder: (context, index) {
              // return Padding(
              //   padding: const EdgeInsets.only(left: 8.0),
              //   child: Container(
              //     child: Text(
              //       value.productList[index]["itemName"],
              //       style: TextStyle(
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.grey[600]),
              //     ),
              //     decoration: BoxDecoration(
              //         border: Border(
              //       bottom: BorderSide(
              //         //                   <--- right side
              //         color: Color.fromARGB(255, 155, 152, 152),
              //         width: 1.0,
              //       ),
              //     )),
              //   ),
              // );
              return Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Card(
                  // decoration: BoxDecoration(
                  //     border: Border(
                  //         bottom: BorderSide(
                  //             color: Color.fromARGB(255, 165, 162, 162)))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      trailing: InkWell(
                        onTap: () {
                          if (widget.type == "edit enq") {
                            itemBottom.showItemSheet(
                                context,
                                value.productList[index],
                                index,
                                widget.owner,
                                widget.cid,
                                widget.com,
                                widget.contactNum,
                                widget.cInfo,
                                widget.land,
                                widget.prio,
                                widget.type,
                                widget.enq_id,
                                widget.area,
                                "");
                          }

                          if (widget.type == "") {
                            if (Provider.of<Controller>(context, listen: false)
                                    .customer_id ==
                                null) {
                              CustomSnackbar snackbar = CustomSnackbar();
                              snackbar.showSnackbar(
                                  context, "Please Choose a Customer", "");
                            } else {
                              // value.qty[index].text = "1";
                              // value.desc[index].text =
                              //     value.productList[index].description.toString();
                              itemBottom.showItemSheet(
                                  context,
                                  value.productList[index],
                                  index,
                                  "",
                                  "",
                                  "",
                                  "",
                                  "",
                                  "",
                                  "",
                                  widget.type,
                                  "",
                                  "",
                                  "");
                            }
                          }

                          if (widget.type == "edit quot") {
                            Provider.of<QuotationController>(context,
                                    listen: false)
                                .rawCalculation(
                                    double.parse(
                                        value.productList[index].sRate1!),
                                    1,
                                    0.0,
                                    0.0,
                                    double.parse(
                                        value.productList[index].tax_perc!),
                                    0.0,
                                    "0",
                                    0,
                                    index,
                                    true,
                                    "");
                            itemBottom.showItemSheet(
                                context,
                                value.productList[index],
                                index,
                                widget.owner,
                                widget.cid,
                                widget.com,
                                widget.contactNum,
                                widget.cInfo,
                                widget.land,
                                widget.prio,
                                widget.type,
                                widget.enq_id,
                                widget.area,
                                widget.rwId);
                          }
                        },
                        child: Container(
                          height: size.height * 0.03,
                          width: size.width * 0.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: P_Settings.loginPagetheme,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Add",
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          ),
                        ),
                      ),
                      // trailing: Container(
                      //   height: size.height*0.037,
                      //   child:

                      //    ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //         primary:
                      //             // value.addButton[index]
                      //             //     ? Colors.green
                      //             //     :

                      //             Colors.yellow),
                      //     child:
                      //         //  value.addButton[index]
                      //         //     ? Icon(Icons.done)
                      //         //     :

                      //         Text(
                      //       "Add",
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //     onPressed: () {

                      //       itemBottom.showItemSheet(
                      //         context,
                      //         value.productList[index],
                      //         index,
                      //       );
                      //     },
                      //   ),
                      // ),
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Text(
                        value.productList[index].productName!.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text("Rate  : ",
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            Text('\u{20B9}${value.productList[index].sRate1}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
