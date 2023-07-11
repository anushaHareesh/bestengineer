import 'dart:convert';
import 'dart:io';
import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/components/networkConnectivity.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:bestengineer/screen/Quotation/testPage.dart';
import 'package:bestengineer/screen/sale%20order/pending_sale_order.dart';
import 'package:bestengineer/widgets/alertCommon/pending_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../components/dateFind.dart';
import '../screen/Quotation/pdfPrev.dart';
import '../screen/Quotation/pdfQuotation.dart';
import '../widgets/alertCommon/customerPopup.dart';
import '../widgets/alertCommon/set_schedule_date_popup.dart';

class QuotationController extends ChangeNotifier {
  String? todaydate;
  String? qt_pre;
  String? staffSelId;
  bool isLoading = false;
  String? reportdealerselected;
  String? enq_id;
  String? area;
  int? sivd;
  bool isPendingListLoading = false;
  double sale_order_net_amt = 0.0;
  bool ispdfOpend = false;
  bool isQuotSearch = false;
  bool isReportLoading = false;
  bool saleOrderLoading = false;
  bool isSchedulelIstLoadind = false;
  String? dealerselected;
  String commonurlgolabl = Globaldata.commonapiglobal;
  bool isChatLoading = false;
  String? fromDate;
  String? todate;
  List<Container> listWidget = [];
  String? branchselected;
  List<Map<String, dynamic>> branchList = [
    {"id": "0", "value": "kannur"},
    {"id": "1", "value": "Kozhikode"},
  ];
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
  String? staffSelected;
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
  List<Map<String, dynamic>> staff_list = [];

  bool isDetailLoading = false;

  bool flag = false;
  // List<Map<String, dynamic>> enqSceheduleQuotLIST = [];
  List<Map<String, dynamic>> quotProdItem = [];
  List<Map<String, dynamic>> userwiseReportList = [];
  List<Map<String, dynamic>> topItemList = [];
  List<Map<String, dynamic>> customerwiseReport = [];
  List<Map<String, dynamic>> adminDashTileDetail = [];
  List<Map<String, dynamic>> enqScheduleList = [];
  List<Map<String, dynamic>> confrimedQuotList = [];
  String? selected;
  List<Map<String, dynamic>> masterPdf = [];
  List<Map<String, dynamic>> detailPdf = [];
  List<Map<String, dynamic>> termsPdf = [];
  List<Map<String, dynamic>> msgLogsPdf = [];

  List<Map<String, dynamic>> dealerList = [];
  List<Map<String, dynamic>> quotationList = [];
  List<Map<String, dynamic>> newquotationList = [];
  List<Map<String, dynamic>> serviceChatList = [];
  List<Map<String, dynamic>> reportDealerList = [];
  List<Map<String, dynamic>> dealerwiseProductList = [];
  List<Map<String, dynamic>> areaWiseReportList = [];
  List<Map<String, dynamic>> pendingSaleOrder = [];
  List<Map<String, dynamic>> quotationEditList = [];
  List<Map<String, dynamic>> dealerwiseReportList = [];
  List<Map<String, dynamic>> saleOrderDetails = [];
  List<Map<String, dynamic>> pendingServiceList = [];
  List<Map<String, dynamic>> pendingQuotationList = [];
  List<Map<String, dynamic>> saleOrderList = [];

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

    print("attribute----$rate----$qty-- $tax_per---");
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
          qt_pre = map["master"][0]["qt_pre"];
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
          enq_id = map["master"][0]["enq_id"];
          area = map["master"][0]["area_id"];

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
  removePrdctEnq(BuildContext context, String prdt_id, String enq, String rowId,
      String type) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          String rId;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          Uri url = Uri.parse(
              "https://trafiqerp.in/webapp/beste/common_api/remove_pdt.php");
          if (type == "1") {
            rId = enq;
          } else {
            rId = rowId;
          }
          Map body = {
            'row_id': rId,
            'prdt_id': prdt_id,
            'hidden_status': "4",
            "type": type
          };
          // String jsone = json.encode(body);
          // isDetailLoading = true;
          // notifyListeners();
          print("remove pdt- body----$body");
          var map;
          http.Response response = await http.post(
            url,
            body: body,
          );

          map = jsonDecode(response.body);
          print("remove pdt------${map}");

          if (map["flag"] == 0) {
            if (type == "1") {
              getQuotationFromEnqList(context, enq);
            } else if (type == "2") {
              quotationEdit(
                context,
                rowId,
                enq,
              );
            }
          }
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

