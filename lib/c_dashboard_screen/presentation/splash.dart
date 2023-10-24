import 'dart:async';
import 'package:flutter/material.dart';
import 'package:luckynumbers/b_authentication_screen/presentation/welcome_screen.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/_main_dashboard_screen.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var email;

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds:5),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>  email == null ? WelcomeScreen() : MainDashboardScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppConstant.backgroundColor,
      body:Column(
        children: [
          SizedBox(height: 200,),
          Center(
            child: Container(
               height: 300,width: 320,
              child:Image.asset("assets/images/dmatka1.png",
              ),
            ),
          ),
          SizedBox(height: 100,),
          Text('Welcome to',style: TextStyle(fontSize: 25,color: Colors.white),),
          Text('My Lucky Number',style: TextStyle(fontSize: 30,color: Colors.white),)
        ],
      ),
    );
  }
}
