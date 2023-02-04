import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/components/networkConnectivity.dart';
import 'package:bestengineer/model/areaModel.dart';
import 'package:bestengineer/model/priorityListModel.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../model/customerListModel.dart';
import '../services/dbHelper.dart';

class Controller extends ChangeNotifier {
  String? selected;
  bool selectedCustomer = true;
  bool addNewItem = false;


  bool? arrowButtonclicked;
  TextEditingController searchcontroller = TextEditingController();
  bool isSearchLoading = false;
  bool isSaveLoading = false;

  String? todate;
  String urlgolabl = Globaldata.apiglobal;
  bool isLoading = false;
  bool isListLoading = false;
  String? customerName;
  String? address;
  String? customerPhone;
  List<Map<String, dynamic>> enqDataList = [];
  // List<Map<String, dynamic>> productList = [];
  // List<Map<String, dynamic>> customerList = [];
  List<TextEditingController> qty = [];
  List<TextEditingController> desc = [];
  List<bool> addButton = [];
  String? dropSelected;
  List<AreaList> area_list = [];
  List<PriorityLevel> priorityList = [];

  List<Map<String, dynamic>> customerList = [];



  ///////////////////////////////////////////////////////////////////////

  // getItemCategory(BuildContext context) async {
  //   NetConnection.networkConnection(context).then((value) async {
  //     if (value == true) {
  //       try {
  //         Uri url = Uri.parse("$urlgolabl/category_list.php");

  //         // isDownloaded = true;
  //         isLoading = true;
  //         // notifyListeners();

  //         http.Response response = await http.post(
  //           url,
  //         );
  //         ItemCategoryModel itemCategory;
  //         List map = jsonDecode(response.body);
  //         print("dropdwn------$map");
  //         productList.clear();
  //         productbar.clear();
  //         itemCategoryList.clear();
  //         for (var item in map) {
  //           itemCategory = ItemCategoryModel.fromJson(item);
  //           itemCategoryList.add(itemCategory);
  //         }

  //         dropdwnVal = itemCategoryList[0].catName.toString();
  //         notifyListeners();

  //         // notifyListeners();

  //         isLoading = false;
  //         notifyListeners();
  //         print("sdhjz-----$dropdwnVal");

