import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';

class DeletePopup {
  Future builddeletePopupDialog(BuildContext context, String itemName,
      String itemId, int index, String type,String enqId,String fdtae,String tdate) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return new AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text("Do you want to delete $itemName ?")),
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
                            if (type == "history") {
                              value.updateHistory(context, "2", enqId,fdtae,tdate);
                            } else {
                              value.addDeletebagItem(
                                  itemName,
                                  itemId,
                                  value.cartQty[index].text,
                                  "",
                                  "2",
                                  value.bagList[index]["cart_id"],
                                  context);
                            }

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
}
