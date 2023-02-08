import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/components/networkConnectivity.dart';
import 'package:bestengineer/model/enqHistoryModel.dart';

import 'package:bestengineer/model/productListModel.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/commonColor.dart';
import '../model/enqHisDetailsModel.dart';

class ProductController extends ChangeNotifier {
  String? branch_id;
  String? todate;

  String? fromDate;
  String? priority_level;
  String? customerName;
  String? address;
  String? customerPhone;
  String? owner_name;
  String? landmark;
  String? customer_id;
  bool isLoading = false;
  bool isDetailLoading = false;

  var res;
  bool isCartLoading = false;
  List<ProductList> productList = [];
  List<ProductList> newList = [];
  bool isSearch = false;
  String urlgolabl = Globaldata.apiglobal;
  List<TextEditingController> qty = [];
  List<TextEditingController> pname = [];

  List<TextEditingController> desc = [];
  List<TextEditingController> hisqty = [];
  List<TextEditingController> cartQty = [];
  List<Map<String, dynamic>> bagList = [];
  List<EnqList> enQhistoryList = [];
  List<Master> enQhistoryMaster = [];
  List<Detail> enQhistoryDetail = [];
  TextEditingController cname = TextEditingController();
  TextEditingController cperson = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cinfo = TextEditingController();
  TextEditingController landmarked = TextEditingController();

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
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          Uri url = Uri.parse("$urlgolabl/product_list.php");
          Map body = {"branch_id": branch_id};
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
            qty[i].text = "1";
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

          print("searched list----$map");
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

  inCrementQty(int qtyi, int index, String type) {
    if (type == "new") {
      qtyVal = qtyVal + 1;
    } else if (type == "cart") {
      cartQty[index].text = (qtyi + 1).toString();
    } else if (type == "editHis") {
      hisqty[index].text = (qtyi + 1).toString();
    } else {
      qty[index].text = (qtyi + 1).toString();
    }
    notifyListeners();
  }

/////////////////////////////////////////////////////////
  setAddButtonColor(
    bool val,
    int index,
  ) {
    addButton[index] = val;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////
  deCrementQty(int qtyi, int index, String type) {
    print("qtyi-----${qty[index].text}");

    if (type == "new") {
      if (qtyVal > 1) {
        qtyVal = qtyVal - 1;
      }
    } else if (type == "cart") {
      if (int.parse(cartQty[index].text) > 1) {
        int q = qtyi - 1;
        cartQty[index].text = q.toString();
      }
    } else if (type == "editHis") {
      if (int.parse(cartQty[index].text) > 1) {
        int q = qtyi - 1;
        hisqty[index].text = q.toString();
      }
    } else {
      if (int.parse(qty[index].text) > 1) {
        int q = qtyi - 1;
        qty[index].text = q.toString();
      }
    }

    notifyListeners();
  }

  setIssearch(bool search) {
    isSearch = search;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////
  Future addDeletebagItem(
    String prodName,
    String itemId,
    String qty,
    String? description,
    String event,
    String cart_id,
    BuildContext context,
  ) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          Uri url = Uri.parse("$urlgolabl/save_cart.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'item_id': itemId,
            'qty': qty,
            "description": description,
            'event': event,
            'cart_id': cart_id
          };
          print("svae cart body---$body");
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("save cart response----$map");

          cartCount = map["cart_count"];
          notifyListeners();
          if (map["err_status"] == 0) {
            if (event == "0") {
              Fluttertoast.showToast(
                msg: "${prodName} Inserted Successfully...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 14.0,
                backgroundColor: Colors.green,
              );
            }

            notifyListeners();
          } else {
            if (event == "0") {
              Fluttertoast.showToast(
                  msg: "Something went wrong...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.white,
                  fontSize: 14.0);
            }

            notifyListeners();
          }

          if (event == "2") {
            getbagData(context, event);
          }

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

  ///////////////////////////////////////////
  getbagData(BuildContext context, String event) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          print("kjn---------------$branch_id----$user_id-");
          isSearch = false;
          notifyListeners();
          Uri url = Uri.parse("$urlgolabl/cart_list.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
          };
          print("cart body-----$body");
          // if (event == "0") {
          isCartLoading = true;
          notifyListeners();
          // }

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);

          bagList.clear();
          print("cart response-----------------${map}");
          for (var item in map) {
            bagList.add(item);
          }
          cartCount = bagList.length.toString();
          notifyListeners();
          cartQty = List.generate(
            bagList.length,
            (index) => TextEditingController(),
          );
          for (var i = 0; i < bagList.length; i++) {
            cartQty[i].text = bagList[i]["qty"];
          }
          // if (event == "0") {
          isCartLoading = false;
          notifyListeners();
          // }

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print("error...$e");
          // return null;
          return [];
        }
      }
    });
  }

  ///////////////////////////////////////////////////
  setCustomerName(String custome_id2, String name, String address1,
      String phone, String owner_name1, String landm, String? prio) {
    print(
        "cus  ---$custome_id2-----$name---$address1---$phone----$owner_name1---$landm-$prio");
    customer_id = custome_id2;
    customerName = name;
    address = address1;
    customerPhone = phone;
    owner_name = owner_name1;
    landmark = landm;
    priority_level = prio;

    print(
        "customer data----$customer_id-----$customerName---$address---$customerPhone----$owner_name---$landmark-$prio");
    notifyListeners();
  }

