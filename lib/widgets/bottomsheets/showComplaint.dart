import 'package:bestengineer/components/commonColor.dart';
import 'package:flutter/material.dart';

class ShowComplaintsSheet {
  String? selected;
  ValueNotifier<bool> visible = ValueNotifier(false);

  TextEditingController remark = TextEditingController();

  showComplaintSheet(BuildContext context, String name, String complaint) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            // <-- SEE HERE
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0)),
      ),
      builder: (BuildContext mycontext) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(mycontext);
                        },
                        icon: Icon(Icons.close)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 15,
                            color: P_Settings.lightPurple,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                  child: Row(
                    children: [Flexible(child: Text(complaint))],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ///////////////////////////////////////////////////
}
