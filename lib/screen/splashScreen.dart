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
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (Context) {
        if (cid != null) {
          // return DashboardPage();
          if (st_uname != null && st_pwd != null) {
            print("fhhh");
            return EnqHome();
          } else {
            return LoginPage();
          }
        } else {
          return RegistrationScreen();
        }
      }), (route) => false);
      // Navigator.push(
      //     context,
      //     PageRouteBuilder(
      //         opaque: false, // set to false
      //         pageBuilder: (_, __, ___) {

      //           if (cid != null) {
      //             // return DashboardPage();
      //             if (st_uname != null && st_pwd != null) {
      //               print("fhhh");
      //               return EnqHome(

      //               );
      //             } else {
      //               return LoginPage();
      //             }
      //           } else {
      //             return RegistrationScreen();
      //           }
      //         }));
    });
  }

  shared() async {
    var status = await Permission.storage.status;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cid = prefs.getString("cid");
    st_uname = prefs.getString("st_uname");
    st_pwd = prefs.getString("st_pwd");
    if (st_uname != null && st_pwd != null) {
      print("jujuuuu");

      Provider.of<RegistrationController>(context, listen: false)
          .getMenu(context);
      Provider.of<RegistrationController>(context, listen: false)
          .getScheduleList(
        context,
      );
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
    //  navigate();
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
      backgroundColor: P_Settings.loginPagetheme,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: size.height * 0.4,
            ),
            Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  "assets/logo_black_bg.png",
                )),
          ],
        )),
      ),
    );
  }
}
