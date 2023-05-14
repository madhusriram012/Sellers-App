import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:se_delivery/authentication/auth_screen.dart';
import 'package:se_delivery/global/global.dart';
import 'package:se_delivery/mainScreens/home_screen.dart';
import 'package:se_delivery/widgets/customTextField.dart';
import 'package:se_delivery/widgets/error_dialog.dart';
import 'package:se_delivery/widgets/loading.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  formValidation()
  {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
    {
      //login
      loginNow();
    }
    else
    {
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: "Please write email/password.",
            );
          }
      );
    }
  }


  loginNow() async
  {
    showDialog(
        context: context,
        builder: (c)
        {
          return LoadingDialog(
            message: "Checking Credentials",
          );
        }
    );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: error.message.toString(),
            );
          }
      );
    });
    if(currentUser != null)
    {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async
  {
    await FirebaseFirestore.instance.collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if(snapshot.exists)
      {
        if(snapshot.data()!["status"]=="approved"){
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!.setString("email", snapshot.data()!["sellerEmail"]);
          await sharedPreferences!.setString("name", snapshot.data()!["sellerName"]);
          await sharedPreferences!.setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);

          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
        }else{
          firebaseAuth.signOut();
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Admin has blocked your account.\n\nMail:admin1@gmail.com !!");
        }

      }
      else
      {
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));

        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(
                message: "No record found.",
              );
            }
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: const Padding(
              padding: EdgeInsets.all(15),
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/samosa-logo.png"),
                  radius: 80,
                ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Email",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObsecre: true,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xffDDDDDD),
                  blurRadius:8.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 0.0),
                )
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:Color(0xff111111),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
              onPressed: ()
              {
                formValidation();
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
              ),
            ),
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}
