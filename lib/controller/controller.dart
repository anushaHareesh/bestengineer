import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/components/networkConnectivity.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../services/dbHelper.dart';

class Controller extends ChangeNotifier {
  bool selectedCustomer = true;
  bool addNewItem = false;

  bool isSearch = false;

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
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> customerList = [];
  List<TextEditingController> qty = [];
  List<TextEditingController> desc = [];
  List<Map<String, dynamic>> newList = [];

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

/////////////////////////////////////////////////////////////////////////
  searchProduct(BuildContext context) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          // Uri url = Uri.parse("$urlgolabl/category_list.php");
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  searchCustomerList(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          // Uri url = Uri.parse("$urlgolabl/category_list.php");

          customerList = [
            {
              "name": "anusha",
              "address": "khdjhdjksdjksdjks",
              "phone": "9061259261"
            },
            {
              "name": "aaaaaa",
              "address": "khdjhdjksdjksdjks",
              "phone": "8103903488"
            },
            {
              "name": "bbbbbbb",
              "address": "bbbbbb",
              "phone": "78907890",
            }
          ];

          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////////
  getProducts(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          // Uri url = Uri.parse("$urlgolabl/category_list.php");

          productList = [
            {
              "itemName": "abcd",
              "description":
                  "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaazxzxnzcjnzxcjnxzcnxcnkxjcnkjzkhzjfzhkfhszaaaaaaaaaajhjkcxkjcjkxzcjkxzc",
              "rate": "1233"
            },
            {
              "itemName": "zxcv",
              "description": "hhhmhfmhkfjhlkjhlkhjklghjklghlgj",
              "rate": "345"
            },
            {
              "itemName": "anuqwerty",
              "description": "abcddddddddddddd",
              "rate": "5678"
            }
          ];
          newList = [
            {
              "itemName": "ggggg",
              "description":
                  "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaazxzxnzcjnzxcjnxzcnxcnkxjcnkjzkhzjfzhkfhszaaaaaaaaaajhjkcxkjcjkxzcjkxzc",
              "rate": "1233"
            },
            {
              "itemName": "zxcv",
              "description": "hhhmhfmhkfjhlkjhlkhjklghjklghlgj",
              "rate": "345"
            },
            {
              "itemName": "anuqwerty",
              "description": "abcddddddddddddd",
              "rate": "5678"
            }
          ];

          qty = List.generate(
            productList.length,
            (index) => TextEditingController(),
          );
          desc = List.generate(
            productList.length,
            (index) => TextEditingController(),
          );

          for (var i = 0; i < productList.length; i++) {
            desc[i].text = productList[i]["description"];
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
  setaddNewItem(bool addn) {
    addNewItem = addn;
    notifyListeners();
  }
  setIssearch(bool search) {
    isSearch = search;
    notifyListeners();
  }
}
