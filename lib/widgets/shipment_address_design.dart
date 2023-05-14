import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se_delivery/global/global.dart';
import 'package:se_delivery/model/address.dart';
import 'package:se_delivery/splashScreen/splash_screen.dart';





class ShipmentAddressDesign extends StatelessWidget
{
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  ShipmentAddressDesign({this.model, this.orderStatus, this.orderId, this.sellerId, this.orderByUser});



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
                'Shipping Details:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16,fontFamily: "Inter")
            ),
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: const Text(
                        "Name",
                        style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: "Inter"),

                      ),
                    ),

                  Center(child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(model!.name!),
                  )),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: const Text(
                      "Phone Number",
                      style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: "Inter"),
                    ),
                  ),
                  Center(child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(model!.phoneNumber!),
                  )),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: const Text(
                      "Address   ",
                      style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: "Inter"),
                    ),
                  ),
                  Center(child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(model!.fullAddress!),
                  )),
                ],
              ),
            ],
          ),
        ),

        // Padding(
          // padding: const EdgeInsets.all(10.0),
         // Center(
         //    child: Text(
         //      "   Address:                      "+model!.fullAddress!,
         //      textAlign: TextAlign.justify,
         //      style: TextStyle(color: Colors.black,fontFamily: "Inter"),
         //    ),
         //  ),
        // ),
        const SizedBox(
          height: 15,
        ),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: const BoxDecoration(
                   color: Color(0xffc3b091),
                  ),
                  width: MediaQuery.of(context).size.width - 110,
                  height: 50,
                  child: Center(
                    child: Text(
                      orderStatus == "ended" ? "Go Back" : "Order Packing - Done",
                      style: const TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20,),
      ],
    );
  }
}
