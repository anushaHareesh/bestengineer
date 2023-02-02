import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';
import '../../widgets/bottomsheets/itemSelectionSheet.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ItemSlectionBottomsheet itemBottom = ItemSlectionBottomsheet();
  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: value.productList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Provider.of<Controller>(context, listen: false)
                    .setaddNewItem(false);
                itemBottom.showItemSheet(
                    context, value.productList[index], index);
              },
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/noImg.png"),
              ),
              title: Text(
                value.productList[index]["itemName"],
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
