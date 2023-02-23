import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  // int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Stepper Demo'),
        centerTitle: true,
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isStatusMon) {
            return Container(
              height: size.height * 0.8,
              child: SpinKitCircle(
                color: P_Settings.loginPagetheme,
              ),
            );
          } else {
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: Theme(
                      data: ThemeData(
                        canvasColor: Colors.yellow,
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: Colors.green,
                              background: Colors.red,
                              secondary: Colors.green,
                            ),
                      ),
                      child: Stepper(
                          controlsBuilder: (context, details) {
                            return Container();
                          },
                          // type: stepperType,
                          physics: ScrollPhysics(),
                          // currentStep: _currentStep,
                          // onStepTapped: (step) => tapped(step),
                          // onStepContinue: continued,
                          // onStepCancel: cancel,
                          steps: value.statusMon
                              .map(
                                (e) => Step(
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(e["remarks"]),
                                        Text(
                                            e["NAME"] +
                                                " " +
                                                "/" +
                                                "  " +
                                                e["added_on"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[500],
                                                fontSize: 15)),
                                      ],
                                    ),
                                    content: Text("")),
                              )
                              .toList()),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
