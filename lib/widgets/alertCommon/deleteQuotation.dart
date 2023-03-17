import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteQuotationpopup {
  Future builddeletePopupDialog(
    BuildContext context,
    String content,
    String dealerName,
    String dealerId,
    String? reason,
    String invId,
  ) {
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
                  content,
                  style: TextStyle(fontSize: 14),
                )),
              ],
            ),
            actions: <Widget>[
              Consumer<QuotationController>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: P_Settings.loginPagetheme),
                          onPressed: () {
                            Navigator.pop(context);
                            value.deleteQuotation(context, dealerName, dealerId,
                                reason.toString(), invId);
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
