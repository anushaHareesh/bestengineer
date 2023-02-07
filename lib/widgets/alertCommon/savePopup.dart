// import 'package:bestengineer/controller/productController.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'package:provider/provider.dart';

// import '../../components/commonColor.dart';

// class SavePopup {
//   Future builddeletePopupDialog(
//     BuildContext context,
//   ) {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext ctx) {
//           return new AlertDialog(
//             content: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Do you want to confirm ?"),
//               ],
//             ),
//             actions: <Widget>[
//               Consumer<ProductController>(
//                 builder: (context, value, child) {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               primary: P_Settings.loginPagetheme),
//                           onPressed: () {
//                             value.saveCartDetails(context);
//                             Navigator.pop(context);
//                           },
//                           child: Text("Ok")),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 primary: P_Settings.loginPagetheme),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text("Cancel")),
//                       )
//                     ],
//                   );
//                 },
//               ),
//             ],
//           );
//         });
//   }
// }
