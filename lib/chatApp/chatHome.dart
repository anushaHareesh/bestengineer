import 'package:bestengineer/chatApp/chatRoom.dart';
import 'package:bestengineer/chatApp/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> with WidgetsBindingObserver {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Service service = Service();
  bool isLoading = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController search = TextEditingController();
  Map<String, dynamic> userMap = {};
  String chatRoomid(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2[0].toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onserach() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("users")
        .where("name", isEqualTo: search.text)
        .get()
        .then((value) {
      print(
          "valueee-----${value.docs[0].data()}-----${_auth.currentUser!.displayName}");
      setState(() {
        String crnt = _auth.currentUser!.displayName.toString();
        if (crnt != value.docs[0].data()["name"]) {
          userMap = value.docs[0].data();
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addObserver(this);
    sestatus("Online");
  }

  void sestatus(String status) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({"status": status});
  }

  @override
  void didChangeLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      sestatus("Online");
    } else {
      //offline
      sestatus("Offnline");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                service.logout(context);
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TextField(
                  controller: search,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      onserach();
                    },
                    child: Text("search")),
                userMap != null && userMap.isNotEmpty
                    ? ListTile(
                        onTap: () {
                          String rId = chatRoomid(
                              _auth.currentUser!.displayName.toString(),
                              userMap["name"]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatRoom(
                                      chatRoomId: rId,
                                      userMap: userMap,
                                    )),
                          );
                        },
                        leading: Icon(Icons.person),
                        trailing: Icon(Icons.chat),
                        title: Text(userMap["name"].toString()),
                        subtitle: Text(userMap["email"].toString()),
                      )
                    : Container()
              ],
            ),
    );
  }
}
