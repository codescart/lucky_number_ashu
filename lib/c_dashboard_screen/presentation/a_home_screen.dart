import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/b_authentication_screen/presentation/welcome_screen.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/custom_button.dart';
import 'package:luckynumbers/c_dashboard_screen/all_gameview.dart';
import 'package:luckynumbers/c_dashboard_screen/application/crasual_slider.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/action_bar/wallet_screen.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/drawer/a_how_to_play_screen.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/drawer/account_page.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/drawer/b_change_password_screen.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/drawer/c_company_trust_profile_screen.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/drawer/d_transacation_history_screen.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/live%20_result.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/live%20game.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/upcoming_result_page.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/upcomming_game.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
var map;
class _HomeScreenState extends State<HomeScreen> {
  // late Future<Alb> futureAlbum;

  void initState() {
    leader();
    versioncheck();
    super.initState();
  }
  var mapl;

  var dap;

  bool raja=false;
  Future versioncheck() async{
    final response = await http.post(
      Uri.parse(Apiconst.baseurl+'version'),
    );
    var data = jsonDecode(response.body)['country'];

    if (data[0]['version']!= Apiconst.versioncode) {
      print("jsi ho");
      setState(() {
        raja=true;


      });
    }else{
      print("Bhag yha se");
    }
  }




  Future leader() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getString(key) ?? "0";
    final response = await http.post(
      Uri.parse(Apiconst.baseurl+'userpro'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id":"$value"
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    if (data['error'] == '200') {
      setState(() {
        map=json.decode(response.body)['country'];
        dap=json.decode(response.body)['Livetime'];


      });
    }
  }
  @override
  Widget build(BuildContext context) {
 //   Future.delayed(Duration(seconds: 3),() => showAlert(context));
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
             // shadowColor: Colors.black,
              title: Text('Are you sure?', style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppConstant.titlecolor,
              ),),
              content: Text('Do you want to exit from App', style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppConstant.titlecolor,
              ),),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: SafeArea(
        child: map==null?Center(child: CircularProgressIndicator()):
        Scaffold(
          appBar:
          AppBar(
            toolbarHeight: 70,
            title: Text('My Lucky Number',style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppConstant.secondaryColor,
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> WalletScreen()));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                              map['wallet'] == ''?
                              '\u{20B9}'+'0' : '\u{20B9}'+map['wallet'].toString(),
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      Icon(
                                        Icons.account_balance_wallet_outlined,
                                        size: 18.sp,
                                      )
                                    ],
                                  ),
                                  Text(
                                    'Wallet',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              ),
          drawer: Drawer(
            backgroundColor: AppConstant.backgroundColor,
            child: Column(
              children: [
                Container(
                  width: 260.w,
                  color: AppConstant.secondaryColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>  AccountScreen(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 40.r,
                          backgroundColor: AppConstant.backgroundColor,
                          child: Icon(
                            Icons.person_rounded,
                            size: 48.sp,
                            color: AppConstant.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                          map['name'] == ''?
                          'Your Name' : map['name'].toString(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        map['mobile'] == ''?
                        'Your mobile no' : map['mobile'].toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 1.5.h,
                        color: AppConstant.subtitlecolor.withOpacity(0.3),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    'How to play',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>  HowToPlayScreen(),
                      ),
                    );
                  },
                ),
                // ListTile(
                //   title: Text(
                //     'Change password',
                //     style: Theme.of(context).textTheme.headline4,
                //   ),
                //   onTap: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => ChangePasswordScreen(),
                //       ),
                //     );
                //   },
                // ),
                ListTile(
                  title: Text(
                    'Company trust profile',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CompanyTrustProfileScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Transaction History',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TransactionHistoryScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    'Website',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: _launchURL1    ,
                ),
                ListTile(
                  title: Text(
                    'Share app',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: (){share();}
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Version : ',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(Apiconst.versioncode,style: Theme.of(context).textTheme.headline5,),
                  ],
                ),

                SizedBox(
                  height: 5.h,
                ),
                Container(
                  color: AppConstant.secondaryColor,
                  child: ListTile(
                    title: Text(
                      'Sign out',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    onTap: () async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('user_id');
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext ctx) => WelcomeScreen()));
      },
                  ),
                ),
              ],
            ),
          ),
          body: map==null?Center(child: CircularProgressIndicator()):
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [

                SizedBox(
                  height: 20.h,
                ),
                Slider_wer(),


                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Live Results',
                  style: Theme.of(context).textTheme.headline3,
                ),

                LiveResult(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Live Games',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                Livegame(live:dap==null?'Betting Closed':dap),
                  SizedBox(
                    height: 10.h,
                  ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Text(
                //         'Upcoming Games',
                //         style: Theme.of(context).textTheme.headline3,
                //       ),
                //       const Spacer(),
                //       InkWell(
                //         onTap: (){
                //           Navigator.push(context, MaterialPageRoute(builder: (context)=> UpcommingResult()));
                //         },
                //         child: Text(
                //           'View All',
                //           style: Theme.of(context).textTheme.subtitle1,
                //         ),
                //       ),
                //       const Icon(
                //         Icons.keyboard_arrow_right_rounded,
                //         color: AppConstant.subtitlecolor,
                //       ),
                //     ],
                //   ),
                // SizedBox(
                //   height: 20.h,
                // ),
                // UpcommingGame(),
       ],
            ),
          ),
        ),
      ),
    );
  }
  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) =>
            raja==false?
            AlertDialog(
          content:

          Container(
            height: 300,
            child: Column(
              children: [
                Text(map['name'] == ''?
                'Your Name' : map['name'].toString(),
                  style: Theme.of(context).textTheme.headline4,),
                Text("जरुरी सुचना"),
                SizedBox(height: 15,),
                Text("आपके India Matka में खेलने पर आपको 1 के 100 का भुगतन मिलेगा\nIndia Matkaके सभी ग्राहक 24×7 अपने भुगतान की निकासी के लिए अनुरोध डाल सकते हैं सुबह 8 से 12 बीच आपका भुगतान डाल दिया जाएगा"),
                 SizedBox(height: 15,),
                Text("अगर किसी भी ग्राहक को India Matka  मे गेम प्ले करने में परेशानी आती है या पेमेंट निकालने में परेशानी आती \nहै तो नीचे दिये गये नंबर पर संपर्क करें धन्यवाद"),
                TextButton(onPressed:(){
                  _launchCaller();
                }, child: Text("+91 79884 98648")
                ),
              ],
            ),
          ),
          actions: [
             CustomButton(
              text: 'CLOSE',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ):AlertDialog(
              content: Container(
                child: Row(
                  children: [
                    Container(
                      width: 40,height: 40,
                      child: Image(image:AssetImage("assets/images/dmatka1.png") ),
                    ),
                    SizedBox(width: 20,),
                    Text('new version are avilable'),
                  ],
                ),

              ),
              actions: [
                CustomButton(
                  text: 'UPDATE',
                  onTap: () {
                    _launchURL();
                  },
                ),
              ],
            )

    );
  }
}
_launchCaller() async {
  const url = "tel:7988498648";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String referalCode = 'initialData';
Future<void> share() async {
  await FlutterShare.share(
      title: 'Referrel Code : '+ map['codes'].toString(),
      text: 'Join Now & Get Exiting Prizes. here is my Referrel Code : '+map['codes'].toString(),
      linkUrl: 'https://myluckynumber.in/',
      chooserTitle: 'Referrel Code : '+ referalCode.toString());
}
_launchURL() async {
  const url = 'https://myluckynumber.in/admin/myluckynumber.apk';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
_launchURL1() async {
  const url = 'https://myluckynumber.in/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

