import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:bestengineer/screen/registration%20and%20login/login.dart';
import 'package:bestengineer/screen/registration%20and%20login/registration.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? cid;
  String? st_uname;
  String? st_pwd;

  navigate() async {
    await Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      cid = prefs.getString("cid");
      st_uname = prefs.getString("st_uname");
      st_pwd = prefs.getString("st_pwd");
      String? mobile_menu_type = prefs.getString("mobile_user_type");
      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) {
                if (cid != null) {
                  if (st_uname != null && st_pwd != null) {
                     
                    return EnqHome(
                      mobile_menu_type: mobile_menu_type,
                    );
                  } else {
                    return LoginPage();
                  }
                } else {
                  return RegistrationScreen();
                }
              }));
    });
  }

  shared() async {
    var status = await Permission.storage.status;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cid = prefs.getString("cid");
    st_uname = prefs.getString("st_uname");
    st_pwd = prefs.getString("st_pwd");
    String? mobile_menu_type = prefs.getString("mobile_user_type");

    if (st_uname != null && st_pwd != null) {
      print("jujuuuu");

      Provider.of<RegistrationController>(context, listen: false)
          .getMenu(context);
      // if (mobile_menu_type == "1" || mobile_menu_type == "3") {
      //   Provider.of<RegistrationController>(context, listen: false)
      //       .getScheduleList(context, "");
      // } else if (mobile_menu_type == "2") {
      //   print("kjdfkdf");
      //   Provider.of<RegistrationController>(context, listen: false)
      //       .getServiceScheduleList(context, "");
      // }

      if (Provider.of<RegistrationController>(context, listen: false)
              .isMenuLoading ==
          false) {
        navigate();
      }
    } else {
      print("kjxjkxd");
      navigate();
    }
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // fp = prefs.getString("fp");
    // print("fingerPrint......$fp");

    // if (com_cid != null) {
    //   Provider.of<AdminController>(context, listen: false)
    //       .getCategoryReport(com_cid!);
    //   Provider.of<Controller>(context, listen: false).adminDashboard(com_cid!);
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<RegistrationController>(context, listen: false)
    //     .getMenu(context);
    shared();
    // navigate();
    // if (Provider.of<RegistrationController>(context, listen: false)
    //         .isMenuLoading ==
    //     false) {
    //   navigate();
    // }
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: P_Settings.loginPagetheme,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
            child: Column(
          children: [
            // SizedBox(
            //   height: size.height * 0.4,
            // ),
            Expanded(
              child: Container(
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    "assets/logo.png",
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "VEGA BUSINESS SOFTWARE",
                    style: TextStyle(
                        // color: P_Settings.loginPagetheme,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  )
                  // Container(
                  //     height: 50,
                  //     // width: 150,
                  //     child: Image.asset(
                  //       "assets/logo_black_bg.png",
                  //     )),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