  //         return dropdwnVal;
  //         /////////////// insert into local db /////////////////////
  //       } catch (e) {
  //         print(e);
  //         // return null;
  //         return [];
  //       }
  //     }
  //   });
  // }

/////////////////////////////////////////////////////////////////////////
  getDataFromEnquiryTable(String table, String condition, String fields) async {
    isLoading = true;
    print("haiiii");
    enqDataList.clear();

    List<Map<String, dynamic>> result =
        await BestEngineer.instance.selectCommonQuery(table, condition, fields);

    for (var item in result) {
      enqDataList.add(item);
    }
    print("enqDataList----$enqDataList");
    isLoading = false;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////////////////
  // searchCustomerList(BuildContext context) async {
  //   NetConnection.networkConnection(context).then((value) async {
  //     if (value == true) {
  //       try {
  //         // Uri url = Uri.parse("$urlgolabl/category_list.php");

  //         customerList = [
  //           {
  //             "name": "anusha",
  //             "address": "khdjhdjksdjksdjks",
  //             "phone": "9061259261",
  //             "priority": "1",
  //             "landmark": "jjjj"
  //           },
  //           {
  //             "name": "aaaaaa",
  //             "address": "khdjhdjksdjksdjks",
  //             "phone": "8103903488",
  //             "priority": "1",
  //             "landmark": "jjjj"
  //           },
  //           {
  //             "name": "bbbbbbb",
  //             "address": "bbbbbb",
  //             "phone": "78907890",
  //             "priority": "1",
  //             "landmark": "jjjj"
  //           }
  //         ];

  //         notifyListeners();
  //       } catch (e) {
  //         print(e);
  //         // return null;
  //         return [];
  //       }
  //     }
  //   });
  // }

  //////////////////////////////////////////////////////////////////////
  // getProducts(BuildContext context) async {
  //   NetConnection.networkConnection(context).then((value) async {
  //     if (value == true) {
  //       try {
  //         // Uri url = Uri.parse("$urlgolabl/category_list.php");

  //         productList = [
  //           {
  //             "itemName": "abcd",
  //             "description":
  //                 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaazxzxnzcjnzxcjnxzcnxcnkxjcnkjzkhzjfzhkfhszaaaaaaaaaajhjkcxkjcjkxzcjkxzc",
  //             "rate": "1233",
  //           },
  //           {
  //             "itemName": "zxcv",
  //             "description":
  //                 "zxcvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv",
  //             "rate": "345",
  //           },
  //           {
  //             "itemName": "anuqwerty",
  //             "description": "abcddddddddddddd",
  //             "rate": "5678",
  //           },
  //           {
  //             "itemName": "mngr",
  //             "description":
  //                 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaazxzxnzcjnzxcjnxzcnxcnkxjcnkjzkhzjfzhkfhszaaaaaaaaaajhjkcxkjcjkxzcjkxzc",
  //             "rate": "1233",
  //           },
  //           {
  //             "itemName": "fghj",
  //             "description":
  //                 "zxcvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv",
  //             "rate": "345",
  //           },
  //           {
  //             "itemName": "edrth",
  //             "description": "abcddddddddddddd",
  //             "rate": "5678",
  //           },
  //         ];
  //         // newList = [
  //         //   {
  //         //     "itemName": "ggggg",
  //         //     "description":
  //         //         "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaazxzxnzcjnzxcjnxzcnxcnkxjcnkjzkhzjfzhkfhszaaaaaaaaaajhjkcxkjcjkxzcjkxzc",
  //         //     "rate": "456"
  //         //   },
  //         //   {
  //         //     "itemName": "kkkkkkk",
  //         //     "description": "hhhmhfmhkfjhlkjhlkhjklghjklghlgj",
  //         //     "rate": "005"
  //         //   },
  //         //   {
  //         //     "itemName": "llllll",
  //         //     "description": "abcddddddddddddd",
  //         //     "rate": "100"
  //         //   }
  //         // ];

  //         qty = List.generate(
  //           productList.length,
  //           (index) => TextEditingController(),
  //         );
  //         desc = List.generate(
  //           productList.length,
  //           (index) => TextEditingController(),
  //         );

  //         addButton = List.generate(productList.length, (index) => false);

  //         for (var i = 0; i < productList.length; i++) {
  //           desc[i].text = productList[i]["description"];
  //         }

  //         notifyListeners();
  //       } catch (e) {
  //         print(e);
  //         // return null;
  //         return [];
  //       }
  //     }
  //   });
  // }

  /////////////////////////////////////////////////////////////////////////
  // searchProduct(BuildContext context, String item) {
  //   NetConnection.networkConnection(context).then((value) async {
  //     if (value == true) {
  //       try {
  //         // Uri url = Uri.parse("$urlgolabl/category_list.php");
  //         print("from product-----$productList---$item");
  //         newList.clear();
  //         newList =
  //             productList.where((e) => e["itemName"].startsWith(item)).toList();
  //         // for (int i = 0; i < productList.length; i++) {
  //         //   if (productList[i]["itemName"] == item) {
  //         //     newList.add(productList[i]);
  //         //   }
  //         // }
  //         notifyListeners();
  //         print("new list------$newList");
  //         if (newList.length == 0) {
  //           addNewItem = true;
  //           notifyListeners();
  //         } else {
  //           addNewItem = false;
  //           notifyListeners();
  //         }
  //         addButton = List.generate(newList.length, (index) => false);
  //         qty = List.generate(
  //           newList.length,
  //           (index) => TextEditingController(),
  //         );
  //         desc = List.generate(
  //           newList.length,
  //           (index) => TextEditingController(),
  //         );

  //         for (var i = 0; i < newList.length; i++) {
  //           desc[i].text = newList[i]["description"];
  //         }
  //       } catch (e) {
  //         print(e);
  //         // return null;
  //         return [];
  //       }
  //     }
  //   });
  // }
  //////////////////////////////////////////////////////////////////////

  setCustomerName(String name, String address, String phone) {
    customerName = name;
    address = address;
    customerPhone = phone;

    print("customer data---------$customerName---$customerPhone");
    notifyListeners();
  }

  setSelectedCustomer(bool show) {
    selectedCustomer = show;
    notifyListeners();
  }




  //////////////////////////////////////////////////
  insertCustomer(BuildContext context, String cusName, String cusInfo,
      String landmark, String phnum, String priority) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("nnnnnnnnnnnn----$cusName");
          return showDialog(
              context: context,
              builder: (ct) {
                Size size = MediaQuery.of(context).size;

                Future.delayed(Duration(seconds: 3), () {
                  Navigator.of(ct).pop(true);

                  // Navigator.of(context).push(
                  //   PageRouteBuilder(
                  //       opaque: false, // set to false
                  //       pageBuilder: (_, __, ___) => MainDashboard()
                  //       // OrderForm(widget.areaname,"return"),
                  //       ),
                  // );
                });
                return AlertDialog(
                    content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Loading.......",
                      style: TextStyle(color: P_Settings.loginPagetheme),
                    ),
                    CircularProgressIndicator()
                    // Icon(
                    //   Icons.done,
                    //   color: Colors.green,
                    // )
                  ],
                ));
              });
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  ////////////////////////////////////////////////////////////////
  getArea(
    BuildContext context,
  ) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$urlgolabl/area_list.php");
          Map body = {"branch_id": "1"};
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          AreaModel regModel = AreaModel.fromJson(map);
          print("areaList-----$map");

          for (var item in regModel.areaList!) {
            area_list.add(item);
          }

          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////
  setDropdowndata(String s) {
    for (int i = 0; i < area_list.length; i++) {
      if (area_list[i].areaId == s) {
        selected = area_list[i].areaName;
      }
    }
    print("s------$s");
    notifyListeners();
  }

  setPrioDrop(String s) {
    for (int i = 0; i < priorityList.length; i++) {
      if (priorityList[i].lId == s) {
        dropSelected = priorityList[i].level;
      }
    }
    print("drop selected=======$dropSelected");
    notifyListeners();
  }

/////////////////////////////////////////////////////
  getCustomerList(BuildContext context, String areaId) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$urlgolabl/customer_list.php");
          Map body = {"area": areaId};
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("customerList-----$map");
          customerList.clear();
          for (var item in map["customer_list"]) {
            customerList.add(item);
          }
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  ///////////////////////////////////////////////////////////////
  gePriorityList(BuildContext context) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$urlgolabl/priority_list.php");
          Map body = {"branch_id": "1"};
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          PriorityListModel prioModel = PriorityListModel.fromJson(map);
          print("priority_list-----$map");
          priorityList.clear();
          for (var item in prioModel.priorityLevel!) {
            priorityList.add(item);
          }
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }
}
