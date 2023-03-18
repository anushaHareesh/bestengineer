import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/customSnackbar.dart';
import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class NewItemSheet {
  showNewItemSheet(BuildContext context, String prodName) {
    Size size = MediaQuery.of(context).size;

    TextEditingController name = TextEditingController();
    TextEditingController desc = TextEditingController();
    Provider.of<ProductController>(context, listen: false).qtyVal = 1;
    String oldDesc;
    name.text = prodName;
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
                    Container(
                      margin: EdgeInsets.only(left: 14, right: 14, bottom: 8),

                      // transform: Matrix4.translationValues(0.0, -13.0, 0.0),
                      height: size.height * 0.05,
                      child: TextField(
                        style: TextStyle(color: Colors.grey[800]),
                        // readOnly:
                        //     value.customContainerShow ? false : true,
                        controller: name,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          hintText: "Item Name",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(
                                    255, 134, 133, 133)), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(
                                    255, 134, 133, 133)), //<-- SEE HERE
                          ),
                        ),
                        // keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 14, right: 14),
                      child: TextField(
                        onChanged: (val) {
                          print("val----$val");
                        },
                        style: TextStyle(color: Colors.grey[800]),
                        controller: desc,
                        decoration: InputDecoration(
                          hintText: "Type Description here....",
                          hintStyle: TextStyle(fontSize: 13),
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
                    Padding(
                      padding: EdgeInsets.only(left: 7.0, right: 7, top: 3),
                      child: ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -3),
                        title: Row(
                          children: [
                            Text(
                              "Qty",
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 17,
                                // fontWeight: FontWeight.bold,
                                // color: P_Settings.loginPagetheme,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                value.inCrementQty(1, 0, "new");
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Text(
                                value.qtyVal.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                value.deCrementQty(1, 0, "new");
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
                            // Container(
                            //   width: size.width * 0.2,
                            //   child: TextField(
                            //     keyboardType: TextInputType.number,
                            //     style: TextStyle(),
                            //     textAlign: TextAlign.end,
                            //     // controller: value.qty[index],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
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
                              onPressed: () {
                                value.addDeletebagItem(
                                    name.text,
                                    "0",
                                    value.qtyVal.toString(),
                                    desc.text,
                                    "0",
                                    "0",
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .dupcustomer_id
                                        .toString(),
                                    context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Add New Item",
                                style: TextStyle(fontSize: 15),
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
