import 'dart:convert';

import 'package:bestengineer/components/customSnackbar.dart';
import 'package:bestengineer/components/externalDir.dart';
import 'package:bestengineer/components/globaldata.dart';
import 'package:bestengineer/components/networkConnectivity.dart';
import 'package:bestengineer/model/loginModel.dart';
import 'package:bestengineer/model/registrationModel.dart';
import 'package:bestengineer/model/staffDetailsModel.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:bestengineer/screen/registration%20and%20login/login.dart';

import 'package:bestengineer/services/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/datachartModel.dart';

class RegistrationController extends ChangeNotifier {
  bool scheduleOpend = false;
  bool isMenuLoading = false;
  bool isAdminLoading = false;
  bool isServSchedulelIstLoadind = false;
  int scheduleListCount = 0;
  String? pendingEnq;
  String? pendingQtn;
  String? cnfQut;
  String? pendingSer;

  List<String> servceScheduldate = [];
  bool isProdLoding = false;
  DateTime now = DateTime.now();
  String? dateToday;
  int servicescheduleListCount = 0;
  List<Map<String, dynamic>> todyscheduleList = [];
  List<Map<String, dynamic>> tomarwscheduleList = [];

  List<Map<String, dynamic>> servicescheduleList = [];
  List<Map<String, dynamic>> servicesProdList = [];
  List<bool> showComplaint = [];
  bool isSchedulelIstLoadind = false;
  String? staff_name;
  bool isLoading = false;
  bool isLoginLoading = false;
  StaffDetails staffModel = StaffDetails();
  String urlgolabl = Globaldata.apiglobal;
  String commonurlgolabl = Globaldata.commonapiglobal;

