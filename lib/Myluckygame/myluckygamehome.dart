
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/Myluckygame/Singlegame.dart';
import 'package:luckynumbers/Myluckygame/pattigame.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/custom_button.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/Advancedraw.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:luckynumbers/utils/core/widgets/back_button.dart';
import 'package:sliding_switch/sliding_switch.dart';


class gamehome extends StatefulWidget {
  final String time;
   gamehome({required this.time});

  @override
  State<gamehome> createState() => _gamehomeState();
}

class _gamehomeState extends State<gamehome> {
  bool _isSecondPage = false;

  void _toggleSwitch(bool value) {
    setState(() {
      _isSecondPage = value;
    });
  }

  final Pattigame = TextEditingController() ;
  final Pattiamount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Card(elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
                child: Container(
                  height: height*0.4,
                  width: width*1,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/dmatka1.png'),scale: 3),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      gradient: LinearGradient(
                          colors: [AppConstant.primaryColor, AppConstant.secondaryColor],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)
                    // color: bgcolor
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                          child: CustomBackButton()),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: SlidingSwitch(
                          value: _isSecondPage,
                          width: 280,
                          onChanged: _toggleSwitch,
                          height: 45,
                          animationDuration: const Duration(milliseconds: 400),
                          onTap: () {},
                          onDoubleTap: () {},
                          onSwipe: () {},
                          textOff: "SINGLE",
                          textOn: "PATTI",
                          colorOn: AppConstant.titlecolor,
                          colorOff: AppConstant.titlecolor,
                          background: AppConstant.subtitlecolor,
                          buttonColor: AppConstant.backgroundColor,
                          inactiveColor: AppConstant.backgroundColor,
                        ),
                      ),

                    ],
                  ),


                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: Colors.red,
                    //next card
                    child: Column(
                      children: [
                        SizedBox(height: 120,),

                        // SizedBox(height: 5,),



                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child:  Container(
                        height: 350.h,
                        decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.transparent),
                        child: _isSecondPage?Patti_game_page(time:widget.time)
                            : Single_game_page(time:widget.time)
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }

}

