import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class DeletePopup {
  Future builddeletePopupDialog(
      BuildContext context,
      String itemName,
      String itemId,
      int index,
      String type,
      String enqId,
      String fdtae,
      String tdate,
      String? reason,
      String type1,
      String rowId) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          // FocusManager.instance.primaryFocus!.unfocus();
          return new AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  "Do you want to delete $itemName ?",
                  style: TextStyle(fontSize: 14),
                )),
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
                              value.updateHistory(
                                  context, "2", enqId, fdtae, tdate, reason);
                            } else if (type == "quotation") {
                            } else if (type == "enqpdt" || type == "quotpdt") {
                              Provider.of<QuotationController>(context,
                                      listen: false)
                                  .removePrdctEnq(
                                      context, itemId, enqId, rowId, type1);
                            } else {
                              value.addDeletebagItem(
                                itemName,
                                itemId,
                                value.cartQty[index].text,
                                "",
                                "2",
                                value.bagList[index]["cart_id"],
                                Provider.of<Controller>(context, listen: false)
                                    .dupcustomer_id
                                    .toString(),
                                context,
                              );
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
