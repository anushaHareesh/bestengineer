import 'package:bestengineer/components/commonColor.dart';
import 'package:flutter/material.dart';

class QuotatationListScreen extends StatefulWidget {
  const QuotatationListScreen({super.key});

  @override
  State<QuotatationListScreen> createState() => _QuotatationListScreenState();
}

class _QuotatationListScreenState extends State<QuotatationListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: P_Settings.loginPagetheme,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Quotation List",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: P_Settings.loginPagetheme),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    color: P_Settings.fillcolor,
                    child: ListTile(
                      leading: Image.asset(
                        "assets/quot.png",
                        height: size.height * 0.04,
                      ),
                      title: Row(
                        children: [
                          Text(
                            "title ",
                            style: TextStyle(
                                fontSize: 19, color: P_Settings.loginPagetheme),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
