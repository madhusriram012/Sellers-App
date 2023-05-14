import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:se_delivery/global/global.dart';
import 'package:se_delivery/mainScreens/itemsScreen.dart';
import 'package:se_delivery/model/menus.dart';



class InfoDesignWidget extends StatefulWidget
{
  Menus? model;
  BuildContext? context;

  InfoDesignWidget({this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}



class _InfoDesignWidgetState extends State<InfoDesignWidget>
{
  deleteMenu(String menuID)
  {
    FirebaseFirestore.instance.collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuID)
        .delete();

    Fluttertoast.showToast(msg: "Menu Deleted Successfully.");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Color(0xffebf0f6),
      child: Padding(
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
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                child: Image.network(
                  widget.model!.thumbnailUrl!,
                  height: 220.0,
                  fit: BoxFit.cover,
                  width: 400,
                ),
              ),
              const SizedBox(height: 3.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.model!.menuTitle!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "Train",
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_sweep,
                      color: Color(0xffc3b091),
                    ),
                    onPressed: ()
                    {
                      //delete menu
                      deleteMenu(widget.model!.menuID!);
                    },
                  ),
                ],
              ),


              // Text(
              //   widget.model!.menuInfo!,
              //   style: const TextStyle(
              //     color: Colors.grey,
              //     fontSize: 12,
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
