import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/widgets/alertCommon/deletePopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CustomerPopup {
  ValueNotifier<bool> visiblename = ValueNotifier(false);
  ValueNotifier<bool> visibleph = ValueNotifier(false);
  ValueNotifier<bool> validph = ValueNotifier(false);
  TextEditingController name = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController contact_person = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? selected;
  var cusout;
  String? custId;
  Future buildcusPopupDialog(
    BuildContext context,
    Size size,
  ) {
    validph.value = false;
    visiblename.value = false;
    visibleph.value = false;
    name.clear();
    adress.clear();
    phone.clear();
    landmark.clear();
    contact_person.clear();
    return showDialog(
        useSafeArea: true,
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return new AlertDialog(
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            // insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Colors.grey[400],
            content: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 8, right: 8, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Customer Selection",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    IconButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Consumer<Controller>(
                builder: (context, value, child) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Autocomplete<Map<String, dynamic>>(
                              optionsBuilder: (TextEditingValue values) {
                                if (values.text.isEmpty) {
                                  return [];
                                } else {
                                  cusout = value.customerList.where(
                                      (suggestion) => suggestion["company_name"]
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

                                  print(value.customerList.where((suggestion) =>
                                      suggestion["company_name"]
                                          .toLowerCase()
                                          .contains(
                                            values.text.toLowerCase(),
                                          )));

                                  return value.customerList.where(
                                      (suggestion) =>
                                          suggestion["company_name"]
                                              .toLowerCase()
                                              .contains(
                                                values.text.toLowerCase(),
                                              ) ||
                                          suggestion["phone_1"].contains(
                                            values.text.toLowerCase(),
                                          ));
                                }
                              },
                              displayStringForOption:
                                  (Map<String, dynamic> option) =>
                                      option["company_name"],
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
                                  // height: size.height * 0.05,
                                  child: TextFormField(
                                    // validator: (text) {
                                    //   if (text == null || text.isEmpty) {
                                    //     visible.value = true;
                                    //     return visible.value.toString();
                                    //     // return 'Please Enter Phone Number';
                                    //   } else {
                                    //     visible.value = false;
                                    //   }
                                    //   return null;
                                    // },
                                    // scrollPadding: EdgeInsets.only(
                                    //     bottom: topInsets + size.height * 0.4),
                                    onChanged: (value) {
                                      name.text = fieldText.text;
                                      visiblename.value = false;

                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .setSelectedCustomer(false);
                                    },
                                    // scrollPadding: EdgeInsets.only(
                                    //     top: 500,),
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 14),
                                      prefixIcon: Icon(Icons.person),
                                      hintText: 'Customer',
                                      hintStyle: TextStyle(fontSize: 14),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          fieldText.clear();
                                          adress.clear();
                                          phone.clear();
                                          contact_person.clear();
                                          landmark.clear();
                                          value.dropSelected = null;
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                      ),
                                    ),

                                    textInputAction: TextInputAction.next,

                                    controller:
                                        // cusout == null || cusout.isEmpty
                                        //     ? name
                                        //     :

                                        fieldText,
                                    focusNode: fieldFocusNode,
                                    style: TextStyle(
                                      fontSize: 16, color: Colors.grey[800],
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
                                    // width: 400,
                                    // height: size.height * 0.3,
                                    // color: Colors.grey[200],
                                    child: Container(
                                      width: 300,
                                      color: Colors.grey[200],
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.all(10.0),
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
                                                  print(
                                                      "optionaid------$option");

                                                  name.text =
                                                      option["company_name"]
                                                          .toString();
                                                  adress.text =
                                                      option["company_add1"]
                                                          .toString();
                                                  phone.text = option["phone_1"]
                                                      .toString();
                                                  landmark.text =
                                                      option["landmark"]
                                                          .toString();
                                                  contact_person.text =
                                                      option["owner_name"]
                                                          .toString();
                                                  custId = option["customer_id"]
                                                      .toString();
                                                  // value.dropSelected =
                                                  //     option["priority"]
                                                  //         .toString();
                                                },
                                                title: Text(
                                                    option["company_name"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black)),
                                                subtitle: Text(
                                                  option["phone_1"].toString(),
                                                ),
                                              ),
                                              Divider()
                                            ],
                                          );

                                          // return GestureDetector(
                                          //   onTap: () {
                                          //     onSelected(option);
                                          //   },
                                          //   child: ListTile(
                                          //     title: Text(option.name,
                                          //         style: const TextStyle(
                                          //             color: Colors.white)),
                                          //   ),
                                          // );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                                // return Align(
                                //   alignment: Alignment.topLeft,
                                //   child: Material(
                                //     child: Container(
                                //       height: size.height * 0.2,
                                //       width: size.width - 80,
                                //       child: ListView.builder(
                                //         shrinkWrap: true,
                                //         padding: EdgeInsets.all(2.0),
                                //         itemCount: options.length,
                                //         itemBuilder:
                                //             (BuildContext context, int index) {
                                //           final Map<String, dynamic> option =
                                //               options.elementAt(index);
                                //           return Column(
                                //             children: [
                                //               ListTile(
                                //                 // tileColor: Colors.amber,
                                //                 onTap: () {
                                //                   onSelected(option);
                                //                   print("optionaid------$option");
                                //                   Provider.of<Controller>(context,
                                //                           listen: false)
                                //                       .setCustomerName(
                                //                     option["name"].toString(),
                                //                     option["address"].toString(),
                                //                     option["phone"].toString(),
                                //                   );
                                //                   adress.text = option["address"]
                                //                       .toString();
                                //                   phone.text =
                                //                       option["phone"].toString();
                                //                 },
                                //                 title: Text(
                                //                     option["name"].toString(),
                                //                     style: TextStyle(
                                //                         fontSize: 15,
                                //                         color: Colors.black)),
                                //                 subtitle: Text(
                                //                   option["address"].toString(),
                                //                 ),
                                //               ),
                                //               Divider()
                                //             ],
                                //           );
                                //         },
                                //       ),
                                //     ),
                                //   ),
                                // );
                              },
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
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: visiblename,
                                      builder: (BuildContext context, bool v,
                                          Widget? child) {
                                        return Visibility(
                                          visible: v,
                                          child: Text(
                                            "Please choose a  Customer",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    // margin:
                                    //     EdgeInsets.only(left: 6, right: 6),
                                    child: TextField(
                                      controller: adress,
                                      onChanged: (val) {
                                        print("val----$val");
                                        // if (val != oldDesc) {
                                        //   // Provider.of<Controller>(context,
                                        //   //         listen: false)
                                        //   //     .setaddNewItem(true);
                                        // }
                                      },
                                      style: TextStyle(color: Colors.grey[800]),
                                      // controller: value.desc[index],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 14),
                                        prefixIcon: Icon(Icons.info),
                                        hintText: "Customer Info",
                                        hintStyle: TextStyle(fontSize: 14),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),
                                  ),
                                  //  Container(
                                  //   // transform:
                                  //   //     Matrix4.translationValues(0.0, -19.0, 0.0),
                                  //   // height: size.height * 0.05,
                                  //   child: TextField(
                                  //     style: TextStyle(color: Colors.grey[800]),
                                  //     // readOnly:
                                  //     //     value.customContainerShow ? false : true,
                                  //     controller: adress,
                                  //     decoration: InputDecoration(
                                  //       border: InputBorder.none,
                                  //       fillColor: Colors.white54,
                                  //       filled: true,
                                  //       contentPadding: EdgeInsets.symmetric(
                                  //           horizontal: 0, vertical: 8),
                                  //       prefixIcon: Icon(Icons.info),
                                  //       hintText: "Customer Info",
                                  //       hintStyle: TextStyle(fontSize: 14),
                                  //     ),
                                  //     keyboardType: TextInputType.multiline,
                                  //     maxLines: null,

                                  //     expands: true,
                                  //   ),
                                  // ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    // transform:
                                    //     Matrix4.translationValues(0.0, -13.0, 0.0),
                                    // height: size.height * 0.05,

                                    child: TextField(
                                      controller: landmark,
                                      style: TextStyle(color: Colors.grey[800]),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 14),
                                        prefixIcon: Icon(Icons.place_outlined),
                                        hintText: "Landmark",
                                        hintStyle: TextStyle(fontSize: 14),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    // transform: Matrix4.translationValues(0.0, 0, 0.0),
                                    // height: size.height * 0.05,
                                    child: TextField(
                                      controller: contact_person,
                                      style: TextStyle(color: Colors.grey[800]),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 14),
                                        prefixIcon: Icon(Icons.person),
                                        hintText: "Contact Person",
                                        hintStyle: TextStyle(fontSize: 14),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    // transform: Matrix4.translationValues(0.0, 8, 0.0),
                                    // height: size.height * 0.05,
                                    child: TextFormField(
                                      onChanged: (va) {
                                        visibleph.value = false;
                                      },
                                      controller: phone,
                                      style: TextStyle(color: Colors.grey[800]),
                                      decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.red,
                                        )),
                                        border: InputBorder.none,
                                        hintText: "Contact Number",
                                        hintStyle: TextStyle(fontSize: 14),
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 14),
                                        prefixIcon: Icon(Icons.phone),
                                      ),
                                      keyboardType: TextInputType.number,
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ValueListenableBuilder(
                                          valueListenable: visibleph,
                                          builder: (BuildContext context,
                                              bool v, Widget? child) {
                                            return Visibility(
                                              visible: v,
                                              child: Text(
                                                "Please Enter Contact Number",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ValueListenableBuilder(
                                          valueListenable: validph,
                                          builder: (BuildContext context,
                                              bool v, Widget? child) {
                                            return Visibility(
                                              visible: v,
                                              child: Text(
                                                "Please Enter Valid Phone Number",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    // color: Colors.grey[200],
                                    height: size.height * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.white, //<-- SEE HERE
                                    ),
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<String>(
                                        // value: selected,
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2.0),
                                          child: Text(
                                            value.dropSelected == null
                                                ? "Select Priority level"
                                                : value.dropSelected!,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),

                                        isExpanded: true,
                                        autofocus: false,
                                        underline: SizedBox(),
                                        elevation: 0,
                                        items: value.priorityList
                                            .map((item) => DropdownMenuItem<
                                                    String>(
                                                value: item.lId.toString(),
                                                child: Container(
                                                  // width: size.width * 0.2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2.0),
                                                    child: Text(
                                                      item.level.toString(),
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                )))
                                            .toList(),
                                        onChanged: (item) {
                                          print("clicked");

                                          if (item != null) {
                                            selected = item;

                                            print("se;ected---$item");
                                            value.setPrioDrop(selected!);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // : Container(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 13.0, bottom: 10),
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
                                                if (name.text == null ||
                                                    name.text.isEmpty) {
                                                  visiblename.value = true;
                                                } else if (phone.text == null ||
                                                    phone.text.isEmpty) {
                                                  visibleph.value = true;
                                                } else if (phone.text.length !=
                                                    10) {
                                                  validph.value = true;
                                                } else {
                                                  validph.value = false;
                                                  visibleph.value = false;
                                                  visiblename.value = false;

                                                  value.saveCustomerInfo(
                                                    context,
                                                    custId.toString(),
                                                    name.text,
                                                    contact_person.text,
                                                    phone.text,
                                                    adress.text,
                                                    landmark.text,
                                                  );

                                                  Provider.of<ProductController>(
                                                          context,
                                                          listen: false)
                                                      .setCustomerName(
                                                    custId.toString(),
                                                    name.text,
                                                    adress.text,
                                                    phone.text,
                                                    contact_person.text,
                                                    landmark.text,
                                                    value.prioId.toString(),
                                                  );
                                                  // name.clear();
                                                  // adress.clear();
                                                  // contact_person.clear();
                                                  // phone.clear();
                                                  // landmark.clear();
                                                  // Provider.of<ProductController>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .getbagData(
                                                  //         context,
                                                  //         "0",
                                                  //         value
                                                  //             .dupcustomer_id!);
                                                  Navigator.pop(context);
                                                  FocusManager
                                                      .instance.primaryFocus!
                                                      .unfocus();
                                                }
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
                                        onPressed: value.selectedCustomer
                                            ? null
                                            : () {
                                                print(
                                                    "name.text----${name.text}");
                                                if (name.text == null ||
                                                    name.text.isEmpty) {
                                                  visiblename.value = true;
                                                } else if (phone.text == null ||
                                                    phone.text.isEmpty) {
                                                  visibleph.value = true;
                                                } else if (phone.text.length !=
                                                    10) {
                                                  validph.value = true;
                                                } else {
                                                  validph.value = false;
                                                  visibleph.value = false;
                                                  visiblename.value = false;

                                                  print(
                                                      "validate---${name.text}--${contact_person.text}-------${phone.text}---${adress.text}----${landmark.text}");

                                                  value.saveCustomerInfo(
                                                    context,
                                                    "0",
                                                    name.text,
                                                    contact_person.text,
                                                    phone.text,
                                                    adress.text,
                                                    landmark.text,
                                                  );
                                                  // name.clear();
                                                  // adress.clear();
                                                  // phone.clear();
                                                  // landmark.clear();
                                                  Provider.of<ProductController>(
                                                          context,
                                                          listen: false)
                                                      .setCustomerName(
                                                    "0",
                                                    name.text,
                                                    adress.text,
                                                    phone.text,
                                                    contact_person.text,
                                                    landmark.text,
                                                    value.prioId.toString(),
                                                    // context,
                                                    //         value.dupcustomer_id!);
                                                    // Provider.of<ProductController>(
                                                    //         context,
                                                    //         listen: false)
                                                    //     .getbagData(context, "0",
                                                    // value.dupcustomer_id!
                                                  );
                                                  FocusManager
                                                      .instance.primaryFocus!
                                                      .unfocus();
                                                  Navigator.pop(context);
                                                }
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
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        });
  }
}
