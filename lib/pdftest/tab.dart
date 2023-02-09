import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var report = {
    "id": 1,
    "type": "my type",
    "name": "Report 1",
    "client_name": "John",
    "website": "john.com",
    "creation_time": "2019-03-12T22:00:00.000Z",
    "items": [
      {
        "id": 1,
        "report_id": 1,
        "place": "Kitchen",
        "type": "sometype",
        "producer": "somepro",
        "serial_number": "123123",
        "next_check_date": "2019-03-19",
        "test_result": "Verified",
        "comments": "some comments"
      }
    ]
  };
  @override
  Widget build(BuildContext context) {
    var list = (report['items'] as List)
        .map((item) => TableRow(children: [
              Text(item['id'].toString()),
              Text(item['report_id'].toString()),
              Text(item['place']),
              //...
            ]))
        .toList();
    list.insert(
        0,
        TableRow(children: [
          Text("TITLE 1"),
          Text("TITLE 2"),
          Text("TITLE 3"),
          //...
        ]));
    return Scaffold(
      appBar: AppBar(),
      body: Container(child: Table(children: list)),
    );
  }
}
