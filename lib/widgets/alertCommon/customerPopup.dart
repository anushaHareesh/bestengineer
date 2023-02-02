import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CustomerPopup {
  TextEditingController name = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController phone = TextEditingController();
  var cusout;
  Future buildcusPopupDialog(BuildContext context, Size size) {
    name.clear();
    adress.clear();
    phone.clear();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return new AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Colors.grey[100],
            content: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Customer Selection"),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            actions: <Widget>[
              Consumer<Controller>(
                builder: (context, value, child) {
                  return Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          // height: size.height * 0.08,
                          child: Autocomplete<Map<String, dynamic>>(
                            optionsBuilder: (TextEditingValue values) {
                              if (values.text.isEmpty) {
                                return [];
                              } else {
                                cusout = value.customerList.where(
                                    (suggestion) => suggestion["name"]
                                        .toLowerCase()
                                        .contains(values.text.toLowerCase()));
                                if (cusout == null || cusout.isEmpty) {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .setSelectedCustomer(false);
                                } else {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .setSelectedCustomer(true);
                                }
                                return value.customerList.where((suggestion) =>
                                    suggestion["name"].toLowerCase().contains(
                                          values.text.toLowerCase(),
                                        ) ||
                                    suggestion["phone"].contains(
                                      values.text.toLowerCase(),
                                    ));
                              }
                            },
                            displayStringForOption:
                                (Map<String, dynamic> option) => option["name"],
                            // onSelected: (value) {
                            //   setState(() {

                            //   });
                            // },
                            fieldViewBuilder: (BuildContext context,
                                fieldText,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              // Provider.of<Controller>(context, listen: false)
                              //     .customerControllerSale = fieldText;
                              return Container(
                                height: size.height * 0.1,
                                child: TextFormField(
                                  // scrollPadding: EdgeInsets.only(
                                  //     bottom: topInsets + size.height * 0.4),
                                  onChanged: (value) {
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .setSelectedCustomer(false);
                                  },
                                  // scrollPadding: EdgeInsets.only(
                                  //     top: 500,),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      // borderRadius:
                                      //     BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(
                                      gapPadding: 1,
                                      // borderRadius:
                                      //     BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                    ),

                                    hintText: 'Customer',
                                    helperText: ' ', // th
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        fieldText.clear();
                                        adress.clear();
                                        phone.clear();
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  textInputAction: TextInputAction.next,

                                  controller: fieldText,
                                  focusNode: fieldFocusNode,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[800]
                                      // fontWeight: FontWeight.bold
                                      ),
                                ),
                              );
                            },
                            optionsViewBuilder: (BuildContext context,
                                AutocompleteOnSelected<Map<String, dynamic>>
                                    onSelected,
                                Iterable<Map<String, dynamic>> options) {
                              print("option----${options}");

                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  child: Container(
                                    height: size.height * 0.2,
                                    width: size.width - 80,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(2.0),
                                      itemCount: options.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final Map<String, dynamic> option =
                                            options.elementAt(index);
                                        return Column(
                                          children: [
                                            ListTile(
                                              // tileColor: Colors.amber,
                                              onTap: () {
                                                onSelected(option);
                                                print("optionaid------$option");
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .setCustomerName(
                                                  option["name"].toString(),
                                                  option["address"].toString(),
                                                  option["phone"].toString(),
                                                );
                                                adress.text = option["address"]
                                                    .toString();
                                                phone.text =
                                                    option["phone"].toString();
                                              },
                                              title: Text(
                                                  option["name"].toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black)),
                                              subtitle: Text(
                                                option["address"].toString(),
                                              ),
                                            ),
                                            Divider()
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // value.newCustomer
                        //     ? Row(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             "Please Add new customer",
                        //             style: TextStyle(color: Colors.green),
                        //           ),
                        //         ],
                        //       )
                        //     : Container(),
                        // value.cusInitTime
                        //     ? Container()
                        //     : value.newCustomer
                        //         ?

                        Column(
                          children: [
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -13.0, 0.0),
                              height: size.height * 0.07,
                              child: TextField(
                                style: TextStyle(color: Colors.grey[800]),
                                // readOnly:
                                //     value.customContainerShow ? false : true,
                                controller: adress,
                                decoration: InputDecoration(
                                  hintText: "Address",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(
                                            255, 134, 133, 133)), //<-- SEE HERE
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(
                                            255, 134, 133, 133)), //<-- SEE HERE
                                  ),
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(1.0),
                            ),
                            Container(
                              height: size.height * 0.07,
                              child: TextField(
                                controller: phone,
                                style: TextStyle(color: Colors.grey[800]),
                                decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(
                                            255, 134, 133, 133)), //<-- SEE HERE
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(
                                            255, 134, 133, 133)), //<-- SEE HERE
                                  ),
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ),
                          ],
                        ),
                        // : Container(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.3,
                                height: size.height * 0.05,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: P_Settings.loginPagetheme),
                                    onPressed: value.selectedCustomer
                                        ? () {
                                            name.clear();
                                            adress.clear();
                                            phone.clear();
                                            Navigator.pop(context);
                                          }
                                        : null,
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Container(
                                // width: size.width * 0.34,
                                height: size.height * 0.05,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                    onPressed: () {
                                      name.clear();
                                      adress.clear();
                                      phone.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "New Customer",
                                      style: TextStyle(fontSize: 18),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        });
  }
}
