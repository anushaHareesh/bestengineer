import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/customSnackbar.dart';
import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class ItemSlectionBottomsheet {
  showItemSheet(BuildContext context, Map<String, dynamic> list, int index) {
    Size size = MediaQuery.of(context).size;
    TextEditingController desc = TextEditingController();
    String oldDesc;
    oldDesc=list["description"];
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
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();
            if (value.isListLoading) {
              return Container(
                  height: 200,
                  child: SpinKitFadingCircle(
                    color: P_Settings.loginPagetheme,
                  ));
            } else {
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
                          padding: const EdgeInsets.only(top: 8.0, left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  list["itemName"].toUpperCase(),
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    // color: P_Settings.loginPagetheme,
                                  ),
                                ),
                              ),
                              // Spacer(),
                              // IconButton(
                              //     onPressed: () {
                              //       Navigator.pop(context);
                              //     },
                              //     icon: Icon(Icons.close))
                            ],
                          ),
                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, top: 12, right: 9),
                          child: Container(
                            child: TextField(
                              onChanged: (val){
                                print("val----$val");
                                if(val!=oldDesc){
                                  Provider.of<Controller>(context, listen: false).setaddNewItem(true);
                                }
                              },
                              style: TextStyle(color: Colors.grey[500]),
                              controller: value.desc[index],
                              decoration: InputDecoration(
                               
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 7.0, right: 9),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "Rate",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    // color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '\u{20B9}${list["rate"]}',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    // color: P_Settings.loginPagetheme,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 7.0, right: 9),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "Qty",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    // color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: size.width * 0.2,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(),
                                    textAlign: TextAlign.end,
                                    controller: value.qty[index],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // width: size.width * 0.3,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: value.addNewItem?Colors.green: P_Settings.loginPagetheme),
                                  onPressed: () {},
                                  child: Text(
                                 value.addNewItem?"Add New Item":  "Add ",
                                    style: TextStyle(fontSize: 19),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
