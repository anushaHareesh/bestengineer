import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:bestengineer/chatApp/showImage.dart';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

class ChatRoom extends StatelessWidget {
  Map<String, dynamic> userMap = {};
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  TextEditingController _message = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  File? imageFile;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        'sendby': _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp()
      };
      _message.clear();

      await _firestore
          .collection("chatroom")
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("enter some text");
    }
  }

  Future getImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((value) {
      if (value != null) {
        imageFile = File(value.path);

        print("imagefile----$imageFile");
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String filename = Uuid().v1();
    int status = 1;
    await _firestore
        .collection("chatroom")
        .doc(chatRoomId)
        .collection('chats')
        .doc(filename)
        .set({
      'sendby': _auth.currentUser!.displayName,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp()
    });
    var res =
        FirebaseStorage.instance.ref().child('images').child("$filename.jpg");

    print("res---$res");
    // var uploadtask = await res.putFile(imageFile!).catchError((error) async {
    //   await _firestore
    //       .collection("chatroom")
    //       .doc(chatRoomId)
    //       .collection('chats')
    //       .doc(filename)
    //       .delete();

    //   print("error----$error");
    // });
    // status = 0;

    var uploadtask = res.putFile(imageFile!);
    final snapshiot = await uploadtask.whenComplete(() {});

    final urldownlod = await snapshiot.ref.getDownloadURL();
    print("urldownlod-----$urldownlod");
    // if (status == 1) {
    //   String imageurl = await uploadtask.ref.getDownloadURL();
    //
    await _firestore
        .collection("chatroom")
        .doc(chatRoomId)
        .collection('chats')
        .doc(filename)
        .update({"message": urldownlod});
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream:
              _firestore.collection('users').doc(userMap['uid']).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Container(
                child: Column(
                  children: [
                    Text(userMap["name"]),
                    // Text(snapshot.data!["status"])
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        // title: Text(userMap["name"]),
      ),
      // bottomNavigationBar: Container(
      //   height: 40,
      //   child: Row(
      //     children: [
      //       Container(
      //         width: 350,
      //         child: TextField(
      //             controller: _message,
      //             decoration: InputDecoration(
      //                 suffixIcon: Wrap(
      //                   children: [
      //                     IconButton(
      //                         onPressed: () {
      //                           getImage();
      //                         },
      //                         icon: Icon(Icons.photo)),
      //                     GestureDetector(
      //                         onLongPress: () async {
      //                           // var audioplayer=AudioPlayer();
      //                           // await audioplayer.play(AssetSource("Notification.mp3"));
      //                           // audioplayer.onPlayerComplete.listen((event) {
      //                           //   audi
      //                           // })
      //                         },
      //                         // onTertiaryLongPressEnd: (){},
      //                         child: Icon(Icons.mic)),
      //                   ],
      //                 ),
      //                 border: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(8)))),
      //       ),
      //       IconButton(
      //           onPressed: () {
      //             onSendMessage();
      //           },
      //           icon: Icon(Icons.send))
      //     ],
      //   ),
      // ),
      body: Column(
        children: [
          Container(
            // height: 700,
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection("chatroom")
                  .doc(chatRoomId)
                  .collection('chats')
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                            width: double.infinity,
                            alignment: snapshot.data!.docs[index]["sendby"] ==
                                    _auth.currentUser!.displayName
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: snapshot.data!.docs[index]["type"] == "text"
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 14),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: snapshot.data!.docs[index]
                                                    ["sendby"] ==
                                                _auth.currentUser!.displayName
                                            ? Colors.blue
                                            : Colors.grey),
                                    child: Text(
                                      snapshot.data!.docs[index]["message"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ShowImage(
                                                  imgeurl: snapshot.data!
                                                      .docs[index]["message"],
                                                )),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 300,
                                        width: 200,
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        alignment: snapshot.data!.docs[index]
                                                    ["message"] !=
                                                ""
                                            ? null
                                            : Alignment.center,
                                        child: snapshot.data!.docs[index]
                                                    ["message"] !=
                                                ""
                                            ? Image.network(
                                                snapshot.data!.docs[index]
                                                    ["message"],
                                                fit: BoxFit.cover,
                                              )
                                            : CircularProgressIndicator(),
                                      ),
                                    ),
                                  ));
                        // return Text(snapshot.data!.docs[index]["message"]);
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Container(
            height: 45,
            color: Colors.grey[100],
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  // color: Colors.grey[200],
                  // width: 320,
                  child: TextField(
                      controller: _message,
                      decoration: InputDecoration(
                        hintText: "Enter  message......",
                        border: InputBorder.none,
                        suffixIcon: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                  getImage();
                                },
                                icon: Icon(Icons.photo)),
                          ],
                        ),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(8)),
                      )),
                ),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onLongPress: () async {
                          //  bool hasPermissions = await AudioRecorder.hasPermissions;
                        },
                        // onTertiaryLongPressEnd: (){},
                        child: Icon(Icons.mic),
                      ),
                      IconButton(
                          onPressed: () {
                            onSendMessage();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.blue,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void startRecord()async{
  //   bool hasPerrmission=await chec
  // }
}
