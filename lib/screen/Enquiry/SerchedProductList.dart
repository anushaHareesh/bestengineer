import 'package:bestengineer/controller/controller.dart';
import 'package:bestengineer/widgets/bottomsheets/itemSelectionSheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedProductList extends StatefulWidget {
  const SearchedProductList({super.key});

  @override
  State<SearchedProductList> createState() => _SearchedProductListState();
}

class _SearchedProductListState extends State<SearchedProductList> {
  ItemSlectionBottomsheet itemBottom = ItemSlectionBottomsheet();

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: value.newList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                itemBottom.showItemSheet(
                    context, value.newList[index], index);
              },
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/noImg.png"),
              ),
              title: Text(
                value.newList[index]["itemName"],
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600]),
              ),
            );
          },
        );
      },
    );
  }
}