  /////////////////////////////////////////////////////////////////////////
  saveQuotation(BuildContext context, String? remark, String sdate, int rwid,
      String enq_id, String type, String hiddenstatus, String br) async {
    List<Map<String, dynamic>> jsonResult = [];
    Map<String, dynamic> itemmap = {};
    Map<String, dynamic> resultmmap = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? branch_id = prefs.getString("branch_id");
    String? user_id = prefs.getString("user_id");

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
        print("save quot resultmap----$masterMap");
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
                      builder: (context) =>
                          PdfPreviewPage(br: br, id: sivd.toString()),
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

  /////////////////////////////////////////////////////
  editQuotation(
    BuildContext context,
    String? remark,
    int rwid,
    String type,
    String hiddenstatus,
    String pr_id,
    String pr_name,
    String pr_info,
    String qty,
    String l_rate,
    String tax_perc,
    String disc_perc,
    String disc_amnt,
  ) async {
    List<Map<String, dynamic>> jsonResult = [];
    Map<String, dynamic> itemmap = {};
    Map<String, dynamic> resultmmap = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? branch_id = prefs.getString("branch_id");
    String? user_id = prefs.getString("user_id");

    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        Uri url = Uri.parse(
            "https://trafiqerp.in/webapp/beste/common_api/op_qutation_form.php");
        jsonResult.clear();
        var itemmap = {
          "product_id": pr_id,
          "product_name": pr_name,
          "description": pr_info,
          "qty": qty,
          "rate": l_rate,
          "tax": tax,
          "tax_perc": tax_perc,
          "amount": gross,
          "discount_perc": disc_perc,
          "discount_amount": disc_amnt,
          "net_rate": net_amt,
        };
        jsonResult.add(itemmap);

        print("jsonResult----$jsonResult");
        ///////////////////////////////////////////////////////////
        // s_total_disc = s_total_disc + double.parse(disc_amnt);
        // stotal_qty = stotal_qty + double.parse(qty);
        // s_total_taxable = s_total_taxable + tax;
        // total = total + net_amt;

        Map masterMap = {
          "company_add1": cus_info,
          "phone_1": phone,
          "phone_2": phone2,
          "company_pin": company_pin,
          "owner_name": c_person,
          "enq_id": enId,
          "s_customer_id": cust_id,
          "s_customer_name": customer_name,
          "s_invoice_date": qt_date,
          "s_reference": remark,
          "l_id": priority,
          "hidden_status": "3",
          "tot_qty": qty,
          "s_total_dicount": disc_amnt,
          "s_total_taxable": tax,
          "s_total_net_amount": net_amt.toStringAsFixed(2),
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
        print("edit quot map----$map");
        if (map["flag"] == 0) {
          Fluttertoast.showToast(
            msg: "${pr_name} Inserted Successfully...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 14.0,
            backgroundColor: Colors.green,
          );
        }
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

          msgLogsPdf.clear();
          for (var item in map["msg_log"]) {
            msgLogsPdf.add(item);
          }
          // quotation1.generate(detailPdf, masterPdf, termsPdf);
          isPdfLoading = false;
          // generateInvoice();
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
          // print("qutationlist map ----$quotationList");
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
  // setScheduledDate(int index, String date, BuildContext context, String enq_id,
  //     String invId, String qtNo) async {
  //   qtScheduldate[index] = date;
  //   notifyListeners();
  //   print("jxkjjjj---${qtScheduldate[index]}");
  //   saveNextScheduleDate(qtScheduldate[index], invId, enq_id, context, qtNo);
  //   notifyListeners();
  // }

  //////////////////////////////////////////////////////////////
  quotationEdit(BuildContext context, String row_id, String enqId) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");
          String? userGp = prefs.getString("userGroup");

          notifyListeners();
          Uri url = Uri.parse(
              "https://trafiqerp.in/webapp/beste/common_api/edit_qutation_master.php");
          Map body = {'row_id': row_id, "enq_id": enqId, "usergroup": userGp};
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
          landmarked = map["master"][0]["landmark"];
          landmarked = map["master"][0]["landmark"];

          // qt_pre = map["master"][0]["landmark"];

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

          print("quotationEditList----$quotationEditList");
          for (int i = 0; i < quotationEditList.length; i++) {
            rateEdit[i].text = quotationEditList[i]["l_rate"];
            quotqty[i].text = quotationEditList[i]["qty"];
            // rateEdit[i].text = quotProdItem[i]["l_rate"];
            discount_prercent[i].text = quotationEditList[i]["disc"];
            discount_amount[i].text = quotationEditList[i]["disc_amt"];
            total = total + double.parse(quotationEditList[i]["net_total"]);
            print("from edit ---$total");
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
  // saveNextScheduleDate(String date, String inv_id, String enq_id,
  //     BuildContext context, String qtno) {
  //   NetConnection.networkConnection(context).then((value) async {
  //     if (value == true) {
  //       try {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         String? branch_id = prefs.getString("branch_id");
  //         String? user_id = prefs.getString("user_id");
  //         String? qutation_id1 = prefs.getString("qutation_id");

  //         String? staff_nam = prefs.getString("staff_name");

  //         notifyListeners();
  //         Uri url = Uri.parse(
  //             "https://trafiqerp.in/webapp/beste/common_api/save_next_schedule.php");
  //         Map body = {
  //           'staff_id': user_id,
  //           "staff_name": staff_nam,
  //           "added_by": user_id,
  //           "s_invoice_id": inv_id,
  //           "next_date": date,
  //           "enq_id": enq_id,
  //         };

  //         print("save schedue----$body");

  //         var jsonEnc = jsonEncode(body);
  //         print("jsonEnc--$jsonEnc");
  //         // isQuotLoading = true;
  //         // notifyListeners();
  //         http.Response response = await http.post(
  //           url,
  //           body: {'json_data': jsonEnc},
  //         );
  //         var map = jsonDecode(response.body);
  //         if (map["flag"] == "0") {
  //         //  getEnquirySchedule(c);
  //         }
  //         // quotationList.clear();
  //         // for (var item in map["master"]) {
  //         //   quotationList.add(item);
  //         // }
  //         print("save_next_schedule ----$map");
  //         if (map["flag"] == 0) {
  //           Fluttertoast.showToast(
  //             msg: "$qtno Schedule date changed to $date",
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.CENTER,
  //             timeInSecForIosWeb: 1,
  //             textColor: Colors.white,
  //             fontSize: 14.0,
  //             backgroundColor: Colors.green,
  //           );
  //         }
  //         // isQuotLoading = false;
  //         // notifyListeners();
  //       } catch (e) {
  //         print(e);
  //         // return null;
  //         return [];
  //       }
  //     }
  //   });
  // }

  //////////////////////////////////////////////

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

  ///////////////////////////////////////
  setReportDealerDrop(String s) {
    for (int i = 0; i < reportDealerList.length; i++) {
      print("com------${reportDealerList[i]["c_id"]}---$s");
      if (reportDealerList[i]["c_id"] == s) {
        reportdealerselected = reportDealerList[i]["company_name"];
        print("reportdealerselected---$reportdealerselected");
        // notifyListeners();
      }
    }
    print("s------$s");
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////
  setBranchDrop(String s) {
    for (int i = 0; i < branchList.length; i++) {
      if (branchList[i]["id"] == s) {
        branchselected = branchList[i]["value"];
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
      if (list["cname"].toString().toLowerCase().contains(item.toLowerCase()) ||
          list["qt_no"].contains(item)) newquotationList.add(list);
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

//////////////////////////////////////////////////////////////////////
  Future<void> generateInvoice() async {
    var imgBytes =
        (await rootBundle.load("assets/burger.jpg")).buffer.asUint8List();
    var img = (await rootBundle.load("assets/noImg.png")).buffer.asUint8List();
    final PdfDocument document = PdfDocument();

    PdfPage page = document.pages.add();

    final Size pageSize = page.getClientSize();
    double headerH = 50;
    double footerH = 120;
    double gridH = pageSize.height - (headerH + footerH);

    final PdfPageTemplateElement headerTemplate =
        PdfPageTemplateElement(Rect.fromLTWH(0, 0, pageSize.width, headerH));
    //Add page to the PDF
    //Get page client size

    headerTemplate.graphics.drawImage(
        PdfBitmap(img),
        Rect.fromLTWH(0, 0, page.getClientSize().width,
            page.getClientSize().height * 0.4));

    document.template.top = headerTemplate;
    //Generate PDF grid.
    final PdfGrid grid = getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult? result = drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid, result!);

    PdfGraphics graphics = page.graphics;

    double x = (pageSize.width / 2) - 30;

    double y = (pageSize.height / 2) - 50;
    print("page size-------${pageSize.height}----${{pageSize.width}}");
    graphics.save();

    graphics.translateTransform(x, y);

    graphics.setTransparency(0.25);

    graphics.rotateTransform(0);

    graphics.drawImage(PdfBitmap(imgBytes), Rect.fromLTWH(0, 0, 40, 50));

    graphics.restore();

    final PdfPageTemplateElement footerTemplate =
        PdfPageTemplateElement(Rect.fromLTWH(0, 0, pageSize.width, footerH));
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 8);
    final String tem = '${termsPdf[0]["t_head"]} : ';
    final Size temcontentSize = contentFont.measureString(tem);

    final String temd = "${termsPdf[0]["t_detail"].toString()}";

    final Size temdcontentSize = contentFont.measureString(temd);

    footerTemplate.graphics.drawImage(
        PdfBitmap(img),
        Rect.fromLTWH(0, temdcontentSize.height + 40,
            page.getClientSize().width, page.getClientSize().height * 0.4));
    footerTemplate.graphics.drawString(
      "${termsPdf[0]["t_head"]} : ",
      PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTWH(0, 5, temcontentSize.width + 30, 30),
    );

    footerTemplate.graphics.drawString("${termsPdf[0]["t_detail"].toString()}",
        PdfStandardFont(PdfFontFamily.helvetica, 9),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(
            temcontentSize.width + 30, 5, 380, temdcontentSize.height + 30),
        format: PdfStringFormat(alignment: PdfTextAlignment.justify));

    document.template.bottom = footerTemplate;

    final List<int> bytes = document.saveSync();
    //Dispose the document.
    document.dispose();
    //Save and launch the file.
    await saveAndLaunchFile(bytes, 'Invoice1.pdf');
  }

  //Draws the invoice header
  PdfLayoutResult? drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    page.graphics.drawString(
      "QUOTATION",
      PdfStandardFont(PdfFontFamily.helvetica, 15,
          style: PdfFontStyle.underline),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTWH((pageSize.width / 2) - 40, 5, 500, 30),
    );

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

    final PdfPen linePen =
        PdfPen(PdfColor(0, 0, 0), dashStyle: PdfDashStyle.custom);
    // linePen.dashPattern = <double>[3, 3];
    //Draw line
    // page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
    //     Offset(pageSize.width, pageSize.height - 100));
    final String qtNumber =
        'Quotation No    :  ${masterPdf[0]["s_invoice_no"]}';
    final String cusName =
        'Customer          :  ${masterPdf[0]["s_customer_name"]}';
    final String address =
        'Address            :  ${masterPdf[0]["company_add1"]}';
    final String date = 'Date      :  ${masterPdf[0]["qdate"]}';
    final String phone = 'Phone   :  ${masterPdf[0]["phone_1"]}';
    final String mobile = 'Mobile   :  ${masterPdf[0]["phone_2"]}';
    final Size qtcontentSize = contentFont.measureString(qtNumber);
    final Size cuscontentSize = contentFont.measureString(cusName);
    final Size addcontentSize = contentFont.measureString(address);
    final Size datecontentSize = contentFont.measureString(date);
    final Size phcontentSize = contentFont.measureString(phone);
    final Size mobcontentSize = contentFont.measureString(mobile);

    PdfTextElement(text: qtNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 50, qtcontentSize.width + 30, pageSize.height - 100));
    PdfTextElement(text: date, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(
            380, 50, datecontentSize.width + 30, pageSize.height - 100));
    PdfTextElement(text: cusName, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 65, cuscontentSize.width + 30, pageSize.height - 100));
    PdfTextElement(text: phone, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(
            380, 65, phcontentSize.width + 30, pageSize.height - 100));
    PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 80, addcontentSize.width + 30, pageSize.height - 100));

    return PdfTextElement(text: mobile, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(
            380, 80, mobcontentSize.width + 30, pageSize.height - 100));

    // return PdfTextElement(text: address, font: contentFont).draw(
    //     page: page,
    //     bounds: Rect.fromLTWH(30, 120,
    //         pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

////////////////////////////////////////////////////////////////////////////////////////

  PdfGrid getGrid() {
    PdfGridStyle gridStyle = PdfGridStyle(
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(
        PdfFontFamily.helvetica,
        7,
      ),
    );

    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 9);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style

    // headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(197, 197, 197));
    headerRow.style.textBrush = PdfBrushes.black;
    headerRow.cells[0].value = 'Sl No';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;

    headerRow.cells[1].value = 'Product Name';
    headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;

    headerRow.cells[2].value = 'Qty';
    headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.center;

    headerRow.cells[3].value = 'Rate';
    headerRow.cells[3].stringFormat.alignment = PdfTextAlignment.center;

    headerRow.cells[4].value = 'Amt';
    headerRow.cells[4].stringFormat.alignment = PdfTextAlignment.center;

    headerRow.cells[5].value = 'Disc';
    headerRow.cells[5].stringFormat.alignment = PdfTextAlignment.center;

    headerRow.cells[6].value = 'GST%';
    headerRow.cells[6].stringFormat.alignment = PdfTextAlignment.center;

    headerRow.cells[7].value = 'GST';
    headerRow.cells[7].stringFormat.alignment = PdfTextAlignment.center;

    headerRow.cells[8].value = 'Net Amt';
    headerRow.cells[8].stringFormat.alignment = PdfTextAlignment.center;

    grid.rows.applyStyle(gridStyle);

    for (int i = 0; i < 60; i++) {
      addProducts(
          "$i", "jxzjjh", "2", "234", "6557", "23", "23", "34", "885", grid);

      // print(
      //     "datatype---------------------${detailPdf[i]["tax_perc"].runtimeType}----${detailPdf[i]["tax"].runtimeType}");

      // addProducts(
      //     detailPdf[i]["product_id"],
      //     detailPdf[i]["product_name"],
      //     detailPdf[i]["qty"],
      //     detailPdf[i]["rate"],
      //     detailPdf[i]["amount"],
      //     detailPdf[i]["discount_amount"],
      //     detailPdf[i]["tax_perc"].toString(),
      //     detailPdf[i]["tax"].toString(),
      //     detailPdf[i]["net_rate"].toString(),
      //     grid);
    }

    grid.columns[1].width = 160;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];

      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (i == grid.rows.count - 1) {
          grid.rows[i].cells[j].style.borders.bottom = PdfPens.black;
        } else {
          grid.rows[i].cells[j].style.borders.bottom = PdfPens.transparent;
        }
        grid.rows[i].cells[j].style.borders.top = PdfPens.transparent;

        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

////////////////////////////////////////////////////////////
  void addProducts(
      String productId,
      String productName,
      String qty,
      String rate,
      String amount,
      String discamt,
      String gstper,
      String gstamt,
      String netrate,
      PdfGrid grid) {
    PdfBorders border = PdfBorders(
        left: PdfPen(PdfColor(0, 0, 0), width: 1),
        top: PdfPen(PdfColor(100, 100, 100), width: 1),
        bottom: PdfPen(PdfColor(100, 100, 100), width: 1),
        right: PdfPen(PdfColor(0, 0, 0), width: 1));

    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = productId;
    row.cells[0].stringFormat.alignment = PdfTextAlignment.center;

    row.cells[1].value = productName;
    row.cells[1].stringFormat.alignment = PdfTextAlignment.left;

    row.cells[2].value = qty.toString();
    row.cells[2].stringFormat.alignment = PdfTextAlignment.right;

    row.cells[3].value = rate.toString();
    row.cells[3].stringFormat.alignment = PdfTextAlignment.right;

    row.cells[4].value = amount.toString();
    row.cells[4].stringFormat.alignment = PdfTextAlignment.right;

    row.cells[5].value = discamt.toString();
    row.cells[5].stringFormat.alignment = PdfTextAlignment.right;

    row.cells[6].value = gstper.toString();
    row.cells[6].stringFormat.alignment = PdfTextAlignment.right;

    row.cells[7].value = gstamt.toString();
    row.cells[7].stringFormat.alignment = PdfTextAlignment.right;

    row.cells[8].value = netrate.toString();
    row.cells[8].stringFormat.alignment = PdfTextAlignment.right;
    // PdfLayoutFormat format = PdfLayoutFormat(
    //     // breakType: PdfLayoutBreakType.fitColumnsToPage,
    //     layoutType: PdfLayoutType.paginate);
    // if (productId == null &&
    //     productName == null &&
    //     qty == null &&
    //     rate == null &&
    //     amount == null &&
    //     discamt == null &&
    //     gstper == null &&
    //     netrate == null) {
    //   row.cells[7].value = "Total";
    //   row.cells[7].stringFormat.alignment = PdfTextAlignment.right;
    //   row.cells[8].value = getTotalAmount(grid);
    //   row.cells[8].stringFormat.alignment = PdfTextAlignment.right;
    // }
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    ispdfOpend = true;
    notifyListeners();
    OpenFilex.open('$path/$fileName');
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    print("bound bottom------${result.bounds.bottom}");
    result = grid.draw(
        page: result.page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 20, 0, 0))!;

    result.page.graphics.drawString('Grand Total  : ',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            350, result.bounds.bottom + 10, 300, quantityCellBounds!.height));
    result.page.graphics.drawString(r'$' + getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            420, result.bounds.bottom + 10, 300, totalPriceCellBounds!.height));
  }

  double getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value =
          grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return total;
  }

  ////////////////////////////////////////////////////////////////////
  getPreviousChat(String form_id, String qb_id, BuildContext context) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          isChatLoading = true;
          notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$commonurlgolabl/fetch_prev_serv_remrk.php");
          Map body = {
            "form_id": form_id,
            "qb_id": qb_id,
          };

          print("chat---service---$body");

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("chat service map----$map");
          serviceChatList.clear();
          for (var item in map["ser_remrk"]) {
            serviceChatList.add(item);
          }
          isChatLoading = false;
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  /////////////////////////////////////////////////////////
  saveServiceChat(
      String form_id, String qb_id, String remark, BuildContext context) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$commonurlgolabl/save_service_remarks.php");
          Map body = {
            "form_id": form_id,
            "qb_id": qb_id,
            "added_by": user_id,
            "remarks": remark
          };

          print("save chat---$body");

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("svae chat map----$map");
          if (map["flag"] == 0) {
            getPreviousChat(form_id, qb_id, context);
          }
          // isChatLoading = false;
          // notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  ///////////////////////////////////
  setDate(String date1, String date2) {
    fromDate = date1;
    todate = date2;
    print("gtyy----$fromDate----$todate");
    notifyListeners();
  }

  /////////////////////////////////////////////////////
  getReportDealerList(BuildContext context, String type) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$urlgolabl/dealer_list.php");

          Map body = {"type": type};

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);

          reportDealerList.clear();
          for (var item in map) {
            reportDealerList.add(item);
          }
          print("reportDealerList----$reportDealerList");
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  /////////////////////////////////////////////////////////////
  getDealerWiseProduct(
      BuildContext context, String fromdate, String tilldate, String dealerId) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$urlgolabl/dealer_wise_prdt.php");

          Map body = {
            "dealer_id": dealerId,
            "from_date": fromdate,
            "till_date": tilldate,
          };
          isLoading = true;
          notifyListeners();
          print("repoprtbjnmn body-----$body");
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("repoprtbjnmn body---- map----$map");
          dealerwiseProductList.clear();
          for (var item in map) {
            dealerwiseProductList.add(item);
          }
          isLoading = false;
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

  /////////////////////////////////////////////////////////
  getDealerWiseReport(
    BuildContext context,
    String fromdate,
    String tilldate,
  ) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$urlgolabl/dealer_wise_rpt.php");

          Map body = {
            "from_date": fromdate,
            "till_date": tilldate,
          };
          isLoading = true;
          notifyListeners();
          print("dealer body-----$body");
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("dealerWise map---- map----$map");
          dealerwiseReportList.clear();
          for (var item in map) {
            dealerwiseReportList.add(item);
          }
          isLoading = false;
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

  //////////////////////////////////////////////////
  getUserWiseReport(
    BuildContext context,
  ) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$urlgolabl/userwise_rpt.php");

          // Map body = {
          //   "from_date": fromdate,
          //   "till_date": tilldate,
          // };
          isLoading = true;
          notifyListeners();
          // print("dealer body-----$body");
          http.Response response = await http.post(
            url,
            // body: body,
          );
          var map = jsonDecode(response.body);
          print("userwise map---- map----$map");
          userwiseReportList.clear();
          for (var item in map) {
            userwiseReportList.add(item);
          }
          isLoading = false;
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

  //////////////////////////////////////////////////
  getTopItemListReport(
    BuildContext context,
  ) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$urlgolabl/top_items_rpt.php");

          // Map body = {
          //   "from_date": fromdate,
          //   "till_date": tilldate,
          // };
          isLoading = true;
          notifyListeners();
          // print("dealer body-----$body");
          http.Response response = await http.post(
            url,
            // body: body,
          );
          var map = jsonDecode(response.body);
          print("topItem map---- map----$map");
          topItemList.clear();
          for (var item in map) {
            topItemList.add(item);
          }
          isLoading = false;
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

  ///////////////////////////////////////////
  getCustomerwiseReport(
      BuildContext context, String fromdate, String tilldate, String custid) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$urlgolabl/customer_wise_rpt.php");

          Map body = {
            "cust_id": custid,
            "from_date": fromdate,
            "till_date": tilldate,
          };
          isLoading = true;
          notifyListeners();
          print("cust body----$body");
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          customerwiseReport.clear();
          for (var item in map) {
            customerwiseReport.add(item);
          }
          print("cust --- body---- map----$customerwiseReport");

          isLoading = false;
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

  ///////////////////////////////////////////////////
  getAdminDashTile(BuildContext context, String tileId) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$commonurlgolabl/load_dashboard_detail.php");

          Map body = {"sf": tileId.toString()};
          isLoading = true;
          notifyListeners();
          print("dashtile----$body");
          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);

          adminDashTileDetail.clear();
          for (var item in map["data"]) {
            adminDashTileDetail.add(item);
          }
          print("dashtile-------${adminDashTileDetail}");

          isLoading = false;
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

  //////////////////////////////////////////////////////
  getEnquirySchedule(BuildContext context) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$urlgolabl/get_schedule_enq.php");

          Map body = {"staff_id": user_id};
          isLoading = true;
          notifyListeners();
          print("enq schedle---$body");
          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);

          enqScheduleList.clear();
          for (var item in map) {
            enqScheduleList.add(item);
          }
          print("enq schedule-- map-----${enqScheduleList}");

          isLoading = false;
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  ////////////////////////////////////////////////////////
  saveNextEnqSchedule(
      BuildContext context, String date, String enqId, String cus) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$commonurlgolabl/save_next_schedule_enq.php");

          Map body = {
            "staff_id": user_id,
            "staff_name": staff_nam,
            "added by": user_id,
            "next_date": date,
            "enq_id": enqId
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
          print("save enq schedule----${map}");
          if (map["flag"] == 0) {
            getEnquirySchedule(context);
            Fluttertoast.showToast(
              msg: "( $enqId - $cus ) Schedule date changed to $date",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 14.0,
              backgroundColor: Colors.green,
            );
          }
          // enqScheduleList.clear();
          // for (var item in map) {
          //   enqScheduleList.add(item);
          // }

          // isLoading = false;
          // notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  ///////////////////////////////////////////////////////
  getAreaWiseReport(
      BuildContext context, String? talukId, String? area, String panId) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$commonurlgolabl/area_wise_report.php");

          Map body = {
            "thaluk_id": talukId,
            "area_id": area,
            "type": "1",
            "pch_id": panId
          };
          isLoading = true;
          notifyListeners();
          print("area wise report body---$body");
          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("area wise report map---$map");

          areaWiseReportList.clear();
          String? cid;
          listWidget.clear();
          for (var item in map) {
            if (cid != item["c_id"]) {
              print("com---${item["company_name"]}");
              listWidget.add(Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        item["company_name"].toString().toUpperCase(),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ));
              cid = item["c_id"];
            }
            print("item----${item["product_name"]}");
            listWidget.add((Container(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: Text(
                            item["product_name"],
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "Qty : ",
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[500]),
                          ),
                          Flexible(
                              child: Text(
                            item["qty"],
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )));

            // areaWiseReportList.add(item);
          }

          isLoading = false;
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  ////////////////////////////////////////////////////////////////
  confirmQuotation(
      BuildContext context, String invId, String enqId, String type) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$commonurlgolabl/conform_qt.php");

          Map body = {
            "added_by": user_id,
            "s_invoice_id": invId,
            "enq_id": enqId
          };
          String jsonEnc = jsonEncode(body);
          isLoading = true;
          notifyListeners();
          print("confrm quot  $body");
          http.Response response = await http.post(
            url,
            body: {'json_data': jsonEnc},
          );

          var map = jsonDecode(response.body);
          print("confirm quot map-----${map}");
          if (map["flag"] == 0) {
            Fluttertoast.showToast(
              msg: "Quotation ${map['msg']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 14.0,
              backgroundColor: Colors.green,
            );
            getQuotationList(context);
          }

          isLoading = false;
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

////////////////////////////////////////////////////////////////////
  getConfirmedQuotation(String fdate, String tillDate, BuildContext context) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          isReportLoading = true;
          notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$urlgolabl/confirmed_quotaton_rpt.php");
          Map body = {
            "staff_id": user_id,
            "from_date": fdate,
            "till_date": tillDate,
          };

          print("confirmd---quot---$body");

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("confirmd  map----$map");

          confrimedQuotList.clear();
          for (var item in map) {
            confrimedQuotList.add(item);
          }
          print("confirmd quotation map----$confrimedQuotList");
          isReportLoading = false;
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }
////////////////////////////////////////////////////////////////////
  // enquiryScheduleQuotationMake(BuildContext context, String enqId) {
  //   NetConnection.networkConnection(context).then((value) async {
  //     if (value == true) {
  //       try {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         String? branch_id = prefs.getString("branch_id");
  //         String? user_id = prefs.getString("user_id");
  //         String? qutation_id1 = prefs.getString("qutation_id");
  //         notifyListeners();

  //         Uri url = Uri.parse("$urlgolabl/get_enq_details.php");
  //         Map body = {
  //           'enq_id': enqId,
  //         };

  //         print("qutationlistedit  b----$body");
  //         isQuotEditLoading = true;
  //         notifyListeners();
  //         http.Response response = await http.post(url, body: body);
  //         var map = jsonDecode(response.body);
  //         print("enq schedule qutationlis ----$map");
  //         priority = map["master"][0]["priority"];
  //         cust_id = map["master"][0]["cust_id"];
  //         company_pin = map["master"][0]["company_pin"];
  //         phone2 = map["master"][0]["phone_2"];
  //         customer_name = map["master"][0]["company_name"];
  //         cus_info = map["master"][0]["cust_info"];
  //         phone = map["master"][0]["contact_num"];
  //         c_person = map["master"][0]["owner_name"];
  //         landmarked = map["master"][0]["landmark"];
  //         color1 = map["master"][0]["l_color"];

  //         enqSceheduleQuotLIST.clear();

  //         for (var item in map["detail"]) {
  //           enqSceheduleQuotLIST.add(item);
  //         }
  //         print("details--------$quotationEditList");

  //         rateEdit = List.generate(
  //             enqSceheduleQuotLIST.length, (index) => TextEditingController());
  //         quotqty = List.generate(
  //             enqSceheduleQuotLIST.length, (index) => TextEditingController());
  //         discount_prercent = List.generate(
  //             enqSceheduleQuotLIST.length, (index) => TextEditingController());
  //         discount_amount = List.generate(
  //             enqSceheduleQuotLIST.length, (index) => TextEditingController());
  //         total = 0.0;
  //         s_total_disc = 0.0;
  //         s_total_taxable = 0.0;
  //         stotal_qty = 0.0;

  //         print("quotProdItem----$quotationEditList");
  //         for (int i = 0; i < enqSceheduleQuotLIST.length; i++) {
  //           rateEdit[i].text = enqSceheduleQuotLIST[i]["l_rate"];
  //           quotqty[i].text = enqSceheduleQuotLIST[i]["qty"];
  //           // rateEdit[i].text = quotProdItem[i]["l_rate"];
  //           discount_prercent[i].text = enqSceheduleQuotLIST[i]["disc"];
  //           discount_amount[i].text = enqSceheduleQuotLIST[i]["disc_amt"];
  //           total = total + double.parse(enqSceheduleQuotLIST[i]["net_total"]);
  //           s_total_disc = s_total_disc +
  //               double.parse(enqSceheduleQuotLIST[i]["disc_amt"]);
  //           stotal_qty =
  //               stotal_qty + double.parse(enqSceheduleQuotLIST[i]["qty"]);
  //           s_total_taxable = s_total_taxable +
  //               double.parse(enqSceheduleQuotLIST[i]["tax_amt"]);
  //         }
  //         isQuotEditLoading = false;
  //         notifyListeners();
  //       } catch (e) {
  //         print(e);
  //         // return null;
  //         return [];
  //       }
  //     }
  //
  // }
  getPendingSaleOrder(BuildContext context, String fromdate, String tilldate) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$commonurlgolabl/fetch_pending_sale_order.php");
          Map body = {
            "from_date": fromdate,
            "till_date": tilldate,
          };
          isLoading = true;
          notifyListeners();
          print("cust body----$body");
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("pendingSaleOrder--$map");
          pendingSaleOrder.clear();
          for (var item in map["so_list"]) {
            pendingSaleOrder.add(item);
          }
          print("pendingSaleOrder--$pendingSaleOrder");

          isLoading = false;
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

