import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/controller/quotationController.dart';
import 'package:bestengineer/screen/Quotation/quotation_listScreen.dart';
import 'package:bestengineer/screen/Quotation/statusMonitoringQuotation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchAutoComplete extends StatefulWidget {
  const SearchAutoComplete({super.key});

  @override
  State<SearchAutoComplete> createState() => _SearchAutoCompleteState();
}

class _SearchAutoCompleteState extends State<SearchAutoComplete> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuotationController>(
      builder: (context, value, child) {
        return Autocomplete<Map<String, dynamic>>(
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return List.empty();
            } else {
              print("bchc-----${textEditingValue.text}");
              print(value.quotationList.where((element) => element["cname"]
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase())));
              return value.quotationList.where((element) =>
                  element["cname"]
                      .toString()
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()) ||
                  element["qt_no"].toString().toLowerCase().contains(
                        textEditingValue.text.toLowerCase(),
                      ));
            }
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextField(
              style: TextStyle(color: Colors.white, fontSize: 12),
              controller: textEditingController,
              focusNode: focusNode,
              onEditingComplete: onFieldSubmitted,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Search With Qt No. or Customer....",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 12)),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                child: Container(
                  width: MediaQuery.of(context).size.width - 80,
                  height: 52.0 * options.length,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: false,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> option =
                            options.elementAt(index);
                        return ListTile(
                          onTap: () {
                            onSelected(option);
                            Provider.of<Controller>(context, listen: false)
                                .searchQotSelected = option["cname"];
                            String s = option["s_invoice_id"];
                            Provider.of<Controller>(context, listen: false)
                                .getQuotationSearchList(context, s);

                            //                  Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => QuotationStatusMonitoring(),
                            //   ),
                            // );
                          },
                          title: Text(
                            option["cname"],
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      },
                      itemCount: options.length),
                ),
              ),
            );
          },
          onSelected: (option) {
            debugPrint(option["cname"]);
          },
          displayStringForOption: (Map<String, dynamic> option) =>
              option["cname"],
        );
      },
    );
  }
}