  ExternalDir externalDir = ExternalDir();
  String? menu_index;
  String? fp;
  String? cid;
  String? cname;
  String? sof;
  int? qtyinc;
  String? uid;
  List<Map<String, dynamic>> menuList = [];
  List<Map<String, dynamic>> confrmedQuotGraph = [];
  List<Map<String, dynamic>> userservDone = [];
  String? appType;
  String? bId;
  List<CD> c_d = [];
  String? firstMenu;
///////////////////////////////////////////////////////////////////
  Future<RegistrationData?> postRegistration(
      String company_code,
      String? fingerprints,
      String phoneno,
      String deviceinfo,
      BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      print("Text fp...$fingerprints---$company_code---$phoneno---$deviceinfo");
      print("company_code.........$company_code");
      if (company_code.length >= 0) {
        appType = company_code.substring(10, 12);
        print("apptytpe----$appType");
      }
      if (value == true) {
        try {
          Uri url =
              Uri.parse("https://trafiqerp.in/order/fj/get_registration.php");
          Map body = {
            'company_code': company_code,
            'fcode': fingerprints,
            'deviceinfo': deviceinfo,
            'phoneno': phoneno
          };
          print("body----${body}");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          print("body ${body}");
          var map = jsonDecode(response.body);
          print("map register ${map}");
          print("response ${response}");
          RegistrationData regModel = RegistrationData.fromJson(map);

          sof = regModel.sof;
          fp = regModel.fp;
          String? msg = regModel.msg;
          print("fp----- $fp");
          print("sof----${sof}");

          if (sof == "1") {
            print("apptype----$appType");
            if (appType == 'BE') {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              /////////////// insert into local db /////////////////////
              late CD dataDetails;
              String? fp1 = regModel.fp;
              print("fingerprint......$fp1");
              prefs.setString("fp", fp!);
              String? os = regModel.os;
              regModel.c_d![0].cid;
              cid = regModel.cid;
              prefs.setString("cid", cid!);

              cname = regModel.c_d![0].cnme;
              notifyListeners();

              await externalDir.fileWrite(fp1!);

              for (var item in regModel.c_d!) {
                print("ciddddddddd......$item");
                c_d.add(item);
              }
              // verifyRegistration(context, "");

              isLoading = false;
              notifyListeners();

              prefs.setString("os", os!);

              // prefs.setString("cname", cname!);

              String? user = prefs.getString("userType");

              print("fnjdxf----$user");

              await BestEngineer.instance
                  .deleteFromTableCommonQuery("companyRegistrationTable", "");
              var res = await BestEngineer.instance
                  .insertRegistrationDetails(regModel);
              // getMaxSerialNumber(os);
              // getMenuAPi(cid!, fp1, company_code, context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            } else {
              CustomSnackbar snackbar = CustomSnackbar();
              snackbar.showSnackbar(context, "Invalid Apk Key", "");
            }
          }
          /////////////////////////////////////////////////////
          if (sof == "0") {
            CustomSnackbar snackbar = CustomSnackbar();
            snackbar.showSnackbar(context, msg.toString(), "");
          }

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  /////////////////////////////////////////////////////////////////
  Future<StaffDetails?> getLogin(
      String userName, String password, BuildContext context) async {
    var restaff;
    try {
      Uri url = Uri.parse("$urlgolabl/login.php");
      Map body = {'user': userName, 'pass': password};

      isLoginLoading = true;
      notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );
      print("login body ${body}");

      var map = jsonDecode(response.body);
      print("login map ${map}");
      LoginModel loginModel;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (map == null || map.length == 0) {
        CustomSnackbar snackbar = CustomSnackbar();
        snackbar.showSnackbar(context, "Incorrect Username or Password", "");
        isLoginLoading = false;
        notifyListeners();
      } else {
        prefs.setString("st_uname", userName);
        prefs.setString("st_pwd", password);

        for (var item in map) {
          loginModel = LoginModel.fromJson(item);
          prefs.setString("user_id", loginModel.userId!);
          prefs.setString("branch_id", loginModel.branchId!);
          prefs.setString("password", loginModel.pass!);
          prefs.setString("staff_name", loginModel.staffName!);
          prefs.setString("branch_name", loginModel.branchName!);
          prefs.setString("branch_prefix", loginModel.branchPrefix!);
          prefs.setString("mobile_user_type", loginModel.mobile_menu_type!);
          prefs.setString("userGroup", loginModel.usergroup!);
        }
        getMenu(context);
      }

      // print("stafff-------${loginModel.staffName}");
      notifyListeners();
      return staffModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //////////////////////////////////////////////////////////////////
  // Future<StaffDetails?> getStaffDetails(String cid, int index) async {
  //   print("getStaffDetails...............${cid}");
  //   var restaff;
  //   try {
  //     Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_staff.php");
  //     Map body = {
  //       'cid': cid,
  //     };
  //     // isDownloaded = true;
  //     // isCompleted = true;
  //     isLoading = true;
  //     notifyListeners();
  //     http.Response response = await http.post(
  //       url,
  //       body: body,
  //     );
  //     List map = jsonDecode(response.body);
  //     await BestEngineer.instance
  //         .deleteFromTableCommonQuery("staffDetailsTable", "");
  //     print("map ${map}");
  //     for (var staff in map) {
  //       staffModel = StaffDetails.fromJson(staff);
  //       restaff = await BestEngineer.instance.insertStaffDetails(staffModel);
  //     }
  //     print("inserted staff ${restaff}");
  //     // isDownloaded = false;
  //     // isDown[index] = true;
  //     isLoading = false;
  //     notifyListeners();
  //     return staffModel;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

//////////////////////////////////////////////////////////////////////////////
  getMenu(
    BuildContext context,
  ) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          dateToday = DateFormat('dd-MM-yyyy').format(now);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? mobile_menu_type = prefs.getString("mobile_user_type");
          print(" fgfffff---$mobile_menu_type");

          isMenuLoading = true;

          notifyListeners();
          Uri url = Uri.parse("$urlgolabl/get_menu.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
          };
          print("menu body--$body");

          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);

          menu_index = map[0]["menu_index"];
          notifyListeners();

          menuList.clear();
          for (var item in map) {
            menuList.add(item);
          }
          notifyListeners();

          print("jhjkd---$mobile_menu_type");
          if (menuList.length > 0) {
            if (mobile_menu_type == "3") {
              getAdminDashboard(context, dateToday!);
            }
            if (mobile_menu_type == "1") {
              getScheduleList(context, "");
            } else if (mobile_menu_type == "2") {
              getServiceScheduleList(context, "");
            }
          } else {
            CustomSnackbar snackbar = CustomSnackbar();
            snackbar.showSnackbar(
                context, "Oops Something went wrong !!! ", "");
          }

          print("menu res--$map");
          // if (menuList.length > 0) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => EnqHome()),
          //   );
          // }

          // isLoginLoading = false;
          // notifyListeners();
          isMenuLoading = false;
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
  userDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? staff_nam = prefs.getString("staff_name");
    String? branch_nam = prefs.getString("branch_name");

    staff_name = staff_nam;

    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////
  getScheduleList(BuildContext context, String type) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");
          String? mobile_menu_type = prefs.getString("mobile_user_type");
          String? staff_nam = prefs.getString("staff_name");
          Uri url = Uri.parse("$urlgolabl/get_schedule.php");
          Map body = {
            'staff_id': user_id,
          };
          print("schedule list jjj body----$body");
          isSchedulelIstLoadind = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          scheduleListCount = map.length;
          // qtScheduldate = List.generate(newquotationList.length, (index) => "");

          notifyListeners();

          print("schedule list-------$map");
          todyscheduleList.clear();
          tomarwscheduleList.clear();
          for (var item in map) {
            if (item["d_flag"] == "0") {
              todyscheduleList.add(item);
            } else {
              tomarwscheduleList.add(item);
            }
          }
          isSchedulelIstLoadind = false;
          notifyListeners();
          if (type == "") {
            if (mobile_menu_type == "1") {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (Context) {
                return EnqHome(
                  mobile_menu_type: mobile_menu_type,
                );
              }), (route) => false);
            }
          }

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => EnqHome()),
          // );
          print("count------$scheduleListCount");
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  ///////////////////////////////////////////////////////////////////
  getServiceScheduleList(BuildContext context, String type) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");