/////////////////////////////////////////////////////
  viewSaleOrder(BuildContext context, String fromdate, String tilldate) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? user_id = prefs.getString("user_id");

          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$commonurlgolabl/view_sale_order.php");
          Map body = {
            "user_id": user_id,
            "from_date": fromdate,
            "till_date": tilldate,
          };
          isLoading = true;
          notifyListeners();
          print("view SO body----$body");
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("so map----$map");
          saleOrderList.clear();
          for (var item in map["so_list"]) {
            saleOrderList.add(item);
          }
          print("saleOrderList--$saleOrderList");

          isLoading = false;
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

  //////////////////////////////////////////////////
  getSaleOrderDetails(BuildContext context, String qtn) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          sale_order_net_amt = 0.0;
          // isChatLoading = true;
          // notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$commonurlgolabl/fetch_sale_order_detail.php");
          Map body = {"so_id": qtn};
          saleOrderLoading = true;
          notifyListeners();
          print("fetch sale order body--$body");
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("fetch sale order map--$map");
          saleOrderDetails.clear();
          for (var item in map["so_list_detl"]) {
            saleOrderDetails.add(item);
            sale_order_net_amt =
                sale_order_net_amt + double.parse(item["net_rate"]);
          }
          print("fetch sale order map--${saleOrderDetails.length}");

          saleOrderLoading = false;
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

