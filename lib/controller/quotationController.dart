import 'dart:convert';

import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/components/networkConnectivity.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../screen/Quotation/pdfPrev.dart';
import '../screen/Quotation/pdfQuotation.dart';

class QuotationController extends ChangeNotifier {
  String? todaydate;
  int? sivd;
  bool isQuotSearch = false;
  bool isSchedulelIstLoadind = false;
  String? dealerselected;
  DateTime now = DateTime.now();
  String urlgolabl = Globaldata.apiglobal;
  String? enId;
  String? customer_name;
  String? company_pin;
  String? phone2;
  String? qt_date;
  String? s_reference;
  String? c_person;
  String? phone;
  bool isQuotEditLoading = false;
  String? cus_info;
  String? priority;
  String? landmarked;
  String? color1;
  String? cust_id;
  List<String> qtScheduldate = [];
  double total = 0.0;
  double stotal_qty = 0.0;
  double s_total_taxable = 0.0;
  double s_total_disc = 0.0;
  bool fromApi = true;
  bool isPdfLoading = false;

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
  List<Map<String, dynamic>> masterPdf = [];
  List<Map<String, dynamic>> detailPdf = [];
  List<Map<String, dynamic>> termsPdf = [];
  List<Map<String, dynamic>> dealerList = [];
  List<Map<String, dynamic>> quotationList = [];
  List<Map<String, dynamic>> newquotationList = [];

  List<Map<String, dynamic>> quotationEditList = [];

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

