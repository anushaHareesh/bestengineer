import 'package:bestengineer/chatApp/chatHome.dart';
import 'package:bestengineer/chatApp/chatLogin.dart';
import 'package:bestengineer/chatApp/methods.dart';
import 'package:flutter/material.dart';

class ChatRegister extends StatefulWidget {
  const ChatRegister({super.key});

  @override
  State<ChatRegister> createState() => _ChatRegisterState();
}

class _ChatRegisterState extends State<ChatRegister> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  bool isLoading = false;
  Service service = Service();

  TextEditingController pswd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SafeArea(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Container(
                        height: 200,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Name"),
                        controller: name,
                      ),
                      SizedBox(
                        height: 20,
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
                            if (name.text.isNotEmpty &&
                                email.text.isNotEmpty &&
                                pswd.text.isNotEmpty) {
                              setState(() {
                                isLoading = true;
                                service
                                    .createAccount(
                                        name.text, email.text, pswd.text)
                                    .then((user) {
                                  if (user != null) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print("success");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatHome()),
                                    );
                                  } else {
                                    print("failed");
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                });
                              });
                            } else {
                              print("please fill fields");
                            }
                            //  Navigator.push(
                            //         context,
                            //         MaterialPageRoute(builder: (context) => RegisterChat()),
                            //       );
                          },
                          child: Text("Register")),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatLogin()),
                          );
                        },
                        child: Text("Login"),
                      )
                    ]),
                  ),
                )),
    );
  }
}
