import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  String staff;
  String oldp;
  ChangePassword({required this.staff, required this.oldp});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldp = TextEditingController();
  TextEditingController newP = TextEditingController();
  TextEditingController staff = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oldp.text = widget.oldp;
    staff.text = widget.staff;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Reset Password",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          TextField(
            readOnly: true,
            controller: staff,
            decoration: new InputDecoration(
              prefixIcon: Icon(Icons.person),
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              // border: ...
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: oldp,
            readOnly: true,
            decoration: new InputDecoration(
              prefixIcon: Icon(Icons.password_outlined),
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              // border: ...
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: newP,
            decoration: new InputDecoration(
              prefixIcon: Icon(Icons.password_outlined),

              hintText: "Enter New Password",
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              // border: ...
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: P_Settings.loginPagetheme),
            onPressed: () async {
              int res = Provider.of<Controller>(context, listen: false)
                  .resetPassword(context, newP.text, newP);
              print("ressss----$res");
              // if (res == 1) {
              //   newP.clear();
              // }
              // newP.clear();
              // newP.clear();
            },
            child: Text("Reset Password"),
          )
        ],
      ),
    ));
  }
}
