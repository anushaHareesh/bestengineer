import 'package:bestengineer/chatApp/chatHome.dart';
import 'package:bestengineer/chatApp/chatReg.dart';
import 'package:bestengineer/chatApp/methods.dart';
import 'package:flutter/material.dart';

class ChatLogin extends StatefulWidget {
  const ChatLogin({super.key});

  @override
  State<ChatLogin> createState() => _ChatLoginState();
}

class _ChatLoginState extends State<ChatLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController pswd = TextEditingController();
  bool isLoading = false;
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Container(
              height: 200,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Email"),
              controller: email,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: "password"),
              controller: pswd,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (email.text.isNotEmpty && pswd.text.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                      service.signin(email.text, pswd.text).then((user) {
                        if (user != null) {
                          setState(() {
                            isLoading = false;
                          });
                          print("login success");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatHome()),
                          );
                        } else {
                          print("login failed");
                          setState(() {
                            isLoading = false;
                          });
                        }
                      });
                    });
                  } else {
                    print("please fill fields");
                  }
                },
                child: Text("Login")),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatRegister()),
                );
              },
              child: Text("Create Account"),
            )
          ]),
        ),
      )),
    );
  }
}
