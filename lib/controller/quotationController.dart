import 'dart:convert';

import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/components/networkConnectivity.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../screen/Quotation/pdfPrev.dart';

class QuotationController extends ChangeNotifier {
  String urlgolabl = Globaldata.apiglobal;
  String? customer_name;
  String? c_person;
  String? phone;
  String? cus_info;
  String? priority;
  String? landmarked;
  String? color1;
  String? cust_id;

  double total = 0.0;
  double stotal_qty = 0.0;
  double s_total_taxable = 0.0;
  double s_total_disc = 0.0;
  bool fromApi = true;

  bool isQuotLoading = false;

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
  List<Map<String, dynamic>> quotationList = [];

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
          priority = map["master"][0]["priority"];
          cust_id = map["master"][0]["cust_id"];

          customer_name = map["master"][0]["company_name"];
          cus_info = map["master"][0]["cust_info"];
          phone = map["master"][0]["contact_num"];
          c_person = map["master"][0]["owner_name"];
          landmarked = map["master"][0]["landmark"];
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
          total = 0.0;
          s_total_disc = 0.0;
          s_total_taxable = 0.0;
          stotal_qty = 0.0;

          print("quotProdItem----$quotProdItem");
          for (int i = 0; i < quotProdItem.length; i++) {
            rateEdit[i].text = quotProdItem[i]["l_rate"];
            quotqty[i].text = quotProdItem[i]["qty"];
            // rateEdit[i].text = quotProdItem[i]["l_rate"];
            discount_prercent[i].text = quotProdItem[i]["disc"];
            discount_amount[i].text = quotProdItem[i]["disc_amt"];
            total = total + double.parse(quotProdItem[i]["net_total"]);
            s_total_disc =
                s_total_disc + double.parse(quotProdItem[i]["disc_amt"]);
            stotal_qty = stotal_qty + double.parse(quotProdItem[i]["qty"]);
            s_total_taxable =
                s_total_taxable + double.parse(quotProdItem[i]["tax_amt"]);
          }

          print("heyyy------$total");
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

  //////////////////////////////////////////////////////////////////////////////////////
  updateQuotationData(
      BuildContext context,
      String event,
      String p_id,
      String qty,
      String enq_id,
      String s_rate,
      String tax_per,
      String tax_amt,
      String disc_per,
      String disc_amt,
      String net_total,
      String gross) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print(
              "details quot----------------$p_id----$qty---$enq_id---$s_rate---$tax_per---$tax_amt---$disc_per---$disc_amt----$net_total");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          Uri url = Uri.parse("$urlgolabl/save_tmp_qtn.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'event': event,
            'product_id': p_id,
            'qty': qty,
            'enq_id': enq_id,
            's_rate': s_rate,
            'tax_perc': tax_per,
            'tax_amt': tax_amt,
            'discount_perc': disc_per,
            'disc_amt': disc_amt,
            'net_total': net_total,
            'gross': gross,
          };
          // String jsone = json.encode(body);
          // isDetailLoading = true;
          // notifyListeners();
          print("update quot-body----$body");
          var map;
          http.Response response = await http.post(
            url,
            body: body,
          );
          // if (response.body.isNotEmpty) {
          map = jsonDecode(response.body);
          // }
          // jsonDecode(response.body);

          print("update quot------${map}");

          getQuotationFromEnqList(context, enq_id);

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print("error...$e");
          // return null;
          return [];
        }
      }
    });
  }

  /////////////////////////////////////////////////////////////////////////
  saveQuotation(BuildContext context, String? remark, String sdate, String rwid,
      String enq_id) async {
    List<Map<String, dynamic>> jsonResult = [];
    Map<String, dynamic> itemmap = {};
    Map<String, dynamic> resultmmap = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? branch_id = prefs.getString("branch_id");
    String? user_id = prefs.getString("user_id");
    String? qt_pre = prefs.getString("qt_pre");

    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        Uri url = Uri.parse(
            "https://trafiqerp.in/webapp/beste/common_api/op_qutation_form.php");

        jsonResult.clear();
        itemmap.clear();

        for (var i = 0; i < quotProdItem.length; i++) {
          var itemmap = {
            "product_id": quotProdItem[i]["product_id"],
            "product_name": quotProdItem[i]["product_name"],
            "description": quotProdItem[i]["product_info"],
            "qty": quotProdItem[i]["product_name"],
            "rate": quotProdItem[i]["l_rate"],
            "tax": quotProdItem[i]["tax_amt"],
            "amount": quotProdItem[i]["gross"],
            "discount_perc": quotProdItem[i]["disc"],
            "discount_amount": quotProdItem[i]["disc_amt"],
            "net_rate": quotProdItem[i]["net_total"],
          };
          jsonResult.add(itemmap);
        }
        print("jsonResult----$jsonResult");
        Map masterMap = {
          "enq_id": enq_id,
          "s_customer_id": cust_id,
          "s_customer_name": customer_name,
          "s_invoice_date": sdate,
          "s_reference": remark,
          "l_id": priority,
          "hidden_status": "0",
          "tot_qty": stotal_qty,
          "s_total_dicount": s_total_disc,
          "s_total_taxable": s_total_taxable,
          "s_total_net_amount": total.toStringAsFixed(2),
          "added_by": user_id,
          "row_id": rwid,
          "branch_id": branch_id,
          "dflag": "1",
          "qt_pre": qt_pre,
          "details": jsonResult
        };

        print("resultmap----$masterMap");
        // var body = {'json_data': masterMap};
        // print("body-----$body");

        var jsonEnc = jsonEncode(masterMap);

        print("jsonEnc-----$jsonEnc");

        http.Response response = await http.post(
          url,
          body: {'json_data': jsonEnc},
        );
        var map = jsonDecode(response.body);
        print("quot map----$map");
        prefs.setString("qutation_id", map["qutation_id"].toString());
        return showDialog(
            context: context,
            builder: (ct) {
              Size size = MediaQuery.of(ct).size;

              Future.delayed(Duration(seconds: 2), () {
                // Navigator.of(context).pop(true);

                Navigator.of(ct).pop(true);

                if (map["flag"] == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfPreviewPage(),
                    ),
                  );
                }

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

  /////////////////////////////////////////////////
  createPdf(BuildContext context, String qutation_id) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");
          notifyListeners();
          Uri url = Uri.parse("$urlgolabl/get_menu.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'qutation_id': qutation_id1
          };
          print("pdf body----$body");

          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("map ----$map");
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  ////////////////////////////////////////////////////////////////////////
  getQuotationList(BuildContext context, String qutation_id) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");
          notifyListeners();
          Uri url = Uri.parse("$urlgolabl/get_menu.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
          };
          print("pdf body----$body");
          isQuotLoading = true;
          notifyListeners();
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("map ----$map");
          quotationList.clear();
          for (var item in map) {
            quotationList.add(item);
          }
          isQuotLoading = false;
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