          Uri url = Uri.parse("$commonurlgolabl/get_scedule_list_service.php");
          Map body = {
            'staff_id': user_id,
          };

          print("service schedule list jjj body----$body");
          isServSchedulelIstLoadind = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          servicescheduleListCount = map["master"].length;
          notifyListeners();

          print("service schedule list-------$map");
          servicescheduleList.clear();
          for (var item in map["master"]) {
            servicescheduleList.add(item);
          }
          showComplaint =
              List.generate(servicescheduleList.length, (index) => false);
          // for (int i = 0; i < servicescheduleList.length; i++) {
          //   servceScheduldate[i] = servicescheduleList[i]["installation_date"];
          // }
          isServSchedulelIstLoadind = false;
          notifyListeners();
          if (type == "") {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (Context) {
              return EnqHome();
            }), (route) => false);
          }

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => EnqHome()),
          // );
          print("count------$scheduleListCount");
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
  saveNextScheduleServiceDate(
      String date, String form_id, String qb_id, BuildContext context) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");

          notifyListeners();
          Uri url =
              Uri.parse("$commonurlgolabl/save_next_schedule_service.php");
          Map body = {
            'staff_id': user_id,
            "staff_name": staff_nam,
            "added_by": user_id,
            "form_id": form_id,
            "next_date": date,
            "qb_id": qb_id,
            "type": "2"
          };

          print("save schedue---service---$body");

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
            getServiceScheduleList(context, "");
          }
          // quotationList.clear();
          // for (var item in map["master"]) {
          //   quotationList.add(item);
          // }
          print("save_next_schedule service----$map");

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

