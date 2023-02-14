import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/customSnackbar.dart';
import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/widgets/alertCommon/deletePopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class DeleteQuotation {
  showdeleteQuotSheet(BuildContext context, String qtNo) {
    Size size = MediaQuery.of(context).size;

    TextEditingController name = TextEditingController();
    TextEditingController remark = TextEditingController();
    Provider.of<ProductController>(context, listen: false).qtyVal = 1;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          qtNo,
                          style: TextStyle(
                              fontSize: 17,
                              color: P_Settings.loginPagetheme,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      height: size.height * 0.05,
                      margin: EdgeInsets.only(left: 14, right: 14, top: 14),
                      child: TextField(
                        onChanged: (val) {
                          print("val----$val");
                        },
                        style: TextStyle(color: Colors.grey[800]),
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "Enter Dealer Name..",
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
                        // keyboardType: TextInputType.,
                        // maxLines: null,
                      ),
                    ),
                    Container(
                      height: size.height * 0.05,
                      margin: EdgeInsets.only(left: 14, right: 14, top: 18),
                      child: TextField(
                        onChanged: (val) {
                          print("val----$val");
                        },
                        style: TextStyle(color: Colors.grey[800]),
                        controller: remark,
                        decoration: InputDecoration(
                          hintText: "Enter Remark....",
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
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.3,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: P_Settings.loginPagetheme
                                    // primary: value.addNewItem
                                    //     ? Colors.green
                                    //     : P_Settings.loginPagetheme

                                    ),
                                onPressed: () {
                                  DeletePopup deletepopup = DeletePopup();
                                  deletepopup.builddeletePopupDialog(
                                    context,
                                    "",
                                    "",
                                    0,
                                    'quotation',
                                    "",
                                    "",
                                    "",
                                    remark.text,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Apply",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
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
