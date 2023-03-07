import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';

class CompleteService {
  showCompleteServiceSheet(
      BuildContext context, String com, String form_id, String qb_id) {
    Size size = MediaQuery.of(context).size;

    TextEditingController amount = TextEditingController();
    TextEditingController tot = TextEditingController();

    TextEditingController remark = TextEditingController();
    // Provider.of<ProductController>(context, listen: false).qtyVal = 1;
    String oldDesc;
    String? selected;
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
        return Consumer<QuotationController>(builder: (context, value, child) {
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
                          com,
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
                        controller: tot,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 14),
                          hintText: "Enter Total Amount..",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 131, 131, 131),
                              fontSize: 13),
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
                      margin: EdgeInsets.only(left: 14, right: 14, top: 14),
                      child: TextField(
                        onChanged: (val) {
                          print("val----$val");
                        },
                        style: TextStyle(color: Colors.grey[800]),
                        controller: amount,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 14),
                          hintText: "Enter Amount to pay ..",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 131, 131, 131),
                              fontSize: 13),
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 14),
                          hintText: "Enter Remark....",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 131, 131, 131),
                              fontSize: 13),
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
                                  Provider.of<RegistrationController>(context,
                                          listen: false)
                                      .saveCompleteService(context, form_id,
                                          qb_id, tot.text, amount.text);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Save",
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
