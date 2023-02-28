import 'package:bestengineer/components/commonColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../controller/quotationController.dart';

class JustPage extends StatefulWidget {
  const JustPage({super.key});

  @override
  State<JustPage> createState() => _JustPageState();
}

class _JustPageState extends State<JustPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<QuotationController>(context, listen: false).getPdfData(
        context,
        Provider.of<QuotationController>(context, listen: false)
            .sivd
            .toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<QuotationController>(
        builder: (context, value, child) {
          if (value.isPdfLoading) {
            return SpinKitCircle(
              color: P_Settings.loginPagetheme,
            );
          } else {
            return Center(
                child: ElevatedButton(
                    onPressed: () {}, child: Text("Click Back")));
          }
        },
      ),
    );
  }
}