////////////////////////////////////////////////////////////////////////////////////
  getProdFromServiceSchedule(
      String form_id, String qb_id, BuildContext context) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
          String? qutation_id1 = prefs.getString("qutation_id");

          String? staff_nam = prefs.getString("staff_name");
          isProdLoding = true;
          notifyListeners();
          // notifyListeners();
          Uri url = Uri.parse("$commonurlgolabl/fetch_products_serv.php");
          Map body = {
            "form_id": form_id,
            "qb_id": qb_id,
          };

          print("prod schedue---service---$body");

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("fjkdprod----------------------map");
          servicesProdList.clear();
          for (var item in map["product_list"]) {
            servicesProdList.add(item);
          }
          isProdLoding = false;
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
  saveVisitedRemark(
      BuildContext context, String remark, String enq_id, String s_invoice_id) {
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
          Uri url = Uri.parse("$urlgolabl/mark_staff_visit.php");
          Map body = {
            "s_invoice_id": s_invoice_id,
            "enq_id": enq_id,
            "staff_id": user_id,
            "remarks": remark
          };

          print("save remark body---$body");

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("svae remrk----$map");
          if (map["err_status"] == 0) {
            Fluttertoast.showToast(
              msg: "${map["msg"]}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 14.0,
              backgroundColor: Colors.green,
            );

            getScheduleList(context, "");
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

//////////////////////////////////////
  saveCompleteService(BuildContext context, String formId, String qbId,
      String tot, String paid) {
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
          Uri url = Uri.parse("$commonurlgolabl/complete_service.php");

          Map body = {
            'staff_id': user_id,
            "staff_name": staff_nam,
            "added_by": user_id,
            "form_id": formId,
            "qb_id": qbId,
            "total_amount": tot,
            "amount_paid": paid
          };
          isLoading = true;
          notifyListeners();
          print("save complete service----$body");
          var jsonEnc = jsonEncode(body);
          print("jsonEnc--$jsonEnc");
          // isQuotLoading = true;
          // notifyListeners();
          http.Response response = await http.post(
            url,
            body: {'json_data': jsonEnc},
          );
          // http.Response response = await http.post(
          //   url,
          //   body: body,
          // );
          var map = jsonDecode(response.body);
          print("save complete service --$map");
          if (map["flag"] == 0) {
            //  Fluttertoast.showToast(
            //   msg: "${map["msg"]}",
            //   toastLength: Toast.LENGTH_SHORT,
            //   gravity: ToastGravity.CENTER,
            //   timeInSecForIosWeb: 1,
            //   textColor: Colors.white,
            //   fontSize: 14.0,
            //   backgroundColor: Colors.green,
            // );
            getServiceScheduleList(context, "jd");
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

  setMenuIndex(String ind) {
    menu_index = ind;
    // notifyListeners();
  }

///////////////////////////////////////////////////////////////////
  getAdminDashboard(
    BuildContext context,
    String fromdate,
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
          Uri url = Uri.parse("$commonurlgolabl/load_dashboard.php");

          Map body = {
            "from_date": fromdate,
          };
          isAdminLoading = true;
          notifyListeners();
          print("cust body----$body");
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("admin ---$map");
          pendingEnq = map["pending_enq_cnt"];
          pendingQtn = map["pending_qtn_cnt"];
          cnfQut = map["cnfrm_qtn_cnt"];
          pendingSer = map["pending_serv_cnt"];
          notifyListeners();
          for (var item in map['user_cnt_cnfrmd']) {
            print("nnnn----${item.runtimeType}");
            double m = double.parse(item['measure']);
            var mapzz = {"domain": item["domain"], "measure": m};
            confrmedQuotGraph.add(mapzz);
          }
          userservDone.clear();
          for (var item in map['user_serv_done']) {
            print("nnnn----${item.runtimeType}");
            double m = double.parse(item['measure']);
            var mapzz = {"domain": item["domain"], "measure": m};
            userservDone.add(mapzz);
          }
          notifyListeners();
          isAdminLoading = false;
          notifyListeners();
          print("admin map----$confrmedQuotGraph");
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (Context) {
            return EnqHome();
          }), (route) => false);
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

///////////////////////////////////////////////////////////////////////////////////////////////
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
            getScheduleList(context, "type");
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

  ////////////////////////////////////////////////////
  saveNextScheduleDate(String date, String inv_id, String enq_id,
      BuildContext context, String qtno) {
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
          // if (map["flag"] == 0) {
          //   print("jkxd");
          // }
          // quotationList.clear();
          // for (var item in map["master"]) {
          //   quotationList.add(item);
          // }
          print("save_next_schedule ----$map");
          if (map["flag"] == 0) {
            Fluttertoast.showToast(
              msg: "$qtno Schedule date changed to $date",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 14.0,
              backgroundColor: Colors.green,
            );
            getScheduleList(context, "type");
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
