import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:bestengineer/chatApp/audioController.dart';
import 'package:bestengineer/chatApp/showImage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

class ChatRoom extends StatefulWidget {
  Map<String, dynamic> userMap = {};
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController _message = TextEditingController();
  AudioController audioController = Get.put(AudioController());

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
          .doc(widget.chatRoomId)
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
        .doc(widget.chatRoomId)
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

    var uploadtask = res.putFile(imageFile!);
    final snapshiot = await uploadtask.whenComplete(() {});

    final urldownlod = await snapshiot.ref.getDownloadURL();

    await _firestore
        .collection("chatroom")
        .doc(widget.chatRoomId)
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
          stream: _firestore
              .collection('users')
              .doc(widget.userMap['uid'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Container(
                child: Column(
                  children: [
                    Text(widget.userMap["name"]),
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
                  .doc(widget.chatRoomId)
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
                                : snapshot.data!.docs[index]["type"] == "img"
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ShowImage(
                                                      imgeurl: snapshot
                                                              .data!.docs[index]
                                                          ["message"],
                                                    )),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 300,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            alignment:
                                                snapshot.data!.docs[index]
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
                                      )
                                    : _audio(
                                        message: snapshot.data!.docs[index]
                                            ["message"],
                                        isCurrentUser: snapshot
                                            .data!.docs[index]["sendby"],
                                        index: index,
                                        time: snapshot.data!.docs[index]
                                            ["time"],
                                        duration: "0.00"));
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
                          var audioPlayer = AudioPlayer();
                          await audioPlayer
                              .play(AssetSource("Notification.mp3"));
                          audioPlayer.onPlayerComplete.listen((a) {
                            audioController.start.value = DateTime.now();
                            startRecord();
                            audioController.isRecording.value = true;
                          });
                        },
                        onLongPressEnd: (details) {
                          stopRecord();
                        },
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

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  int i = 0;
  File? audioFile;
  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = "${storageDirectory.path}/record";
    // Directory? extDir = await getExternalStorageDirectory();
    // String dirPath = '${extDir!.path}/Audio/';

    // dirPath = dirPath.replaceAll(
    //     "Android/data/com.example.bestengineer/app_flutter/", "");

    // final File file = File('${dirPath}/test_${i++}.mp3');
    // print("file...$file");
    // String filpath = '$dirPath/test_${i++}.mp3';
    // await Directory(dirPath).create(recursive: true);
    var d = Directory(sdPath);

    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }

    return "$sdPath/test_${i++}.mp3";
  }

  late String recordFilePath;
  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();
      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }

  void stopRecord() async {
    bool stop = RecordMp3.instance.stop();
    audioController.end.value = DateTime.now();
    audioController.calcDuration();
    var ap = AudioPlayer();
    await ap.play(AssetSource("Notification.mp3"));
    ap.onPlayerComplete.listen((a) {});
    if (stop) {
      audioController.isRecording.value = false;
      audioController.isSending.value = true;
      await uploadAudio(recordFilePath);
    }

    print("stopped");
  }

  String audioURL = "";

  uploadAudio(String fil) async {
    String filename = Uuid().v1();
    await _firestore
        .collection("chatroom")
        .doc(widget.chatRoomId)
        .collection('chats')
        .doc(fil)
        .set({
      'sendby': _auth.currentUser!.displayName,
      "message": "",
      "type": "audio",
      "time": FieldValue.serverTimestamp()
    });
    var res =
        FirebaseStorage.instance.ref().child('audio').child("$filename.mp3");

    print("File(recordFilePath)----${File(recordFilePath)}");
    var uploadTask = res.putFile(File(recordFilePath));
    final snapshiot = await uploadTask.whenComplete(() {});
    String adurldownlod = await snapshiot.ref.getDownloadURL();
    print("urldownlod-----$adurldownlod");

    await _firestore
        .collection("chatroom")
        .doc(widget.chatRoomId)
        .collection('chats')
        .doc(fil)
        .update({"message": adurldownlod});

    // UploadTask uploadTask = chatProvider.uploadAudio(File(recordFilePath),
    //     "audio/${DateTime.now().millisecondsSinceEpoch.toString()}");
    // try {
    //   TaskSnapshot snapshot = await uploadTask;
    //   audioURL = await snapshot.ref.getDownloadURL();
    //   String strVal = audioURL.toString();
    //   setState(() {
    //     audioController.isSending.value = false;
    //     onSendMessage(strVal, TypeMessage.audio,
    //         duration: audioController.total);
    //   });
    // } on FirebaseException catch (e) {
    //   setState(() {
    //     audioController.isSending.value = false;
    //   });
    //   Fluttertoast.showToast(msg: e.message ?? e.toString());
    // }
  }

  AudioPlayer audioPlayer = AudioPlayer();
  Widget _audio({
    required String message,
    required String isCurrentUser,
    required int index,
    required String time,
    required String duration,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isCurrentUser == _auth.currentUser!.displayName
            ? Colors.blue
            : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              audioController.onPressedPlayButton(index, message);
              // changeProg(duration: duration);
            },
            onSecondaryTap: () {
              audioPlayer.stop();
              //   audioController.completedPercentage.value = 0.0;
            },
            child: Obx(
              () => (audioController.isRecordPlaying &&
                      audioController.currentId == index)
                  ? Icon(
                      Icons.cancel,
                      color: isCurrentUser == _auth.currentUser!.displayName
                          ? Colors.blue
                          : Colors.grey,
                    )
                  : Icon(
                      Icons.play_arrow,
                      color: isCurrentUser == _auth.currentUser!.displayName
                          ? Colors.blue
                          : Colors.grey,
                    ),
            ),
          ),
          Obx(
            () => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Text(audioController.completedPercentage.value.toString(),style: TextStyle(color: Colors.white),),
                    LinearProgressIndicator(
                      minHeight: 5,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isCurrentUser == _auth.currentUser!.displayName
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      value: (audioController.isRecordPlaying &&
                              audioController.currentId == index)
                          ? audioController.completedPercentage.value
                          : audioController.totalDuration.value.toDouble(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            duration,
            style: TextStyle(
              fontSize: 12,
              color: isCurrentUser == _auth.currentUser!.displayName
                  ? Colors.blue
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
