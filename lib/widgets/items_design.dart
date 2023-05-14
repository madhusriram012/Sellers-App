import 'package:flutter/material.dart';
import 'package:se_delivery/mainScreens/item_detail_screen.dart';
import 'package:se_delivery/mainScreens/itemsScreen.dart';
import 'package:se_delivery/model/items.dart';
import 'package:se_delivery/model/menus.dart';



class ItemsDesignWidget extends StatefulWidget
{
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}



class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailsScreen(model: widget.model)));
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
               // borderRadius: BorderRadius.circular(20),
               child: Image.network(
                      widget.model!.thumbnailUrl!,
                      height: 200.0,
                      fit: BoxFit.cover,
                      width: 400,
                    ),
             ),
              const SizedBox(height: 13.0,),
              Text(
                widget.model!.title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "Inter",
                ),
              ),

              const SizedBox(height: 5.0,),
              Text(
                widget.model!.shortInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              // Divider(
              //   height: 4,
              //   thickness: 3,
              //   color: Colors.grey[300],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
