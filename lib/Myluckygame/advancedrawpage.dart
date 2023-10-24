import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/Myluckygame/myluckygamehome.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/custom_button.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:luckynumbers/utils/core/widgets/back_button.dart';


class advancedrawpage extends StatefulWidget {
  const advancedrawpage({Key? key}) : super(key: key);

  @override
  State<advancedrawpage> createState() => _advancedrawpageState();
}

class _advancedrawpageState extends State<advancedrawpage> {


  bool isTapped = false;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: CustomBackButton(),
            title:    Text(
              'ADVANCE DRAW',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline3,
            ),
            actions: [ CircleAvatar(
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
            ),],

          ),
        //  bottomNavigationBar:
          body: ListView(
            children: [
              FutureBuilder<List<Advancedraw>>(
                future: khc(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 500.h,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                      height: 500.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Advance Draw are closed today'),
                          SizedBox(height: 15.h,),
                          Text('Betting open tomorrow 09:00 A.M.  to  08:00 P.M.'),
                        ],
                      ),
                    );
                  }
                  else {
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical:20.h ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return    InkWell(
                                onTap: (){
                                  print(index);

                                  setState(() {

                                    selectedIndex = index;
                                  });
                                  time= "${snapshot.data![index].time}";
                                  },
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
                          ),

                        ],
                      ),
                    );
                  }
                },
              ),
              time==''?Container():
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomButton(onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>gamehome(time:time)));
                }, text: 'submit'),
              ),
              SizedBox(height: 20.h,)
            ],
          ),
        )
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
  String time= '';

}
class Advancedraw {
  int? time;
  Advancedraw(
      this.time,
      );
}
