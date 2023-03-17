import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/customSnackbar.dart';
import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/widgets/alertCommon/deletePopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../alertCommon/deleteQuotation.dart';

class DeleteQuotation {
  showdeleteQuotSheet(BuildContext context, String qtNo, String invId) {
    Size size = MediaQuery.of(context).size;

    TextEditingController name = TextEditingController();
    TextEditingController remark = TextEditingController();
    Provider.of<ProductController>(context, listen: false).qtyVal = 1;
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
                    value.dealerList.length == 0
                        ? Container(
                            height: size.height * 0.05,
                            margin:
                                EdgeInsets.only(left: 14, right: 14, top: 14),
                            child: TextField(
                              onChanged: (val) {
                                print("val----$val");
                              },
                              style: TextStyle(color: Colors.grey[800]),
                              controller: name,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 14),
                                hintText: "Enter Dealer Name..",
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
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 163, 163, 163)),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              // width: size.width * 0.4,
                              height: size.height * 0.05,
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  // value: selected,
                                  // isDense: true,
                                  hint: Text(
                                    value.dealerselected == null
                                        ? "Select Dealer.."
                                        : value.dealerselected!,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  isExpanded: true,
                                  autofocus: false,
                                  underline: SizedBox(),
                                  elevation: 0,
                                  items: value.dealerList
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item["customer_id"].toString(),
                                          child: Container(
                                            width: size.width * 0.4,
                                            child: Text(
                                              item["company_name"].toString(),
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          )))
                                      .toList(),
                                  onChanged: (item) {
                                    print("clicked");

                                    if (item != null) {
                                      print("clicked------$item");
                                      selected = item;
                                      Provider.of<QuotationController>(context,
                                              listen: false)
                                          .setDealerDrop(selected!);
                                      // print("se;ected---$item");
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                    Container(
                      // height: size.height * 0.05,
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
                                  DeleteQuotationpopup delete =
                                      DeleteQuotationpopup();
                                      Navigator.pop(mycontext);
                                  delete.builddeletePopupDialog(
                                      context,
                                      "Do You want to delete Inv : $invId",
                                      value.dealerselected.toString(),
                                      selected.toString(),
                                      remark.text,
                                      invId);
                                  // value.deleteQuotation(
                                  //     context,
                                  //     value.dealerselected.toString(),
                                  //     selected.toString(),
                                  //     remark.text,
                                  //     invId);
                                  // DeletePopup deletepopup = DeletePopup();
                                  // deletepopup.builddeletePopupDialog(
                                  //   context,
                                  //   "",
                                  //   "",
                                  //   0,
                                  //   'quotation',
                                  //   "",
                                  //   "",
                                  //   "",
                                  //   remark.text,
                                  // );
                                  // Navigator.pop(mycontext);
                                },
                                child: Text(
                                  "Delete",
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
