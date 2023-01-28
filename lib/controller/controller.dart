import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/components/networkConnectivity.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Controller extends ChangeNotifier {
  // bool isVisible = false;
  bool? arrowButtonclicked;
  TextEditingController searchcontroller = TextEditingController();
  bool isSearchLoading = false;
  bool isSaveLoading = false;

  String? todate;
  String urlgolabl = Globaldata.apiglobal;
  bool isLoading = false;
  bool isListLoading = false;

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

/////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////
}
