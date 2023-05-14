import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se_delivery/global/global.dart';
import 'package:se_delivery/mainScreens/home_screen.dart';
import 'package:se_delivery/widgets/error_dialog.dart';
import 'package:se_delivery/widgets/progress_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;


class MenusUploadScreen extends StatefulWidget {
  const MenusUploadScreen({Key? key}) : super(key: key);

  @override
  _MenusUploadScreenState createState() => _MenusUploadScreenState();
}



class _MenusUploadScreenState extends State<MenusUploadScreen>
{
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen()
  {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color(0xff464646),
          ),
        ),
        title: const Text(
          "Add New Menu",
          style: TextStyle(fontSize: 26, fontFamily: "Clash",fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Color(0xffebf0f6),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shop_two, color: Colors.grey, size: 200.0,),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffc3b091)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                onPressed: ()
                {
                  takeImage(context);
                },
                child: const Text(
                  "Add New Menu",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.white,
                    fontSize: 18,

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  takeImage(mContext)
  {
    return showDialog(
      context: mContext,
      builder: (context)
      {
        return SimpleDialog(
          title: const Text("Menu Image", style: TextStyle(color: Color(0xffc3b091), fontWeight: FontWeight.bold),),
          children: [
            SimpleDialogOption(
              child: const Text(
                "Capture with Camera",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: captureImageWithCamera,
            ),
            SimpleDialogOption(
              child: const Text(
                "Select from Gallery",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: pickImageFromGallery,
            ),
            SimpleDialogOption(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: ()=> Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  captureImageWithCamera() async
  {
    Navigator.pop(context);

    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720 ,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  pickImageFromGallery() async
  {
    Navigator.pop(context);

    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720 ,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }


  menusUploadFormScreen()
  {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color(0xff464646),
          ),
        ),
        title: const Text(
          "Uploading New Menu",
          style: TextStyle(fontSize: 20, fontFamily: "Inter"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: ()
          {
            clearMenusUploadForm();
          },
        ),
        actions: [
          TextButton(
            child: const Text(
              "Add",
              style: TextStyle(
                color: Color(0xffc3b091),
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: "Varela",
                letterSpacing: 3,
              ),
            ),
            onPressed: uploading ? null : ()=> validateUploadForm(),
          ),
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgress() : const Text(""),
          Container(
            height: 330,
            width: MediaQuery.of(context).size.width * 0.4,
            child: Center(
              child: AspectRatio(
                aspectRatio: 12/9,
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: FileImage(
                          File(imageXFile!.path)
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            color:Color(0xffc3b091),
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.perm_device_information,  color: Color(0xffc3b091),),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: shortInfoController,
                decoration: const InputDecoration(
                  hintText: "Menu Info",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Color(0xffc3b091),
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.title,  color: Color(0xffc3b091),),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Menu Title",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Color(0xffc3b091),
            thickness: 1,
          ),
        ],
      ),
    );
  }

  clearMenusUploadForm()
  {
    setState(() {
      shortInfoController.clear();
      titleController.clear();
      imageXFile = null;
    });
  }

  validateUploadForm() async
  {
    if(imageXFile != null)
    {
      if(shortInfoController.text.isNotEmpty && titleController.text.isNotEmpty)
      {
        setState(() {
          uploading = true;
        });

        //upload image
        String downloadUrl = await uploadImage(File(imageXFile!.path));

        //save info to firestore
        saveInfo(downloadUrl);
      }
      else
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(
                message: "Please write title and info for menu.",
              );
            }
        );
      }
    }
    else
    {
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: "Please pick an image for menu.",
            );
          }
      );
    }
  }

  saveInfo(String downloadUrl)
  {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus");

    ref.doc(uniqueIdName).set({
      "menuID": uniqueIdName,
      "sellerUID": sharedPreferences!.getString("uid"),
      "menuInfo": shortInfoController.text.toString(),
      "menuTitle": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
    });

    clearMenusUploadForm();

    setState(() {
      uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
      uploading = false;
    });
  }

  uploadImage(mImageFile) async
  {
    storageRef.Reference reference = storageRef.FirebaseStorage
        .instance
        .ref()
        .child("menus");

    storageRef.UploadTask uploadTask = reference.child(uniqueIdName + ".jpg").putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  @override
  Widget build(BuildContext context)
  {
    return imageXFile == null ? defaultScreen() : menusUploadFormScreen();
  }
}
