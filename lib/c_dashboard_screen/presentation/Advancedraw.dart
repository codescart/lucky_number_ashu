import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/Myluckygame/myluckygamehome.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/custom_button.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class advancepopup extends StatefulWidget {
  const advancepopup({Key? key}) : super(key: key);

  @override
  State<advancepopup> createState() => _advancepopupState();
}

class _advancepopupState extends State<advancepopup> {

  bool isTapped = false;
  int selectedIndex = -1;


  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppConstant.primaryColor,
            radius: 22.r,
            child: CircleAvatar(
              backgroundColor: AppConstant.secondaryColor,
              radius: 18.r,
              child: Icon(
                Icons.games_outlined,
                color: AppConstant.titlecolor,
                size: 16.sp,
              ),
            ),
          ),
          Text(
            'ADVANCE DRAW',
            style: Theme
                .of(context)
                .textTheme
                .headline3,
          ),
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close))
        ],
      ),
      content:

      Container(
        height: 300.h,
        child:FutureBuilder<List<Advancedraw>>(
          future: khc(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No Data Found'),
              );
            }
            else {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return    InkWell(
                    onTap: (){
                      print(index);

                      setState(() {
                       time= "${snapshot.data![index].time}";
                      selectedIndex = index;
                    });},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: selectedIndex == index ?AppConstant.primaryColor: AppConstant.secondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: selectedIndex == index ?AppConstant.titlecolor:AppConstant.primaryColor,
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
                            title: Text(
                              '${snapshot.data![index].time}'+': 00',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline3,
                            ),

                            trailing: Column(
                              children: [
                                Icon(
                                  selectedIndex == index ?
                                  Icons.pause_circle_filled:
                                  Icons.play_circle_fill_rounded,
                                  size: 34.sp,
                                  color:  selectedIndex == index ?AppConstant.titlecolor:AppConstant.primaryColor,
                                ),
                                Text(
                                  "Play",
                                  style:TextStyle(
                                    color: Colors.white,fontWeight: FontWeight.w500
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ) ;
                },
              );
            }
          },
        ),
      ),

      actions: [

        time==null?Container():
        CustomButton(onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>gamehome(time:time)));
        }, text: 'submit')
      ],

    );
  }
  Future<List<Advancedraw>> khc() async{

    final response = await http.get(
      Uri.parse(Apiconst.Advancedraw),
    );
    final data = json.decode(response.body);
    print('pppppppp');
    print(data);
    final jsond = json.decode(response.body)['advancedraw'];
    print('pppppppp');
    print('wwwwwwwwwwwwwwwwwwww');

    List<Advancedraw> allround = [];
    for (var o in jsond)  {
      Advancedraw al = Advancedraw(
        o["time"],
      );

      allround.add(al);
    }

    return allround;
  }
}
String time= '';
class Advancedraw {
  int? time;
  Advancedraw(
      this.time,
      );
}
