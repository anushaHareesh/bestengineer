
import 'package:bestengineer/screen/Enquiry/enqHome.dart';
import 'package:bestengineer/screen/registration%20and%20login/login.dart';
import 'package:flutter/material.dart';

class FcmNavigationService {
  FcmNavigationService({this.page});
  final String? page;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic> navigateToPage() {
    return Navigator.of(navigatorKey.currentContext!).push(
      MaterialPageRoute(
        builder: (context) =>  EnqHome(),
      ),
    );

    //For Navigating to a specific page
    // switch (page) {
    //   case "home":
    //     return Navigator.of(navigatorKey.currentContext!)
    //         .push(MaterialPageRoute(
    //             builder: (context) => const BottomNavScreen(
    //                   selectedIndex: 0,
    //                 )));
    //   case "order":
    //     return Navigator.of(navigatorKey.currentContext!)
    //         .push(MaterialPageRoute(
    //             builder: (context) => const BottomNavScreen(
    //                   selectedIndex: 3,
    //                 )));
    //   case "customer":
    //     return Navigator.of(navigatorKey.currentContext!).push(
    //         MaterialPageRoute(builder: (context) => const ProfileScreen()));

    //   case "return":
    //     return Navigator.of(navigatorKey.currentContext!)
    //         .push(MaterialPageRoute(
    //             builder: (context) => const BottomNavScreen(
    //                   selectedIndex: 3,
    //                 )));
    //   case "promocode":
    //     return Navigator.of(navigatorKey.currentContext!)
    //         .push(MaterialPageRoute(
    //             builder: (context) => const BottomNavScreen(
    //                   selectedIndex: 1,
    //                 )));

    //   case "product":
    //     return Navigator.of(navigatorKey.currentContext!)
    //         .push(MaterialPageRoute(
    //             builder: (context) => const BottomNavScreen(
    //                   selectedIndex: 1,
    //                 )));

    //   default:
    //     return Navigator.of(navigatorKey.currentContext!)
    //         .push(MaterialPageRoute(
    //             builder: (context) => const BottomNavScreen(
    //                   selectedIndex: 0,
    //                 )));
    // }
  }
}