///////////////////////////////////////////////////////////////////////////////
  saveCartDetails(
    BuildContext context,
    String row_id,
  ) async {
    List<Map<String, dynamic>> jsonResult = [];
    Map<String, dynamic> itemmap = {};
    Map<String, dynamic> resultmmap = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    branch_id = prefs.getString("branch_id");
    String? user_id = prefs.getString("user_id");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        print("bagList-----$bagList");
        Uri url = Uri.parse(
            "https://trafiqerp.in/webapp/beste/common_api/op_enquiry_master.php");

        jsonResult.clear();
        itemmap.clear();

        for (var i = 0; i < bagList.length; i++) {
          var itemmap = {
            "product_id": bagList[i]["item_id"],
            "product_name": bagList[i]["item_name"],
            "qty": cartQty[i].text,
            "product_info": bagList[i]["description"],
          };
          jsonResult.add(itemmap);
        }
        print("jsonResult----$jsonResult");
        Map masterMap = {
          "owner_name": owner_name,
          "cust_id": customer_id,
          "company_name": customerName,
          "contact_num": customerPhone,
          "cust_info": address,
          "row_id": row_id,
          "hidden_status": "0",
          "landmark": landmark,
          "priority_level": priority_level,
          "added_by": user_id,
          "branch_id": branch_id,
          "details": jsonResult
        };

        print("resultmap----$masterMap");
        // var body = {'json_data': masterMap};
        // print("body-----$body");

        var jsonEnc = jsonEncode(masterMap);

        print("jsonEnc-----$jsonEnc");
        isLoading = true;
        notifyListeners();
        http.Response response = await http.post(
          url,
          body: {'json_data': jsonEnc},
        );

        var map = jsonDecode(response.body);
        print("save transaction-----$map");

        return showDialog(
            context: context,
            builder: (ct) {
              Size size = MediaQuery.of(ct).size;

              Future.delayed(Duration(seconds: 2), () {
                // Navigator.of(context).pop(true);

                Navigator.of(ct).pop(true);

                // if (map["err_status"] == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnqHome(),
                  ),
                );
                // }

                // Navigator.pop(context);
              });
              return AlertDialog(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      '${map['msg']}',
                      style: TextStyle(color: P_Settings.loginPagetheme),
                    ),
                  ),
                  Icon(
                    Icons.done,
                    color: Colors.green,
                  )
                ],
              ));
            });
      }
    });
  }

  /////////////////////////////////////////////////////////////
  setDate(String date1, String date2) {
    fromDate = date1;
    todate = date2;
    print("gtyy----$fromDate----$todate");
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////
  getEnqhistoryData(
    BuildContext context,
    String action,
    String fromDate,
    String tillDate,
  ) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          print("history------------------$user_id-----");
          Uri url = Uri.parse("$urlgolabl/enquiry_list.php");
          Map body = {
            'staff_id': user_id,
            "branch_id": branch_id,
            'from_date': "07-02-2023",
            'till_date': "08-02-2023",
          };
          print("history body-----$body");
          if (action != "delete") {
            isLoading = true;
            notifyListeners();
          }

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          EnqHistoryModel model = EnqHistoryModel.fromJson(map);
          print("history response-----------------${map}");

          if (action != "delete") {
            isLoading = false;
            notifyListeners();
          }

          if (map != null) {
            enQhistoryList.clear();

            for (var item in model.enqList!) {
              enQhistoryList.add(item);
            }
          }

          print("enq history list data........${enQhistoryList}");
          // isLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print("error...$e");
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////////
  getEnqhistoryDetails(BuildContext context, String enqId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          String? user_id = prefs.getString("user_id");
          print("history------------------$user_id-----");
          Uri url = Uri.parse("$urlgolabl/enquiry_list_detail.php");
          Map body = {
            'enq_id': enqId,
          };
          print("history body-----$body");
          // if (action != "delete") {
          isDetailLoading = true;
          notifyListeners();
          // }

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("enQhistoryDetails response-----------------${map}");

          // if (action != "delete") {
          isDetailLoading = false;
          notifyListeners();
          // }
          EnqHisDetails hisDeta = EnqHisDetails.fromJson(map);
          // enQhistoryDetails.clear();
          enQhistoryMaster.clear();
          enQhistoryDetail.clear();

          if (map != null) {
            for (var item in hisDeta.master!) {
              enQhistoryMaster.add(item);
            }

            cname.text =
                enQhistoryMaster[0].companyName.toString().toUpperCase();
            phone.text = enQhistoryMaster[0].contactNum.toString();
            landmarked.text =
                enQhistoryMaster[0].landmark.toString().toUpperCase();
            cperson.text =
                enQhistoryMaster[0].ownerName.toString().toUpperCase();
            cinfo.text = enQhistoryMaster[0].custInfo.toString().toUpperCase();

            for (var item in hisDeta.detail!) {
              enQhistoryDetail.add(item);
            }
          }
          pname = List.generate(
            enQhistoryDetail.length,
            (index) => TextEditingController(),
          );
          desc = List.generate(
            enQhistoryDetail.length,
            (index) => TextEditingController(),
          );
          hisqty = List.generate(
            enQhistoryDetail.length,
            (index) => TextEditingController(),
          );
          for (int i = 0; i < enQhistoryDetail.length; i++) {
            pname[i].text = enQhistoryDetail[i].productName.toString();
            desc[i].text = enQhistoryDetail[i].productInfo.toString();
            hisqty[i].text = enQhistoryDetail[i].qty.toString();
          }
          print(
              "enQhistoryMaster.......${enQhistoryMaster}------$enQhistoryDetail");
          // isLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print("error...$e");
          // return null;
          return [];
        }
      }
    });
  }

  ////////////////////////////////////////////////////////////
  updateHistory(BuildContext context, String event, String enqId, String fdate,
      String tdate) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          print("kjn---------------$branch_id----$user_id-");
          isSearch = false;
          notifyListeners();
          Uri url = Uri.parse("$urlgolabl/enq_update.php");
          Map body = {
            'enq_id': enqId,
            'event': event,
            'added_by': user_id,
            'branch_id': branch_id,
          };
          // isLoading = true;
          // notifyListeners();
          print("update transaction--body----$body");
          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("update transaction------$map");
          // isLoading = false;
          // notifyListeners();

          if (map["flag"] == 0) {
            getEnqhistoryData(context, "", fdate, tdate);
          }
          /////////////// insert into local db /////////////////////
        } catch (e) {
          print("error...$e");
          // return null;
          return [];
        }
      }
    });
  }
}
