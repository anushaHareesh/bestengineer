import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  /// Variables
  File? image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // final imagetemporary = File(image.path);
      final imagePermenent = await savePermenently(image.path);
      setState(() {
        this.image = imagePermenent;
      });
    } on PlatformException catch (e) {
      print("failed---$e");
    }
  }

  Future savePermenently(String imagePath) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    String name = basename(imagePath);
    final image = File('${directory.path}/$name');
    print("image path----$image");
    
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker"),
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image != null
                ? Image.file(
                    image!,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  )
                : Container(),
            ElevatedButton(
              // color: Colors.greenAccent,
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
              child: Text("PICK FROM GALLERY"),
            ),
            Container(
              height: 40.0,
            ),
            ElevatedButton(
              // color: Colors.lightGreenAccent,
              onPressed: () {
                _pickImage(ImageSource.camera);
              },
              child: Text("PICK FROM CAMERA"),
            )
          ],
        )));
  }
}
