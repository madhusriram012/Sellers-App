import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:se_delivery/global/global.dart';
import 'package:se_delivery/model/items.dart';
import 'package:se_delivery/splashScreen/splash_screen.dart';
import 'package:se_delivery/widgets/simple_app_bar.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();

  deleteItem(String itemID) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuID!)
        .collection("items")
        .doc(itemID)
        .delete()
        .then((value) {
      FirebaseFirestore.instance.collection("items").doc(itemID).delete();

      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
      Fluttertoast.showToast(msg: "Item Deleted Successfully.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: sharedPreferences!.getString("name"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                widget.model!.title.toString(),
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffDDDDDD),
                    blurRadius:6.0,
                    spreadRadius: 4.0,
                    offset: Offset(0.0, 0.0),
                  )
                ],
              ),
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    widget.model!.thumbnailUrl.toString(),
                    width: 350,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          ),

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  widget.model!.longDescription.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 14,fontFamily: "Inter"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  " ₹"+ widget.model!.price.toString(),
                  style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),


          const SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () {
                //delete item
                deleteItem(widget.model!.itemID!);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  decoration: const BoxDecoration(
                    color:Color(0xffc3b091),
                  ),
                  width: MediaQuery.of(context).size.width - 80,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Delete this Item",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
