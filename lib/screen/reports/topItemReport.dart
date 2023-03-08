import 'package:bestengineer/components/commonColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../controller/quotationController.dart';

class TopItemReport extends StatefulWidget {
  const TopItemReport({super.key});

  @override
  State<TopItemReport> createState() => _TopItemReportState();
}

class _TopItemReportState extends State<TopItemReport> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<QuotationController>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return SpinKitCircle(
              color: P_Settings.loginPagetheme,
            );
          } else if (value.topItemList.length == 0) {
            return Lottie.asset("assets/noData.json",height: size.height*0.2);
          } else {
            return ListView.builder(
              itemCount: value.topItemList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/noImg.png"),
                    ),
                    title: Text(
                      value.topItemList[index]["product_name"],
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    subtitle: Row(
                      children: [
                        Text("Qty  :  "),
                        Text(
                          value.topItemList[index]["p_cnt"],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}