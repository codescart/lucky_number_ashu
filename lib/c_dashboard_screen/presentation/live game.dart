import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:luckynumbers/Myluckygame/advancedrawpage.dart';
import 'package:luckynumbers/Myluckygame/myluckygamehome.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/custom_button.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/Advancedraw.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/games.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Livegame extends StatefulWidget {
  final String live;
  Livegame({ required this.live});

  @override
  State<Livegame> createState() => _LivegameState();
}
class _LivegameState extends State<Livegame> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(

          onTap: () async {
            widget.live=='Betting Closed'?Container():
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => gamehome(time: '',)));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: AppConstant.secondaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppConstant.primaryColor,
                    radius: 25.r,
                    child: CircleAvatar(
                      backgroundColor: AppConstant.secondaryColor,
                      radius: 20.r,
                      child: Icon(
                        Icons.games_outlined,
                        color: AppConstant.titlecolor,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  title: Center(
                    child: Text(
                     'TIME : '+ widget.live,

                      style: Theme
                          .of(context)
                          .textTheme
                          .headline4,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('12345' + "+ people are playing",
                          style: TextStyle(fontSize: 8)),
                      SizedBox(height: 5,),
                      widget.live=='Betting Closed'?Container():
                      Container(
                        height: 20, width: 100,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4.sp),
                        ),
                        child: Center(child: Text("BETTING OPEN",
                            style: TextStyle(fontSize: 12))),
                      ),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      Icon(
                        widget.live=='Betting Closed'? Icons.pause_circle_filled:
                        Icons.play_circle_fill_rounded,
                        size: 34.sp,
                        color: widget.live=='Betting Closed'? AppConstant.subtitlecolor:
                        AppConstant.primaryColor,
                      ),
                      Text(
                        widget.live=='Betting Closed'?'Pause':
                        "Play",
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>advancedrawpage()));
            // showDialog(
            //     context: context,
            //     builder: (context) =>advancepopup(),
            //
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: AppConstant.secondaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppConstant.primaryColor,
                    radius: 25.r,
                    child: CircleAvatar(
                      backgroundColor: AppConstant.secondaryColor,
                      radius: 20.r,
                      child: Icon(
                        Icons.apartment_rounded,
                        color: AppConstant.titlecolor,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  title: Text(
                    'Advance Draw',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4,
                  ),
                  trailing: Column(
                    children: [
                      Icon(
                        Icons.play_circle_fill_rounded,
                        size: 34.sp,
                        color: Colors.orange,
                      ),
                      Text(
                        "Play",
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}