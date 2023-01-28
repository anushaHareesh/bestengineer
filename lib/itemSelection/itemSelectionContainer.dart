import 'package:bestengineer/components/commonColor.dart';
import 'package:flutter/material.dart';

class ItemSelection extends StatefulWidget {
  const ItemSelection({super.key});

  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return customTile(size);
              },
            ),
          )
        ],
      )),
    );
  }

  Widget customTile(Size size) {
    return Container(
      // color: Colors.yellow,
      height: size.height * 0.2,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: Colors.yellow,
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                  child: Image.asset(
                    "assets/burger.jpg",
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 112,
                  left: 29,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: P_Settings.loginPagetheme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                    onPressed: () {},
                    child: Text("ADD"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   height: size.height * 0.2,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Container(
    //         color: Colors.yellow,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(
    //               children: [
    //                 Text(
    //                   "Name",
    //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //                 ),
    //                 Text(
    //                   "Name",
    //                   style: TextStyle(
    //                     fontSize: 17,
    //                   ),
    //                 )
    //               ],
    //             ),
    //             Stack(
    //               children: [
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       alignment: Alignment.center,
    //                       decoration: BoxDecoration(
    //                           // color: Colors.yellow,
    //                           borderRadius: BorderRadius.all(
    //                         Radius.circular(20),
    //                       )),
    //                       child: Image.asset(
    //                         "asset/noImg.png",
    //                         height: 120,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 // Positioned(
    //                 //   top: 100,
    //                 //   left: 30,
    //                 //     child: ElevatedButton(
    //                 //   child: Text("Add"),
    //                 //   onPressed: () {},
    //                 // ))
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //       Divider()
    //     ],
    //   ),
    // );
  }
}