//////////////////////////////////////////////////////////////////////
  approveSaleOrder(BuildContext context, String qtn, String soId) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");

          Uri url = Uri.parse("$commonurlgolabl/approve_sale_order.php");
          Map body = {"added_by": user_id, "so_id": soId, "qtn_id": qtn};
          String jsonEnc = jsonEncode(body);
          isLoading = true;
          notifyListeners();
          print("confrm quot  $body");
          http.Response response = await http.post(
            url,
            body: {'json_data': jsonEnc},
          );
          var map = jsonDecode(response.body);
          if (map["flag"] == 0) {
            Fluttertoast.showToast(
              msg: "${map["msg"]}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 14.0,
              backgroundColor: Colors.green,
            );
            // Navigator.pop(context);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (Context) {
              return EnqHome(
                type: "return from sale order",
              );
            }), (route) => false);
          }

          saleOrderLoading = false;
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

  ///////////////////////////////////////////////////
  getCount(BuildContext context, String date) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");

          Uri url = Uri.parse("$commonurlgolabl/get_count.php");
          // Uri url =
          //     Uri.parse("https://192.168.18.4/beste/common_api/get_count.php");

          Map body = {"f_date": date, "added_by": user_id};
          print("getcount--------$body");
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("get count map----${map}");

          int cnt = int.parse(map["cnt"]);
          if (cnt > 0) {
            getTodaysPendingList(context, date);
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

  ///////////////////////////////////////////////////////////////////////////////////////
  getTodaysPendingList(BuildContext context, String date) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("todsy  pen---");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          Map body = {"f_date": date, "added_by": user_id};
          Uri url = Uri.parse("$commonurlgolabl/load_todays_pending.php");
          isPendingListLoading = true;
          notifyListeners();
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("load_todays_pending map----$map");
          if (map["qtns"].length > 0) {
            pendingQuotationList.clear();
            // for (int i = 0; i <4; i++) {
            //   pendingQuotationList.add({
            //     's_invoice_id': '21',
            //     's_invoice_no': 'KNR/0001-01',
            //     'days': '21',
            //     'to_staff': 'BYJU',
            //     'company_name': ' IDEAL REFINERS LLP',
            //     'enq_id': '0',
            //     'next_date': '13-05-2023',
            //     'status': '1',
            //     'schedule_to': '50'
            //   });
            // }
            for (var item in map["qtns"]) {
              pendingQuotationList.add(item);
            }
            print("pendingQuotationList--------$pendingQuotationList");
          }
          if (map["services"].length > 0) {
            pendingServiceList.clear();
            // for (int i = 0; i < 2; i++) {
            // // pendingServiceList.add(
            // //   {
            // //     "c_id": ' 1',
            // //     'series': 'CM0001',
            // //     'type': 'AKSHAY PRADEEP-[Service]',
            // //     'form_id': '29',
            // //     'to_staff': 'SMITHA',
            // //     'flg': '2',
            // //     'ser_date': '17-05-2023',
            // //     'ser_staff': '58'
            // //   },
            // // );
            // }
            for (var item in map["services"]) {
              pendingServiceList.add(item);
            }
            print("pendingServiceList--------$pendingServiceList");
          }
          isPendingListLoading = false;
          notifyListeners();
          if (pendingQuotationList.length > 0 ||
              pendingServiceList.length > 0) {
            PendingList pendingList = PendingList();
            pendingList.buildPendingPopup(context, MediaQuery.of(context).size);
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

  //////////////////////////////////////////////////////
  getStaffs(BuildContext context, String to_staff) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        DateFind dateFind = DateFind();
        String? todaydate;
        try {
          todaydate = DateFormat('dd-MM-yyyy').format(DateTime.now());
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");

          Uri url = Uri.parse("$commonurlgolabl/get_staffs.php");
          // Uri url =
          //     Uri.parse("https://192.168.18.4/beste/common_api/get_count.php");

          http.Response response = await http.post(
            url,
          );
          var map = jsonDecode(response.body);
          print("get_staffs map----${map}");
          staff_list.clear();
          for (var item in map) {
            staff_list.add(item);
          }
          print("staff_list======$staff_list");
          if (map != null) {
            // staffSelected = to_staff.toString();
            for (var item in staff_list) {
              if (to_staff == item["NAME"]) {
                staffSelId = item["USERS_ID"];
              }
              ;
            }
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

////////////////////////////////////////////////////////////////
  setStaffSelected(String s) {
    for (int i = 0; i < staff_list.length; i++) {
      print("com------${staff_list[i]["USERS_ID"]}---$s");
      if (staff_list[i]["USERS_ID"] == s) {
        staffSelected = staff_list[i]["NAME"];
        print("staffSelected---$staffSelected");
        // notifyListeners();
      }
    }
    print("s------$s");
    notifyListeners();
  }

////////////////////////////////////////////////////////////////
  saveNextScheduleServiceDate(String date, String form_id, String qb_id,
      BuildContext context, String st_id) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          todaydate = DateFormat('dd-MM-yyyy').format(now);

          Uri url =
              Uri.parse("$commonurlgolabl/save_next_schedule_service.php");
          Map body = {
            'staff_id': st_id,
            "staff_name": staff_nam,
            "added_by": user_id,
            "form_id": form_id,
            "next_date": date,
            "qb_id": qb_id,
            "type": "1"
          };

          print("save fffffff schedue---service---$body");
          var jsonEnc = jsonEncode(body);
          print("jsonEnc--$jsonEnc");
          // isQuotLoading = true;
          // notifyListeners();
          http.Response response = await http.post(
            url,
            body: {'json_data': jsonEnc},
          );
          var map = jsonDecode(response.body);
          print("ffffff---${map}");
          if (map["flag"] == 0) {
            Fluttertoast.showToast(
              msg: "${map["msg"]}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 14.0,
              backgroundColor: Colors.green,
            );
            getTodaysPendingList(context, todaydate!);
            Navigator.pop(context);
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

  saveNextScheduleDate(String date, String inv_id, String enq_id,
      BuildContext context, String staff_id) {
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
            'staff_id': staff_id,
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

          print("save_next_schedule ----$map");
          if (map["flag"] == 0) {
            Fluttertoast.showToast(
              msg: map["msg"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 14.0,
              backgroundColor: Colors.green,
            );
            getTodaysPendingList(context, todaydate!);
            Navigator.pop(context);
          }
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
}
