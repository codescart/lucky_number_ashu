import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/b_authentication_screen/scrachpopup.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:luckynumbers/utils/core/widgets/back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class refferalhistory extends StatefulWidget {
  const refferalhistory({Key? key}) : super(key: key);

  @override
  State<refferalhistory> createState() => _refferalhistoryState();
}

class _refferalhistoryState extends State<refferalhistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: const Text('Refferal History'),
      ),
      body: FutureBuilder<List<reffhistory>>(
        future: bow(),
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
              child: Text('No Refferal Found'),
            );
          }
          else {
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data!.length);
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        color: AppConstant.secondaryColor,
                        child: Column(
                          children: [

                            ListTile(
                              onTap: (){
                                snapshot.data![index].coupon_status=='1'?
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) =>scrachpop(code:snapshot.data![index]),
                                ):Container();
                              },
                              leading: Text('${snapshot.data![index].name}',
                                style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                  color: AppConstant.titlecolor,
                                ),),
                              title: Center(child: Text('${snapshot.data![index].leftday}'+'/days left',
                                style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                  color: AppConstant.subtitlecolor,
                                ),
                              )),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  color:
                                  snapshot.data![index].coupon_status=='2'?
                                  AppConstant.subtitlecolor:AppConstant.primaryColor ,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.r),
                                    bottomLeft: Radius.circular(8.r),
                                    topRight: Radius.circular(8.r),
                                    bottomRight: Radius.circular(8.r),

                                  ),
                                ),
                                child:  Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                    vertical: 5.0,
                                  ),
                                  child: Text(snapshot.data![index].coupon_status=='2'?'Expired':
                                  '${snapshot.data![index].coupon_code}',
                                    style:
                                    Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                      color:Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                }
            );
          }
        },
      )


      // RefreshIndicator(
      //   onRefresh: () async  {
      //     setState(() {
      //       bow();
      //       //error
      //     });
      //   },
      //   child: FutureBuilder<List<reffhistory>>(
      //     future: bow(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       else if (snapshot.hasError) {
      //         return Center(
      //           child: Text('Error: ${snapshot.error}'),
      //         );
      //       }
      //       else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      //         return Center(
      //           child: Text('No Refferal Found'),
      //         );
      //       }
      //       else {
      //         return ListView.builder(
      //             physics: BouncingScrollPhysics(),
      //             itemCount: snapshot.data!.length,
      //             shrinkWrap: true,
      //             itemBuilder: (BuildContext context, int index) {
      //               print(snapshot.data!.length);
      //               return Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Card(
      //                     elevation: 5,
      //                     color: AppConstant.secondaryColor,
      //                     child: Column(
      //                       children: [
      //
      //                         ListTile(
      //                           onTap: (){
      //                             snapshot.data![index].coupon_status=='1'?
      //                             showDialog(
      //                               barrierDismissible: false,
      //                               context: context,
      //                               builder: (context) =>scrachpop(code:snapshot.data![index]),
      //                             ):Container();
      //                           },
      //                           leading: Text('${snapshot.data![index].name}',
      //                             style:
      //                             Theme.of(context).textTheme.headline4!.copyWith(
      //                               color: AppConstant.titlecolor,
      //                             ),),
      //                           title: Center(child: Text('${snapshot.data![index].leftday}'+'/days left',
      //                             style:
      //                             Theme.of(context).textTheme.headline5!.copyWith(
      //                               color: AppConstant.subtitlecolor,
      //                             ),
      //                           )),
      //                           trailing: Container(
      //                             decoration: BoxDecoration(
      //                               color:
      //                               snapshot.data![index].coupon_status=='2'?
      //                               AppConstant.subtitlecolor:AppConstant.primaryColor ,
      //                               borderRadius: BorderRadius.only(
      //                                 topLeft: Radius.circular(8.r),
      //                                 bottomLeft: Radius.circular(8.r),
      //                                 topRight: Radius.circular(8.r),
      //                                 bottomRight: Radius.circular(8.r),
      //
      //                               ),
      //                             ),
      //                             child:  Padding(
      //                               padding: const EdgeInsets.symmetric(
      //                                 horizontal: 5.0,
      //                                 vertical: 5.0,
      //                               ),
      //                               child: Text(snapshot.data![index].coupon_status=='2'?'Expired':
      //                                 '${snapshot.data![index].coupon_code}',
      //                                 style:
      //                               Theme.of(context)
      //                                   .textTheme
      //                                   .headline4!
      //                                   .copyWith(
      //                                 color:Colors.white,
      //                                 fontWeight: FontWeight.w700,
      //                               ),),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ));
      //             }
      //         );
      //       }
      //     },
      //   ),
      // ),

    );
  }
}
Reedem(String coupon_code, BuildContext context, )async {
  print(coupon_code);
  print('rrrrrrrrrrrrrrrrr');
  final response = await http.get(
    Uri.parse(
        Apiconst.reedemcode+coupon_code),
  );
  final data = jsonDecode(response.body);
  print(data);
  if (data['error'] == "200") {
    Navigator.pop(context);
    Navigator.pop(context);
    bow();
  } else {

  }
}
Future<List<reffhistory>> bow() async{
  final prefs = await SharedPreferences.getInstance();
  final key = 'user_id';
  final value = prefs.getString(key) ?? "0";
  final response = await http.get(
    Uri.parse(Apiconst.refferalhistory+value),
  );
  var jsond = json.decode(response.body)["data"];
  print(jsond);
  List<reffhistory> allround = [];
  for (var o in jsond)  {
    reffhistory al = reffhistory(
      o["name"],
      o["matchcode"],
      o["leftday"],
      o["image"],
      o["coupon_code"],
      o["coupon_status"],
    );
    allround.add(al);
  }
  return allround;
}

class reffhistory {
  String? name;
  String? matchcode;
  String? leftday;
  String? image;
  String? coupon_code;
  String? coupon_status;
  reffhistory(
      this.name,
      this.matchcode,
      this.leftday,
      this.image,
      this.coupon_code,
      this.coupon_status,

      );

}

