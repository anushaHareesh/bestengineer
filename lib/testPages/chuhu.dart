import 'package:flutter/material.dart';

class Hhh extends StatefulWidget {
  @override
  State<Hhh> createState() => _HhhState();
}

class _HhhState extends State<Hhh> {
  List list = [
    {
      "name": "NAME1",
      "no": "0123/123/89",
      "date": "20-12-2023",
      "ph": "9061259261"
    },
    {
      "name": "NAME1",
      "no": "0123/123/89",
      "date": "20-12-2023",
      "ph": "9061259261"
    },
    {
      "name": "NAME1",
      "no": "0123/123/89",
      "date": "20-12-2023",
      "ph": "9061259261"
    },
    {
      "name": "NAME1",
      "no": "0123/123/89",
      "date": "20-12-2023",
      "ph": "9061259261"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return customCard(list[index]);
        },
      ),
    );
  }

  Widget customCard(Map list) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(list["name"])],
          ),
          // Row(
          //   children: [
          //     Column(
          //       children: [
          //         Image.asset(
          //           "assets/calendar.png",
          //           height: 28,
          //         ),
          //       ],
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 8.0),
          //       child: Column(
          //         children: [
          //           Text(list["no"]),
          //           Text(list["ph"]),
          //         ],
          //       ),
          //     )
          //   ],
          // )
          ListTile(
            title: Text(list["no"]),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/calendar.png"),
            ),
            trailing: Text(list["date"]),
            subtitle: Text(list["ph"]),
          ),
          Divider(),
          Row(
            children: [Text('Company Info : '), Text("Kannurr")],
          ),
          Row(
            children: [Text('Contact Person  : '), Text("Anusha k")],
          )
        ],
      ),
    );
  }
}
