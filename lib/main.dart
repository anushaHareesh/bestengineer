import 'dart:io';

import 'package:bestengineer/chatApp/chatLogin.dart';

import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/productController.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/controller/registrationController.dart';
import 'package:bestengineer/gmap/multipleMarker.dart';
import 'package:bestengineer/pdftest/pdfhome.dart';

import 'package:bestengineer/pdftest/tab.dart';
import 'package:bestengineer/screen/Dashboard/searchAutocomplete.dart';

import 'package:bestengineer/screen/Enquiry/enqHome.dart';

import 'package:bestengineer/screen/Enquiry/enqcart.dart';
import 'package:bestengineer/screen/Enquiry/urltest.dart';

import 'package:bestengineer/screen/registration%20and%20login/login.dart';
import 'package:bestengineer/screen/registration%20and%20login/registration.dart';
import 'package:bestengineer/screen/splashScreen.dart';
import 'package:bestengineer/screen/testLoc.dart';

import 'package:bestengineer/services/fcm_service.dart';
import 'package:bestengineer/syncPdf/simplesync.dart';
import 'package:bestengineer/syncPdf/syncPdfHome.dart';
import 'package:bestengineer/testPages/audioRecordeTest.dart';
import 'package:bestengineer/testPages/uploadImage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// company Key------BS12KNRVBGBE

void requestPermission() async {
  var status = await Permission.storage.status;
  // var statusbl= await Permission.bluetooth.status;

  var status1 = await Permission.manageExternalStorage.status;

  if (!status1.isGranted) {
    await Permission.storage.request();
  }
  if (!status1.isGranted) {
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      await Permission.bluetooth.request();
    } else {
      openAppSettings();
    }
    // await Permission.app
  }
  if (!status1.isRestricted) {
    await Permission.manageExternalStorage.request();
  }
  if (!status1.isPermanentlyDenied) {
    await Permission.manageExternalStorage.request();
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the , such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  await Firebase.initializeApp();
  debugPrint('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //final token = await FcmService().getFirebaseTokken();
  FcmService().initialize();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  requestPermission();
  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Controller()),
      ChangeNotifierProvider(create: (_) => RegistrationController()),
      ChangeNotifierProvider(create: (_) => ProductController()),
      ChangeNotifierProvider(create: (_) => QuotationController()),
    ],
    child: MyApp(),
  ));

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getshared();
  }

  getshared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
  }

  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: _navigator,
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Roboto Mono sample',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // fontFamily: 'OpenSans',
          primaryColor: P_Settings.loginPagetheme,
          // colorScheme: ColorScheme.fromSwatch(
          //   primarySwatch: Colors.indigo,
          // ),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          // scaffoldBackgroundColor: P_Settings.bodycolor,
          // textTheme: const TextTheme(
          //   headline1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          //   headline6: TextStyle(
          //     fontSize: 25.0,
          //   ),
          //   bodyText2: TextStyle(
          //     fontSize: 14.0,
          //   ),
          // ),
        ),
        home: SplashScreen()

        //  AnimatedSplashScreen(
        //   backgroundColor: Colors.black,
        //   splash: Image.asset("asset/logo_black_bg.png"),
        //   nextScreen: SplashScreen(),
        //   splashTransition: SplashTransition.fadeTransition,
        //   duration: 1000,
        // ),
        );
  }
}
