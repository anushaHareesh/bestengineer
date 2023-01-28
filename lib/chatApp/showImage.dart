import 'package:flutter/material.dart';

class ShowImage extends StatefulWidget {
  String imgeurl;
  ShowImage({required this.imgeurl});

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 700,
          child: Image.network(
            widget.imgeurl,
          ),
        ),
      ),
    );
  }
}
