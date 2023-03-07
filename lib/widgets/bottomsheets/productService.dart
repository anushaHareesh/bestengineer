import 'package:bestengineer/controller/registrationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';
import '../../controller/productController.dart';

class ServiceProduct {
  TextEditingController reason = TextEditingController();
  showProdSheet(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      // isDismissible: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            // <-- SEE HERE
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0)),
      ),
      builder: (BuildContext mycontext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) {
                return Consumer<RegistrationController>(
                    builder: (context, value, child) {
                  // value.qty[index].text=qty.toString();

                  if (value.isProdLoding) {
                    return SpinKitCircle(
                      color: P_Settings.loginPagetheme,
                    );
                  } else {
                    return Center(
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
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Product Info : ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: value.servicesProdList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              AssetImage("assets/noImg.png"),
                                        ),
                                        title: Text(
                                          "${value.servicesProdList[index]["product_name"]}",style: TextStyle(fontSize: 13),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text("Qty : "),
                                            Text(
                                              "${value.servicesProdList[index]["qty"]}",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );

                                  // return Container(
                                  //   child: Column(
                                  //     children: [
                                  //       Row(
                                  //         children: [
                                  //           Text("Item : "),
                                  //           Text(
                                  //               "${value.servicesProdList[index]["product_name"]}")
                                  //         ],
                                  //       ),
                                  //       Row(
                                  //         children: [
                                  //           Text("Qty : "),
                                  //           Text(
                                  //               "${value.servicesProdList[index]["qty"]}")
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                });
              },
            );
          },
        );
      },
    );
  }
}
