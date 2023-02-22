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

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends ChangeNotifier {
  bool scheduleOpend = false;
  bool isMenuLoading = false;
  int scheduleListCount = 0;
  List<Map<String, dynamic>> scheduleList = [];
  bool isSchedulelIstLoadind = false;
  String? staff_name;
  bool isLoading = false;
  bool isLoginLoading = false;
  StaffDetails staffModel = StaffDetails();
  String urlgolabl = Globaldata.apiglobal;
  ExternalDir externalDir = ExternalDir();
  String? menu_index;
  String? fp;
  String? cid;
  String? cname;
  String? sof;
  int? qtyinc;
  String? uid;
  List<Map<String, dynamic>> menuList = [];
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
          prefs.setString("qt_pre", loginModel.qt_pre!);

          prefs.setString("staff_name", loginModel.staffName!);
          prefs.setString("branch_name", loginModel.branchName!);
          prefs.setString("branch_prefix", loginModel.branchPrefix!);
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
  Future<StaffDetails?> getStaffDetails(String cid, int index) async {
    print("getStaffDetails...............${cid}");
    var restaff;
    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_staff.php");
      Map body = {
        'cid': cid,
      };
      // isDownloaded = true;
      // isCompleted = true;
      isLoading = true;
      notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );
      List map = jsonDecode(response.body);
      await BestEngineer.instance
          .deleteFromTableCommonQuery("staffDetailsTable", "");
      print("map ${map}");
      for (var staff in map) {
        staffModel = StaffDetails.fromJson(staff);
        restaff = await BestEngineer.instance.insertStaffDetails(staffModel);
      }
      print("inserted staff ${restaff}");
      // isDownloaded = false;
      // isDown[index] = true;
      isLoading = false;
      notifyListeners();
      return staffModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

//////////////////////////////////////////////////////////////////////////////
  getMenu(
    BuildContext context,
  ) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? branch_id = prefs.getString("branch_id");
          String? user_id = prefs.getString("user_id");
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
          getScheduleList(context);
          print("menu res--$map");
          // if (menuList.length > 0) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => EnqHome()),
          //   );
          // }

          isLoginLoading = false;
          notifyListeners();
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
  getScheduleList(
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
          notifyListeners();

          print("schedule list-------$map");
          scheduleList.clear();
          for (var item in map) {
            scheduleList.add(item);
          }
          isSchedulelIstLoadind = false;
          notifyListeners();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EnqHome(rebuild: true,)),
          );
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
}
