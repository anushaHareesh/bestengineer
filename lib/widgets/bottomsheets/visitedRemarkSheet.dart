import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/quotationController.dart';

class VisitedRemarkSheet {
  TextEditingController remark = TextEditingController();
  showRemarkSheet(BuildContext context, String enqId, String invId) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            // <-- SEE HERE
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0)),
      ),
      builder: (BuildContext mycontext) {
        return Consumer<RegistrationController>(
            builder: (context, value, child) {
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
                      padding: const EdgeInsets.only(left: 12.0, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Remark  :",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 14, right: 14),
                      child: TextField(
                        onChanged: (val) {
                          print("val----$val");
                        },
                        style: TextStyle(color: Colors.grey[800]),
                        controller: remark,
                        decoration: InputDecoration(
                          hintText: "Type Remark here ..........",
                          hintStyle: TextStyle(fontSize: 12,color: Colors.grey[500]),
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
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      width: size.width * 0.3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: P_Settings.loginPagetheme),
                          onPressed: () {
                            value.saveVisitedRemark(
                                context, remark.text, enqId, invId);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Apply",
                            style: TextStyle(color: P_Settings.whiteColor),
                          )),
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
