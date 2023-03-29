import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/customSnackbar.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/widgets/bottomsheets/itemSelectionSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SearchedProductList extends StatefulWidget {
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

  SearchedProductList(
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
  State<SearchedProductList> createState() => _SearchedProductListState();
}

class _SearchedProductListState extends State<SearchedProductList> {
  ItemSlectionBottomsheet itemBottom = ItemSlectionBottomsheet();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<ProductController>(
      builder: (context, value, child) {
        if (value.isnewlistLoading) {
          return Container(
            height: size.height * 0.4,
            child: SpinKitCircle(color: P_Settings.loginPagetheme),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            // physics: ClampingScrollPhysics(),
            itemCount: value.newList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 0),
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
                                value.newList[index],
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
                          if (widget.type == "edit quot") {
                            Provider.of<QuotationController>(context,
                                    listen: false)
                                .rawCalculation(
                                    double.parse(value.newList[index].sRate1!),
                                    1,
                                    0.0,
                                    0.0,
                                    double.parse(
                                        value.newList[index].tax_perc!),
                                    0.0,
                                    "0",
                                    0,
                                    index,
                                    true,
                                    "");
                            print("nrrrr--------${value.newList[index].sRate1}");
                            itemBottom.showItemSheet(
                                context,
                                value.newList[index],
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
                              //     value.newList[index].description.toString();
                              itemBottom.showItemSheet(
                                  context,
                                  value.newList[index],
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
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      // onTap: () {
                      //   // Provider.of<Controller>(context, listen: false)
                      //   //     .setaddNewItem(false);
                      //   itemBottom.showItemSheet(
                      //     context,
                      //     value.newList[index],
                      //     index,
                      //   );
                      // },
                      // leading: CircleAvatar(
                      //   backgroundColor: P_Settings.lightPurple,
                      //   child: Text(
                      //     "9",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      // leading: CircleAvatar(
                      //   radius: 20,
                      //   backgroundImage: AssetImage("assets/noImg.png"),
                      // ),
                      title: Text(
                        value.newList[index].productName!.toUpperCase(),
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
                            Text('\u{20B9}${value.newList[index].sRate1}',
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
