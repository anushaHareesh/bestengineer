import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/components/networkConnectivity.dart';
import 'package:bestengineer/model/productListModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends ChangeNotifier {
  String? branch_id;
  var res;
  List<ProductList> productList = [];
  List<ProductList> newList = [];
  bool isSearch = false;
  String urlgolabl = Globaldata.apiglobal;
  List<TextEditingController> qty = [];
  List<TextEditingController> desc = [];
  List<bool> addButton = [];
  bool isProdLoading = false;
  bool isnewlistLoading = false;
  bool adddNewItem = false;
  int qtyVal = 1;
  String? cartCount;

  geProductList(BuildContext context) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$urlgolabl/product_list.php");
          Map body = {"branch_id": "1"};
          isProdLoading = true;
          notifyListeners();
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          ProductListModel prModel = ProductListModel.fromJson(map);
          productList.clear();
          for (var item in prModel.productList!) {
            productList.add(item);
          }
          print("proooo----$productList");

          isProdLoading = false;
          notifyListeners();
          qty = List.generate(
            productList.length,
            (index) => TextEditingController(),
          );
          desc = List.generate(
            productList.length,
            (index) => TextEditingController(),
          );

          addButton = List.generate(productList.length, (index) => false);

          for (var i = 0; i < productList.length; i++) {
            desc[i].text = productList[i].description!;
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
  searchProduct(BuildContext context, String itemName) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("itemNaem----$itemName");
          Uri url = Uri.parse("$urlgolabl/search_products_list.php");
          Map body = {"item_name": itemName};
          isnewlistLoading = true;
          notifyListeners();
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          isSearch = true;
          notifyListeners();
          ProductList prModel;
          newList.clear();
          for (var item in map) {
            prModel = ProductList.fromJson(item);
            newList.add(prModel);
          }
          if (newList.length == 0) {
            adddNewItem = true;
            notifyListeners();
          } else {
            adddNewItem = false;
            notifyListeners();
          }
          print("newList----${newList.length}");
          isnewlistLoading = false;
          notifyListeners();

          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  /////////////////////////////////////////////////////////////////
  inCrementQty() {
    qtyVal = qtyVal + 1;
    notifyListeners();
  }

  setAddButtonColor(bool val, int index) {
    addButton[index] = val;
    notifyListeners();
  }

  deCrementQty() {
    if (qtyVal < 1) {
      qtyVal = 0;
    } else {
      qtyVal = qtyVal - 1;
    }

    notifyListeners();
  }

  setIssearch(bool search) {
    isSearch = search;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////
  Future addDeletebagItem(
    String itemId,
    String qty,
    String event,
    String cart_id,
    BuildContext context,
  ) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          Uri url = Uri.parse("$urlgolabl/save_cart.php");
          Map body = {
            'staff_id': "1",
            'branch_id': "1",
            'item_id': itemId,
            'qty': qty,
            'event': event,
            'cart_id': cart_id
          };

          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          cartCount = map["cart_count"];
          notifyListeners();
          if (map["err_status"] == "0") {
            res = "0";
            notifyListeners();
          } else {
            res = "1";
            notifyListeners();
          }

          print("save cart response---$res--$map");
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }
}
