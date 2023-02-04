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
  showNewItemSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextEditingController name = TextEditingController();
    TextEditingController desc = TextEditingController();

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
                      padding:
                          const EdgeInsets.only(left: 12, top: 12, right: 9),
                      child: Container(
                        transform: Matrix4.translationValues(0.0, -13.0, 0.0),
                        height: size.height * 0.07,
                        child: TextField(
                          style: TextStyle(color: Colors.grey[800]),
                          // readOnly:
                          //     value.customContainerShow ? false : true,
                          controller: name,
                          decoration: InputDecoration(
                            hintText: "ItemName",
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
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 12, right: 9),
                      child: Container(
                        child: TextField(
                          onChanged: (val) {
                            print("val----$val");
                          },
                          style: TextStyle(color: Colors.grey[500]),
                          controller: desc,
                          decoration: InputDecoration(
                            hintText: "Description",
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
                                  value.addDeletebagItem(name.text,
                                    value.qtyVal.toString(), "0", "0", context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Add New Item",
                                style: TextStyle(fontSize: 19),
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
