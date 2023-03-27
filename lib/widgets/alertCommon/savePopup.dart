import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';

import '../../components/commonColor.dart';

class SavePopup {
  Future buildSavePopupDialog(
      BuildContext context,
      GlobalKey<ScaffoldState> _scaffoldKey,
String invId,String enqId) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return new AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Confirm Quotation ?"),
              ],
            ),
            actions: <Widget>[
              Consumer<ProductController>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: P_Settings.loginPagetheme),
                          onPressed: () {
                           Provider.of<QuotationController>(context,
                                      listen: false)
                                  .confirmQuotation(
                                      context,
                                      invId,
                                      enqId,
                                      "from quot");
                            Navigator.pop(context);
                          },
                          child: Text("Ok")),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: P_Settings.loginPagetheme),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel")),
                      )
                    ],
                  );
                },
              ),
            ],
          );
        });
  }

  /////////////////////////////////////////////////
  showDailogue(
      BuildContext context, bool isLoading, GlobalKey key, int content) {
    return showDialog(
        context: context,
        builder: (context) {
          Size size = MediaQuery.of(context).size;

          return new WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Text(
                              "Loading .... ",
                              style: TextStyle(color: Colors.black),
                            ),
                            CircularProgressIndicator(
                              color: Colors.green,
                            )
                          ]),
                    )
                  ]));
        });
  }
}
