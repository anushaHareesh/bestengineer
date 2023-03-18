import 'package:bestengineer/components/commonColor.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceChat extends StatefulWidget {
  String form_id;
  String qb_id;
  String title;
  ServiceChat(
      {required this.form_id, required this.qb_id, required this.title});

  @override
  State<ServiceChat> createState() => _ServiceChatState();
}

class _ServiceChatState extends State<ServiceChat> {
  TextEditingController remark = TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String? user_id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShared();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    Provider.of<QuotationController>(context, listen: false)
        .getPreviousChat(widget.form_id, widget.qb_id, context);
    _refreshController.refreshCompleted();
  }

  getShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? branch_id = prefs.getString("branch_id");
    user_id = prefs.getString("user_id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
                onTap: () {
                  Provider.of<QuotationController>(context, listen: false)
                      .getPreviousChat(widget.form_id, widget.qb_id, context);
                },
                child: Icon(Icons.refresh)),
          )
        ],
        title: Row(
          children: [
            Text(
              "Remark History - ",
              style: TextStyle(fontSize: 15),
            ),
            Flexible(
              child: Text(
                "${widget.title}",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
        child: Consumer<QuotationController>(builder: (context, value, child) {
          if (value.isChatLoading) {
            return Center(
              child: SpinKitCircle(
                color: P_Settings.loginPagetheme,
              ),
            );
          } else {
            return Column(
              children: [
                value.serviceChatList.length == 0
                    ? Expanded(
                        child: Container(
                            height: 200,
                            width: 180,
                            child: Lottie.asset("assets/noChat.json")))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: value.serviceChatList.length,
                          itemBuilder: (context, index) {
                            String rem = value.serviceChatList[index]["remarks"]
                                .replaceAll("\n", " ");
                            return Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: ListTile(
                                // tileColor:
                                //     value.serviceChatList[index]["USERS_ID"] == user_id
                                //         ? Color.fromARGB(255, 213, 236, 214)
                                //         : Colors.white,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: value.serviceChatList[index]
                                              ["USERS_ID"] ==
                                          user_id
                                      ? AssetImage("assets/man.png")
                                      : AssetImage("assets/man2.png"),
                                ),
                                trailing: Text(
                                  value.serviceChatList[index]["date"],
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12),
                                ),
                                title:
                                    Text(value.serviceChatList[index]["NAME"]),
                                subtitle: Text(
                                  rem,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                Container(
                  // height: 50,
                  // color: Colors.grey[100],
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                            controller: remark,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 8),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                              hintText: "Enter  Remark......",
                              hintStyle: TextStyle(fontSize: 12),
                              border: InputBorder.none,

                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(8)),
                            )),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 3),
                        child: InkWell(
                          onTap: () {
                            if (remark.text != null && remark.text.isNotEmpty) {
                              Provider.of<QuotationController>(context,
                                      listen: false)
                                  .saveServiceChat(widget.form_id, widget.qb_id,
                                      remark.text, context);

                              remark.clear();
                            }
                          },
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage("assets/send.png"),
                          ),
                        ),
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       Provider.of<QuotationController>(context,
                      //               listen: false)
                      //           .saveServiceChat(widget.form_id, widget.qb_id,
                      //               remark.text, context);

                      //       remark.clear();
                      //     },
                      //     icon: Icon(
                      //       Icons.send,
                      //       color: Colors.blue,
                      //     )),
                    ],
                  ),
                )
              ],
            );
          }
        }),
      ),
    );
  }
}