    print("attribute----$rate----$qty--  cccc  $tax_per---");
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
          company_pin = map["master"][0]["company_pin"];
          phone2 = map["master"][0]["phone_2"];
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
      String gross,
      String type,
      String row_id) async {
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
          if (type == "add") {
            getQuotationFromEnqList(context, enq_id);
          } else if (type == "edit") {
            quotationEdit(context, row_id, enq_id);
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

  /////////////////////////////////////////////////////////////////////////
  saveQuotation(BuildContext context, String? remark, String sdate, int rwid,
      String enq_id, String type, String hiddenstatus) async {
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
        if (type == "add") {
          print("xjdjkfhjd------$quotProdItem");
          for (var i = 0; i < quotProdItem.length; i++) {
            var itemmap = {
              "product_id": quotProdItem[i]["product_id"],
              "product_name": quotProdItem[i]["product_name"],
              "description": quotProdItem[i]["product_info"],
              "qty": quotProdItem[i]["qty"],
              "rate": quotProdItem[i]["l_rate"],
              "tax": quotProdItem[i]["tax_amt"],
              "tax_perc": quotProdItem[i]["tax_perc"],
              "amount": quotProdItem[i]["gross"],
              "discount_perc": quotProdItem[i]["disc"],
              "discount_amount": quotProdItem[i]["disc_amt"],
              "net_rate": quotProdItem[i]["net_total"],
            };
            jsonResult.add(itemmap);
          }
        } else if (type == "edit") {
          print("save ediot quot quotationEditList-----$quotationEditList");
          for (var i = 0; i < quotationEditList.length; i++) {
            var itemmap = {
              "product_id": quotationEditList[i]["product_id"],
              "product_name": quotationEditList[i]["product_name"],
              "description": quotationEditList[i]["product_info"],
              "qty": quotationEditList[i]["qty"],
              "rate": quotationEditList[i]["l_rate"],
              "tax": quotationEditList[i]["tax_amt"],
              "tax_perc": quotationEditList[i]["tax_perc"],
              "amount": quotationEditList[i]["gross"],
              "discount_perc": quotationEditList[i]["disc"],
              "discount_amount": quotationEditList[i]["disc_amt"],
              "net_rate": quotationEditList[i]["net_total"],
            };
            jsonResult.add(itemmap);
          }
        }

        print("jsonResult----$jsonResult");
        Map masterMap = {
          "company_add1": cus_info,
          "phone_1": phone,
          "phone_2": phone2,
          "company_pin": company_pin,
          "owner_name": c_person,
          "enq_id": enq_id,
          "s_customer_id": cust_id,
          "s_customer_name": customer_name,
          "s_invoice_date": sdate,
          "s_reference": remark,
          "l_id": priority,
          "hidden_status": hiddenstatus,
          "tot_qty": stotal_qty,
          "s_total_dicount": s_total_disc,
          "s_total_taxable": s_total_taxable,
          "s_total_net_amount": total.toStringAsFixed(2),
          "added_by": user_id,
          "row_id": rwid,
          "branch_id": branch_id,
          "dflag": "1",
          "qt_pre": qt_pre,
          "tnc": [],
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
        print("fgfg-------${map["qutation_id"].runtimeType}");
        sivd = map["qutation_id"];
        prefs.setString("qutation_id", map["qutation_id"].toString());
        return showDialog(
            context: context,
            builder: (ct) {
              Size size = MediaQuery.of(ct).size;

              Future.delayed(Duration(seconds: 2), () {
                // Navigator.of(context).pop(true);

                Navigator.of(ct).pop(true);

                if (map["flag"] == 0) {
                  // getPdfData(context, sivd.toString());
               
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
  getPdfData(BuildContext context, String invoice_id) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          PdfQuotation quotation1 = PdfQuotation();
          Uri url = Uri.parse("$urlgolabl/print_data.php");
          Map body = {
            's_invoice_id': invoice_id,
          };
          print("pdf body----$body");
          isPdfLoading = true;
          notifyListeners();
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("pdf map ----$map");
          masterPdf.clear();
          for (var item in map["master"]) {
            masterPdf.add(item);
          }
          print("masrerrr---$masterPdf");
          detailPdf.clear();
          for (var item in map["details"]) {
            detailPdf.add(item);
          }

          termsPdf.clear();
          for (var item in map["terms_condtions"]) {
            termsPdf.add(item);
          }
          quotation1.generate(detailPdf, masterPdf, termsPdf);
          isPdfLoading = false;
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

  ////////////////////////////////////////////////////////////////////////
  getQuotationList(
    BuildContext context,
  ) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          todaydate = DateFormat('dd-MM-yyyy').format(now);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");
          notifyListeners();
          Uri url = Uri.parse(
              "https://trafiqerp.in/webapp/beste/common_api/get_qutation_list.php");
          Map body = {
            'staff_id': user_id,
          };
          print("qutationlist b----$body");
          isQuotLoading = true;
          notifyListeners();
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);

          print("qutationlistllllll ----$map");

          quotationList.clear();
          for (var item in map["master"]) {
            quotationList.add(item);
          }
          dealerList.clear();
          for (var item in map["dealer"]) {
            dealerList.add(item);
          }
          print("qutationlist map ----$quotationList");
          qtScheduldate = List.generate(quotationList.length, (index) => "");

          for (int i = 0; i < quotationList.length; i++) {
            if (quotationList[i]["sdate"] == "00-00-0000") {
              qtScheduldate[i] = todaydate.toString();
            } else {
              qtScheduldate[i] = quotationList[i]["sdate"];
            }
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

  ///////////////////////////////////////////////////////////
  setScheduledDate(int index, String date, BuildContext context, String enq_id,
      String invId) async {
    qtScheduldate[index] = date;
    notifyListeners();
    print("jxkjjjj---${qtScheduldate[index]}");
    saveNextScheduleDate(
      qtScheduldate[index],
      invId,
      enq_id,
      context,
    );
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////
  quotationEdit(BuildContext context, String row_id, String enqId) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");
          notifyListeners();
          Uri url = Uri.parse(
              "https://trafiqerp.in/webapp/beste/common_api/edit_qutation_master.php");
          Map body = {'row_id': row_id, "enq_id": enqId, "usergroup": ""};
          print("qutationlistedit  b----$body");
          isQuotEditLoading = true;
          notifyListeners();
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("qutationliseditttt map ----$map");
          priority = map["master"][0]["priority"];
          cust_id = map["master"][0]["s_customer_id"];
          company_pin = map["master"][0]["company_pin"];
          phone2 = map["master"][0]["phone_2"];
          customer_name = map["master"][0]["customer_name"];
          cus_info = map["master"][0]["company_add1"];
          phone = map["master"][0]["phone_1"];
          c_person = map["master"][0]["owner_name"];
          s_reference = map["master"][0]["s_reference"];
          qt_date = map["master"][0]["qt_date"];
          enId = map["master"][0]["enq_id"];
          color1 = map["master"][0]["l_color"];

          quotationEditList.clear();

          for (var item in map["details"]) {
            quotationEditList.add(item);
          }
          print("details--------$quotationEditList");

          rateEdit = List.generate(
              quotationEditList.length, (index) => TextEditingController());
          quotqty = List.generate(
              quotationEditList.length, (index) => TextEditingController());
          discount_prercent = List.generate(
              quotationEditList.length, (index) => TextEditingController());
          discount_amount = List.generate(
              quotationEditList.length, (index) => TextEditingController());
          total = 0.0;
          s_total_disc = 0.0;
          s_total_taxable = 0.0;
          stotal_qty = 0.0;

          print("quotProdItem----$quotationEditList");
          for (int i = 0; i < quotationEditList.length; i++) {
            rateEdit[i].text = quotationEditList[i]["l_rate"];
            quotqty[i].text = quotationEditList[i]["qty"];
            // rateEdit[i].text = quotProdItem[i]["l_rate"];
            discount_prercent[i].text = quotationEditList[i]["disc"];
            discount_amount[i].text = quotationEditList[i]["disc_amt"];
            total = total + double.parse(quotationEditList[i]["net_total"]);
            s_total_disc =
                s_total_disc + double.parse(quotationEditList[i]["disc_amt"]);
            stotal_qty = stotal_qty + double.parse(quotationEditList[i]["qty"]);
            s_total_taxable =
                s_total_taxable + double.parse(quotationEditList[i]["tax_amt"]);
          }
          isQuotEditLoading = false;
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

///////////////////////////////////////////////////
  setQtDate(String da) {
    qt_date = da;
    notifyListeners();
  }

////////////////////////////////////////////////
  saveNextScheduleDate(
      String date, String inv_id, String enq_id, BuildContext context) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");

          notifyListeners();
          Uri url = Uri.parse(
              "https://trafiqerp.in/webapp/beste/common_api/save_next_schedule.php");
          Map body = {
            'staff_id': user_id,
            "staff_name": staff_nam,
            "added_by": user_id,
            "s_invoice_id": inv_id,
            "next_date": date,
            "enq_id": enq_id,
          };

          print("save schedue----$body");

          var jsonEnc = jsonEncode(body);
          print("jsonEnc--$jsonEnc");
          // isQuotLoading = true;
          // notifyListeners();
          http.Response response = await http.post(
            url,
            body: {'json_data': jsonEnc},
          );
          var map = jsonDecode(response.body);
          if (map["flag"] == 0) {
            getQuotationList(
              context,
            );
          }
          // quotationList.clear();
          // for (var item in map["master"]) {
          //   quotationList.add(item);
          // }
          print("save_next_schedule ----$map");

          // isQuotLoading = false;
          // notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  /////////////////////////////////////////////
  setDealerDrop(String s) {
    for (int i = 0; i < dealerList.length; i++) {
      if (dealerList[i]["customer_id"] == s) {
        dealerselected = dealerList[i]["company_name"];
      }
    }
    print("s------$s");
    notifyListeners();
  }

//////////////////////////////////////////////////////////////////////////////////////
  deleteQuotation(BuildContext context, String? dealerName, String? dealerId,
      String remark, String invId) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");

          notifyListeners();
          Uri url = Uri.parse(
              "https://trafiqerp.in/webapp/beste/common_api/remove_qutation.php");
          Map body = {
            'staff_id': user_id,
            "dealer_name": dealerName,
            "dealer_id": dealerId,
            "added_by": user_id,
            "s_invoice_id": invId,
            "cancel_remark": remark
          };

          var jsonEnc = jsonEncode(body);
          print("jsonEnc--$jsonEnc");
          // isQuotLoading = true;
          // notifyListeners();
          http.Response response = await http.post(
            url,
            body: {'json_data': jsonEnc},
          );
          var map = jsonDecode(response.body);
          if (map["flag"] == 0) {
            getQuotationList(
              context,
            );
          }
          // quotationList.clear();
          // for (var item in map["master"]) {
          //   quotationList.add(item);
          // }
          print("dealerCance ----$map");

          // isQuotLoading = false;
          // notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

/////////////////////////////////////////////////////////////////////
  searchQuotationList(String item) {
    print("quo--$item--$quotationList");
    newquotationList.clear();
    quotationList.forEach((list) {
      if (list["cname"].contains(item) || list["qt_no"].contains(item))
        newquotationList.add(list);
    });
    qtScheduldate = List.generate(newquotationList.length, (index) => "");

    for (int i = 0; i < newquotationList.length; i++) {
      if (newquotationList[i]["sdate"] == "00-00-0000") {
        qtScheduldate[i] = todaydate.toString();
      } else {
        qtScheduldate[i] = newquotationList[i]["sdate"];
      }
    }

    print("newquot----$newquotationList");
    notifyListeners();
  }

  setQuotSearch(bool val) {
    isQuotSearch = val;
    notifyListeners();
  }
  ////////////////////////////////////////////////////////////////////
}
