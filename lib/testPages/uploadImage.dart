import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/networkConnectivity.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  XFile? image;

  final ImagePicker picker = ImagePicker();
  delete(
    BuildContext context,
  ) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse(
              "https://trafiqerp.in/new/create-simple-rest-api-php-mysql/items/create.php");
          Map body = {
            "name": "Usha Sewing Machine",
            "description": "its best machine",
            "price": "90000",
            "category_id": "6",
            "created": "2019-11-09 04:30:00"
          };

          var jsonEnc = jsonEncode(body);
          print("jsonEnc--$jsonEnc");
          // isQuotLoading = true;
          // notifyListeners();
          http.Response response = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEnc,
          );
          var map = jsonDecode(response.body);
          // quotationList.clear();
          // for (var item in map["master"]) {
          //   quotationList.add(item);
          // }
          print("dealerCance ----$map");

          // isQuotLoading = false;
          // notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  upload(File _image) async {
    // open a byteStream
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    // get file length
    var length = await _image.length();

    // string to uri
    var uri = Uri.parse(
        "https://trafiqerp.in/new/create-simple-rest-api-php-mysql/items/api-file-upload.php");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request
    // request.fields["user_id"] = "text";

    // multipart that takes file.. here this "image_file" is a key of the API request
    var multipartFile = new http.MultipartFile('sendimage', stream, length,
        filename: basename(_image.path));

    print("multupart------$multipartFile");
    request.files.add(multipartFile);

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print("value---$value");
      });
    }).catchError((e) {
      print("e-------------$e");
    });
  }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void myAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              child: Text('select Photo'),
            ),
            ElevatedButton(
              onPressed: () {
                // delete(context);
                upload(File(image!.path));
              },
              child: Text('Upload Photo'),
            ),
            SizedBox(
              height: 10,
            ),
            //if image not null show the image
            //if image null show text
            image != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        //to show image, you type like this.
                        File(image!.path),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      ),
                    ),
                  )
                : Text(
                    "No Image",
                    style: TextStyle(fontSize: 20),
                  )
          ],
        ),
      ),
    );
  }
}
