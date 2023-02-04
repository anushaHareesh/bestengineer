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
    // oldDesc = list["description"];
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 12, right: 9),
                      child: Container(
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 7.0, right: 9),
                      child: ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Row(
                          children: [
                            Text(
                              "Rate",
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 17,
                                // fontWeight: FontWeight.bold,
                                // color: P_Settings.loginPagetheme,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '\u{20B9}${list.sRate1}',
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 17,
                                // fontWeight: FontWeight.bold,
                                // color: P_Settings.loginPagetheme,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 7.0, right: 9),
                      child: ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
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
                                value.inCrementQty();
                              },
                              child: Container(
                                height: size.height * 0.04,
                                decoration: BoxDecoration(
                                    color: P_Settings.lightPurple,
                                    borderRadius: BorderRadius.circular(10)
                                    //more than 50% of width makes circle
                                    ),
                                width: size.width * 0.1,
                                child: Icon(Icons.add, color: Colors.white),
                              ),
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
                                value.deCrementQty();
                              },
                              child: Container(
                                height: size.height * 0.04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: P_Settings.lightPurple,
                                ),
                                width: size.width * 0.1,
                                child: Icon(Icons.remove, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(8)),
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
                                value.addDeletebagItem(list.productId!,
                                    value.qtyVal.toString(), "0", "0", context);
                                FocusManager.instance.primaryFocus!.unfocus();
                                print("bhdb----${value.res}");
                                if (value.res == "1") {
                                  Fluttertoast.showToast(
                                      msg: "${list.productName} Inserted Successfully...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 16.0,backgroundColor: Colors.green);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Something went wrong...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Add Item",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
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
