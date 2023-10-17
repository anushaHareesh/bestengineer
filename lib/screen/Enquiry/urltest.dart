// import 'package:bestengineer/controller/controller.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// import '../../controller/registrationController.dart';

// class TestUrl extends StatefulWidget {
//   const TestUrl({super.key});

//   @override
//   State<TestUrl> createState() => _TestUrlState();
// }

// class _TestUrlState extends State<TestUrl> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: WebView(
//           javascriptMode: JavascriptMode.unrestricted,
//           initialUrl: "https://trafiqerp.in/webapp/beste/api/index.php",
//         ),
//       ),
//     );
//     // return Scaffold(
//     //   appBar: AppBar(),
//     //   body: ElevatedButton(child: Text("pdf"), onPressed: _launchURLApp),
//     // );
//   }

//   _launchURLApp() async {
//     var url = Uri.parse("https://trafiqerp.in/webapp/beste/api/index.php");
//     // var url = Uri.parse("kspconline.in/officeuse/project/cft_reg.php");

//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
