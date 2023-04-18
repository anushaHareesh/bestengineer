import 'dart:io';

import 'package:bestengineer/controller/registrationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/commonColor.dart';
import '../../controller/controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier<bool> visible = ValueNotifier(false);

  ValueNotifier<bool> _isObscure = ValueNotifier(true);
  // bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RegistrationController>(context, listen: false).isLoginLoading =
        false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: P_Settings.whiteColor,
          body: SafeArea(
            child: SingleChildScrollView(
              // reverse: true,
              child: Consumer<RegistrationController>(
                builder: (context, value, child) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: size.height * 0.1,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0.0, top: 40),
                          child: Container(
                            height: 400,
                            width: 300,
                            child: SvgPicture.asset(
                              "assets/login.svg",
                              height: 300,
                            ),
                          ),
                        ),
                        Text(
                          "Login",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.loginPagetheme,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.007,
                        ),
                        Text(
                          "Login to your account",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: P_Settings.loginPagetheme,
                          ),
                        ),
                        // SizedBox(
                        //   height: size.height * 0.19,
                        // ),
                        customTextField(
                            "Username", controller1, "username", context),
                        customTextField(
                            "Password", controller2, "password", context),
                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: Container(
                            width: size.width * 0.4,
                            height: size.height * 0.055,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  var result;

                                  if (_formKey.currentState!.validate()) {
                                    Provider.of<RegistrationController>(context,
                                            listen: false)
                                        .getLogin(controller1.text,
                                            controller2.text, context);
                                   
                                  }
                                },
                                label: Text(
                                  "Login",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: P_Settings.whiteColor,
                                  ),
                                ),
                                icon: value.isLoginLoading
                                    ? Container(
                                        width: 24,
                                        height: 24,
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircularProgressIndicator(
                                          color: P_Settings.whiteColor,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Icon(
                                        Icons.arrow_back,
                                        color: P_Settings.whiteColor,
                                      ),
                                style: ElevatedButton.styleFrom(
                                  primary: P_Settings.loginPagetheme,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15), // <-- Radius
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ValueListenableBuilder(
                            valueListenable: visible,
                            builder:
                                (BuildContext context, bool v, Widget? child) {
                              print("value===${visible.value}");
                              return Visibility(
                                visible: v,
                                child: Text(
                                  "Incorrect Username or Password!!!",
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            })
                      ],
                    ),
                  );
                },
              ),
            ),
          )),
    );
  }

  ///////////////////////////////////////////////////////

  Widget customTextField(String hinttext, TextEditingController controllerValue,
      String type, BuildContext context) {
    double topInsets = MediaQuery.of(context).viewInsets.top;
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.09,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: ValueListenableBuilder(
          valueListenable: _isObscure,
          builder: (context, value, child) {
            return TextFormField(
              style: TextStyle(color: P_Settings.loginPagetheme),
              // textCapitalization: TextCapitalization.characters,
              obscureText: type == "password" ? _isObscure.value : false,
              scrollPadding:
                  EdgeInsets.only(bottom: topInsets + size.height * 0.34),
              controller: controllerValue,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: type == "password"
                      ? Icon(
                          Icons.password,
                          color: P_Settings.loginPagetheme,
                        )
                      : Icon(
                          Icons.person,
                          color: P_Settings.loginPagetheme,
                        ),
                  suffixIcon: type == "password"
                      ? IconButton(
                          icon: Icon(
                            _isObscure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: P_Settings.loginPagetheme,
                          ),
                          onPressed: () {
                            _isObscure.value = !_isObscure.value;
                            print("_isObscure $_isObscure");
                          },
                        )
                      : null,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: P_Settings.lightPurple, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: P_Settings.lightPurple,
                      width: 2.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.red,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      )),
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: P_Settings.loginPagetheme,
                  ),
                  hintText: hinttext.toString()),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Please Enter ${hinttext}';
                }
                return null;
              },
            );
          },
        ),
      ),
    );
  }

  // Widget customTextField(String hinttext, TextEditingController controllerValue,
  //     String type, BuildContext context) {
  //   double topInsets = MediaQuery.of(context).viewInsets.top;
  //   Size size = MediaQuery.of(context).size;
  //   return Container(
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: ValueListenableBuilder(
  //         valueListenable: _isObscure,
  //         builder: (context, value, child) {
  //           return TextFormField(

  //             // textCapitalization: TextCapitalization.characters,
  //             obscureText: type == "password" ? _isObscure.value : false,
  //             scrollPadding:
  //                 EdgeInsets.only(bottom: topInsets + size.height * 0.34),
  //             controller: controllerValue,
  //             decoration: InputDecoration(
  //                 prefixIcon: type == "password"
  //                     ? Icon(Icons.password,color: P_Settings.buttonColor,)
  //                     : Icon(Icons.person,color: P_Settings.buttonColor,),
  //                 suffixIcon: type == "password"
  //                     ? IconButton(
  //                         icon: Icon(
  //                           _isObscure.value
  //                               ? Icons.visibility_off
  //                               : Icons.visibility,
  //                         ),
  //                         onPressed: () {
  //                           _isObscure.value = !_isObscure.value;
  //                           print("_isObscure $_isObscure");
  //                         },
  //                       )
  //                     : null,
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                   borderSide: BorderSide(
  //                     color:  Colors.white,
  //                     width: 3,
  //                   ),
  //                 ),
  //                 hintText: hinttext.toString(),
  //                  hintStyle: TextStyle(
  //                   fontSize: 15,
  //                   color: P_Settings.buttonColor,
  //                 ),),
  //             validator: (text) {
  //               if (text == null || text.isEmpty) {
  //                 return 'Please Enter ${hinttext}';
  //               }
  //               return null;
  //             },
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}

Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to exit from this app'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      );
    },
  );
}
