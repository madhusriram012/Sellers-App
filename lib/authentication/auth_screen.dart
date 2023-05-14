import 'package:flutter/material.dart';
import 'package:se_delivery/authentication/login.dart';
import 'package:se_delivery/authentication/register.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color(0xff464646),
            ),
          ),
          automaticallyImplyLeading: false,
          title: const Text(
            "samosa squad",
            style: TextStyle(
              fontSize: 35,
              letterSpacing: 3,
              color: Colors.white,
              fontFamily: "Clash",
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.white,),
                text: "Login",
              ),
              Tab(
                icon: Icon(Icons.person, color: Colors.white,),
                text: "Register",
              ),

            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 6,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
          ),
          child: const TabBarView(
            children: [
              LoginScreen(),
              RegisterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
