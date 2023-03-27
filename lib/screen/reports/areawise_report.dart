import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

class AreaWiseReport extends StatefulWidget {
  const AreaWiseReport({super.key});

  @override
  State<AreaWiseReport> createState() => _AreaWiseReportState();
}

class _AreaWiseReportState extends State<AreaWiseReport> {
  ValueNotifier<bool> visible = ValueNotifier(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // talukselected = null;
    // areaselected = null;
    // Provider.of<QuotationController>(context, listen: false).listWidget=[];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Consumer<Controller>(
                builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 163, 163, 163)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    // width: size.width * 0.4,
                    height: size.height * 0.05,

                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        // value: selected,
                        // isDense: true,
                        hint: Text(
                          value.selected == null
                              ? "Select Area.."
                              : value.selected!,
                          style: TextStyle(fontSize: 14),
                        ),
                        isExpanded: true,
                        autofocus: false,
                        underline: SizedBox(),
                        elevation: 0,
                        items: value.area_list
                            .map((item) => DropdownMenuItem<String>(
                                value: item["area_id"].toString(),
                                child: Container(
                                  width: size.width * 0.4,
                                  child: Text(
                                    item["area_name"].toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )))
                            .toList(),
                        onChanged: (item) {
                          print("clicked");

                          if (item != null) {
                            print("clicked------$item");
                            value.areaId = item;
                            Provider.of<Controller>(context, listen: false)
                                .setDropdowndata(value.areaId!);
                            Provider.of<Controller>(context, listen: false)
                                .fetchTalukandPanchyt(context, value.areaId!);
                            // print("se;ected---$item");
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: ValueListenableBuilder(
                    valueListenable: visible,
                    builder: (BuildContext context, bool v, Widget? child) {
                      print("value===${visible.value}");
                      return Visibility(
                        visible: v,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Select Area!!!",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Consumer<Controller>(
                builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 163, 163, 163)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    // width: size.width * 0.4,
                    height: size.height * 0.05,

                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                          // value: selected,
                          // isDense: true,
                          hint: Text(
                            value.talukSelected == null
                                ? "Select Taluk.."
                                : value.talukSelected!,
                            style: TextStyle(fontSize: 14),
                          ),
                          isExpanded: true,
                          autofocus: false,
                          underline: SizedBox(),
                          elevation: 0,
                          items: value.talukList
                              .map((item) => DropdownMenuItem<String>(
                                  value: item["th_id"].toString(),
                                  child: Container(
                                    width: size.width * 0.4,
                                    child: Text(
                                      item["th_name"].toString(),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )))
                              .toList(),
                          onChanged: (item) {
                            print("clicked");
                            setState(() {
                              if (item != null) {
                                print("clicked------$item");
                                value.talukId = item;
                                // Provider.of<Controller>(context, listen: false)
                                //     .settalukDropSelected(talukselected!);
                                // Provider.of<Controller>(context, listen: false)
                                //     .fetchAreaFromTaluk(context, talukselected!);

                                // print("se;ected---$item");
                              }
                            });

                            Provider.of<Controller>(context, listen: false)
                                .settalukDropSelected(value.talukId!);

                            // print("se;ected---$item");
                          }),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Consumer<Controller>(
                builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 163, 163, 163)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    // width: size.width * 0.4,
                    height: size.height * 0.05,

                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                          // value: selected,
                          // isDense: true,
                          hint: Text(
                            value.panchayatSelected == null
                                ? "Select Panchayath.."
                                : value.panchayatSelected!,
                            style: TextStyle(fontSize: 14),
                          ),
                          isExpanded: true,
                          autofocus: false,
                          underline: SizedBox(),
                          elevation: 0,
                          items: value.panchayt
                              .map((item) => DropdownMenuItem<String>(
                                  value: item["ph_id"].toString(),
                                  child: Container(
                                    width: size.width * 0.4,
                                    child: Text(
                                      item["name"].toString(),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )))
                              .toList(),
                          onChanged: (item) {
                            print("clicked");
                            setState(() {
                              if (item != null) {
                                print("clicked------$item");
                                value.panId = item;
                                // Provider.of<Controller>(context, listen: false)
                                //     .settalukDropSelected(talukselected!);
                                // Provider.of<Controller>(context, listen: false)
                                //     .fetchAreaFromTaluk(context, talukselected!);

                                // print("se;ected---$item");
                              }
                            });

                            Provider.of<Controller>(context, listen: false)
                                .setpanchayatDropSelected(value.panId!);

                            // print("se;ected---$item");
                          }),
                    ),
                  );
                },
              ),

              SizedBox(
                height: 10,
              ),

              Consumer<Controller>(
                builder: (context, value, child) {
                  return Container(
                    width: size.width * 0.3,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: P_Settings.loginPagetheme),
                        onPressed: () {
                          if (value.areaId == null) {
                            visible.value = true;
                          } else {
                            visible.value = false;
                            String? pan;
                            String? tal;

                            if (value.talukId == null) {
                              tal = "0";
                            } else {
                              tal = value.talukId;
                            }
                            if (value.panId == null) {
                              pan = "0";
                            } else {
                              pan = value.panId;
                            }

                            Provider.of<QuotationController>(context,
                                    listen: false)
                                .getAreaWiseReport(
                                    context, tal, value.areaId, pan!);
                          }
                        },
                        child: Text(
                          "Apply",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )),
                  );
                },
              ),
              Divider(),
              // Provider.of<QuotationController>(context, listen: false).isLoading
              //     ? SpinKitCircle(
              //         color: P_Settings.loginPagetheme,
              //       )
              //     : Provider.of<QuotationController>(context, listen: false)
              //                 .listWidget
              //                 .length ==
              //             0
              //         ? Lottie.asset("assets/noData.json", height: 200)
              //         :
              Consumer<QuotationController>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return SpinKitCircle(
                      color: P_Settings.loginPagetheme,
                    );
                  } else if (value.listWidget.length == 0) {
                    return Container(
                        height: 200,
                        width: 200,
                        child: Lottie.asset("assets/noData.json", height: 100));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      // itemCount: 40,
                      itemCount: value.listWidget.length,
                      itemBuilder: (context, index) {
                        return value.listWidget[index];
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
