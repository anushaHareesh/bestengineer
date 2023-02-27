import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/customSnackbar.dart';
import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../model/productListModel.dart';

class ItemSlectionBottomsheet {
  showItemSheet(BuildContext context, ProductList list, int index) {
    Size size = MediaQuery.of(context).size;
    print(" uuuu---$index---${list.description}");
    String oldDesc;

    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            // <-- SEE HERE
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        Provider.of<ProductController>(context, listen: false)
                .desc[index]
                .text =
            Provider.of<ProductController>(context, listen: false)
                .productList[index]
                .description
                .toString();
        return Consumer<ProductController>(builder: (context, value, child) {
          // value.qty[index].text=qty.toString();

          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              list.productName!.toUpperCase(),
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                // color: P_Settings.loginPagetheme,
                              ),
                            ),
                          ),
                          // Spacer(),
                          // IconButton(
                          //     onPressed: () {
                          //       Navigator.pop(context);
                          //     },
                          //     icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 14, right: 14),
                      child: TextField(
                        onChanged: (val) {
                          print("val----$val");
                          // if (val != oldDesc) {
                          //   // Provider.of<Controller>(context,
                          //   //         listen: false)
                          //   //     .setaddNewItem(true);
                          // }
                        },
                        style: TextStyle(color: Colors.grey[500]),
                        controller: value.desc[index],
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(
                                    255, 172, 170, 170)), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(
                                    255, 172, 170, 170)), //<-- SEE HERE
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Row(
                        children: [
                          Text(
                            "Rate",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              // fontWeight: FontWeight.bold,
                              // color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9}${list.sRate1}',
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              // fontWeight: FontWeight.bold,
                              // color: P_Settings.loginPagetheme,
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      // visualDensity:
                      //     VisualDensity(horizontal: 0, vertical: -4),
                      title: Row(
                        children: [
                          Text(
                            "Qty",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 17,
                              // fontWeight: FontWeight.bold,
                              // color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              value.inCrementQty(
                                  int.parse(value.qty[index].text), index, "");
                            },
                            child: Container(
                                height: size.height * 0.04,
                                width: size.width * 0.06,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 205, 195, 195),
                                  ),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 14,
                                  color: P_Settings.loginPagetheme,
                                )),
                          ),
                          Container(
                            width: size.width * 0.06,
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              controller: value.qty[index],
                              // value.qtyVal.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              value.deCrementQty(
                                  int.parse(value.qty[index].text), index, "");
                            },
                            child: Container(
                                height: size.height * 0.04,
                                width: size.width * 0.06,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 205, 195, 195),
                                  ),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 14,
                                  color: P_Settings.loginPagetheme,
                                )),
                          )
                        ],
                      ),
                    ),
                    // Padding(padding: EdgeInsets.all(8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // width: size.width * 0.3,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: P_Settings.loginPagetheme
                                  // primary: value.addNewItem
                                  //     ? Colors.green
                                  //     : P_Settings.loginPagetheme

                                  ),
                              onPressed: () async {
                                value.setAddButtonColor(true, index);
                                value.addDeletebagItem(
                                    list.productName!,
                                    list.productId!,
                                    value.qty[index].text,
                                    value.desc[index].text,
                                    "0",
                                    "0",
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .dupcustomer_id
                                        .toString(),
                                    context);
                                FocusManager.instance.primaryFocus!.unfocus();
                                print("bhdb----${value.res}");

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Add Item",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
