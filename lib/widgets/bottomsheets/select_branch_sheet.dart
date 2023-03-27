import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/screen/Quotation/pdfPrev.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';

class SelectBranchSheet {
  String? selected;
  ValueNotifier<bool> visible = ValueNotifier(false);

  TextEditingController remark = TextEditingController();

  showRemarkSheet(BuildContext context, String invId) {
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
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 12.0, bottom: 12),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         "Remark Sheet",
                    //         style: TextStyle(fontSize: 20),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
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
                              value.branchselected == null
                                  ? "Select Branch.."
                                  : value.branchselected!,
                              style: TextStyle(fontSize: 14),
                            ),
                            isExpanded: true,
                            autofocus: false,
                            underline: SizedBox(),
                            elevation: 0,
                            items: value.branchList
                                .map((item) => DropdownMenuItem<String>(
                                    value: item["id"].toString(),
                                    child: Container(
                                      width: size.width * 0.4,
                                      child: Text(
                                        item["value"].toString(),
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    )))
                                .toList(),
                            onChanged: (item) {
                              print("clicked");

                              if (item != null) {
                                visible.value = false;

                                print("clicked------$item");
                                selected = item;
                                Provider.of<QuotationController>(context,
                                        listen: false)
                                    .setBranchDrop(selected!);
                                // print("se;ected---$item");
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 14, right: 14, top: 8),
                    //   child: TextField(
                    //     onChanged: (val) {
                    //       print("val----$val");
                    //     },
                    //     style: TextStyle(color: Colors.grey[800]),
                    //     controller: remark,
                    //     decoration: InputDecoration(
                    //       hintText: "Enter Remark here..",
                    //       hintStyle: TextStyle(fontSize: 14),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //             width: 1,
                    //             color: Color.fromARGB(
                    //                 255, 172, 170, 170)), //<-- SEE HERE
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //             width: 1,
                    //             color: Color.fromARGB(
                    //                 255, 172, 170, 170)), //<-- SEE HERE
                    //       ),
                    //     ),
                    //     keyboardType: TextInputType.multiline,
                    //     maxLines: null,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 17),
                      child: ValueListenableBuilder(
                          valueListenable: visible,
                          builder:
                              (BuildContext context, bool v, Widget? child) {
                            print("value===${visible.value}");
                            return Visibility(
                              visible: v,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select Branch!!!",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      width: size.width * 0.3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: P_Settings.loginPagetheme),
                          onPressed: () {
                            String hiddenstatus;

                            if (value.branchselected == null) {
                              visible.value = true;
                            } else {
                              visible.value = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdfPreviewPage(
                                      br: selected.toString(), id: invId),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "View PDF",
                            style: TextStyle(
                                color: P_Settings.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
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
