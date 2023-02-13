import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RemarkSheet {
  TextEditingController remark = TextEditingController();
  showRemarkSheet(BuildContext context, String sdate, String enq_id,
      GlobalKey<ScaffoldState> _scaffoldKey, GlobalKey<State> _keyLoader) {
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
                          // hintText: "Reason ........",
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
                            Navigator.of(_scaffoldKey.currentContext!).pop();
                            showDailogue(context, true, _keyLoader, 1);
                            Provider.of<QuotationController>(context,
                                    listen: false)
                                .saveQuotation(_scaffoldKey.currentContext!,
                                    remark.text, sdate, "0", enq_id);
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

  ///////////////////////////////////////////////////
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
