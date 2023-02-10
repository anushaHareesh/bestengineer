import 'dart:convert';

import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/components/networkConnectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class QuotationController extends ChangeNotifier {
  String urlgolabl = Globaldata.apiglobal;
 String? customer_name;
  String? c_person;
  String? phone;
  String? cus_info;
  String? priority;
  String? landmarked;
  String? color1;

  bool fromApi=true;


  // String? phone;

  double taxable_rate = 0.0;
  double tax = 0.0;
  double cgst_amt = 0.0;
  double cgst_per = 0.0;
  double sgst_amt = 0.0;
  double sgst_per = 0.0;
  double igst_amt = 0.0;
  double igst_per = 0.0;
  double disc_per = 0.0;
  double cess = 0.0;
  double gross = 0.0;
  double gross_tot = 0.0;
  double disc_amt = 0.0;
  double net_amt = 0.0;
  List<TextEditingController> discount_prercent = [];
  List<TextEditingController> rateEdit = [];
  List<TextEditingController> quotqty = [];
  List<TextEditingController> discount_amount = [];
  bool isDetailLoading = false;

  bool flag = false;
  List<Map<String, dynamic>> quotProdItem = [];
////////////////////////////////////////////////////////////////////////////////////////////////////////////
  String rawCalculation(
      double rate,
      int qty,
      double disc_per,
      double disc_amount,
      double tax_per,
      double cess_per,
      String method,
      int state_status,
      int index,
      bool onSub,
      String? disCalc) {
    flag = false;

    print(
        "attribute----$rate----$qty--$tax_per--$disc_per------$disc_amount----$cess_per--$method--$disCalc -");
    if (method == "0") {
      /////////////////////////////////method=="0" - excluisive , method=1 - inclusive
      taxable_rate = rate;
    } else if (method == "1") {
      double percnt = tax_per + cess_per;
      taxable_rate = rate * (1 - (percnt / (100 + percnt)));
      print("exclusive tax....$percnt...$taxable_rate");
    }
    print("exclusive tax......$taxable_rate");
    // qty=qty+1;
    gross = taxable_rate * qty;
    print("gros----$gross");

    if (disCalc == "disc_amt") {
      disc_per = (disc_amount / gross) * 100;
      disc_amt = disc_amount;
      print("discount_prercent---$disc_amount---${discount_prercent.length}");
      if (onSub) {
        discount_prercent[index].text = disc_per.toStringAsFixed(4);
      }
      print("disc_per----$disc_per");
    }

    if (disCalc == "disc_per") {
      print("yes hay---$disc_per");
      disc_amt = (gross * disc_per) / 100;
      if (onSub) {
        discount_amount[index].text = disc_amt.toStringAsFixed(2);
      }
      print("disc-amt----$disc_amt");
    }

    if (disCalc == "qty") {
      disc_amt = double.parse(discount_amount[index].text);
      disc_per = double.parse(discount_prercent[index].text);
      print("disc-amt qty----$disc_amt...$disc_per");
    }

    // if (disCalc == "rate") {
    //   rateController[index].text = taxable_rate.toStringAsFixed(2);
    //   // disc_amt = double.parse(discount_amount[index].text);
    //   // disc_per = double.parse(discount_prercent[index].text);
    //   print("disc-amt qty----$disc_amt...$disc_per");
    // }

    if (state_status == 0) {
      ///////state_status=0--loacal///////////state_status=1----inter-state
      cgst_per = tax_per / 2;
      sgst_per = tax_per / 2;
      igst_per = 0;
    } else {
      cgst_per = 0;
      sgst_per = 0;
      igst_per = tax_per;
    }

    if (disCalc == "") {
      print("inside nothingg.....");
      disc_per = (disc_amount / taxable_rate) * 100;
      disc_amt = disc_amount;
      print("rsr....$disc_per....$disc_amt..");
    }

    tax = (gross - disc_amt) * (tax_per / 100);
    print("tax....$tax....$gross... $disc_amt...$tax_per");
    if (tax < 0) {
      tax = 0.00;
    }
    cgst_amt = (gross - disc_amt) * (cgst_per / 100);
    sgst_amt = (gross - disc_amt) * (sgst_per / 100);
    igst_amt = (gross - disc_amt) * (igst_per / 100);
    cess = (gross - disc_amt) * (cess_per / 100);
    net_amt = ((gross - disc_amt) + tax + cess);
    if (net_amt < 0) {
      net_amt = 0.00;
    }
    print("netamount.cal...$net_amt");

    print(
        "disc_per calcu mod=0..$tax..$gross... $disc_amt...$tax_per-----$net_amt");
    notifyListeners();
    return "success";
  }

  ////////////////////////////////////////////////
  getQuotationFromEnqList(
    BuildContext context,
    String enqId,
  ) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");

          Uri url = Uri.parse("$urlgolabl/get_enq_details.php");
          Map body = {
            'enq_id': enqId,
          };
          isDetailLoading = true;
          notifyListeners();
          print("quot-body----$body");
          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("quot------$map");

          customer_name = map["master"][0]["company_name"];
          cus_info = map["master"][0]["cust_info"];
          phone = map["master"][0]["contact_num"];
          c_person = map["master"][0]["owner_name"];
          landmarked = map["master"][0]["landmark"];
          color1 = map["master"][0]["l_color"];
          color1 = map["master"][0]["l_color"];

          quotProdItem.clear();
          for (var item in map["detail"]) {
            quotProdItem.add(item);
          }
          rateEdit = List.generate(
              quotProdItem.length, (index) => TextEditingController());
          quotqty = List.generate(
              quotProdItem.length, (index) => TextEditingController());
          discount_prercent = List.generate(
              quotProdItem.length, (index) => TextEditingController());
          discount_amount = List.generate(
              quotProdItem.length, (index) => TextEditingController());
          for (int i = 0; i < quotProdItem.length; i++) {
            rateEdit[i].text = quotProdItem[i]["l_rate"];
            quotqty[i].text = quotProdItem[i]["qty"];
            rateEdit[i].text = quotProdItem[i]["l_rate"];
            discount_prercent[i].text = "0.00";
            discount_amount[i].text = "0.00";
          }
          isDetailLoading = false;
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
}
