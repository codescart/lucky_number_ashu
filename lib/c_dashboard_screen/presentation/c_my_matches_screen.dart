import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMatchesScreen extends StatefulWidget {
  const MyMatchesScreen({Key? key}) : super(key: key);

  @override
  State<MyMatchesScreen> createState() => _MyMatchesScreenState();
}

class _MyMatchesScreenState extends State<MyMatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.control_point_duplicate),
        title: const Text('My Match'),
      ),
      body: RefreshIndicator(
        onRefresh: () async  {
          setState(() {
            bow();
            //error
          });
        },
        child: FutureBuilder<List<Album>>(
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
                child: Text('No Match Found'),
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
                          color: AppConstant.secondaryColor,
                          child: Column(
                            children: [
                              snapshot.data![index].status =='1'?
                              Container(
                                height: 20,width: 250,
                                decoration: BoxDecoration(
                                  color:Colors.green,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8.r),
                                    bottomLeft: Radius.circular(8.r),
                                  ),
                                ),
                                child: Center(child: Text("WINNER")),
                              ):snapshot.data![index].status =='2'?  Container(
                                height: 20,width: 250,
                                decoration: BoxDecoration(
                                  color:Colors.red,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8.r),
                                    bottomLeft: Radius.circular(8.r),
                                  ),
                                ),
                                child: Center(child: Text("LOSS")),
                              )
                                  : Container(),
                              ListTile(
                                leading: Text('\u{20B9}'+'${snapshot.data![index].amount}',
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Time : '+' '+'${snapshot.data![index].time}'),
                                    Text('Bet Time '+'${snapshot.data![index].datetime}')
                                     //   ' '+'${snapshot.data![index].time}'),
                                  ],
                                ),
                                trailing: Container(
                                  decoration: BoxDecoration(
                                    color:
                                    snapshot.data![index].status=='1'?
                                    AppConstant.primaryColor :AppConstant.secondaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.r),
                                      bottomLeft: Radius.circular(8.r),
                                      // topRight: Radius.circular(8.r),
                                      // bottomRight: Radius.circular(8.r),

                                    ),
                                  ),
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 12.0,
                                    ),
                                    child: Text('${snapshot.data![index].number}', style:
                                    Theme
                                        .of(context)
                                        .textTheme
                                        .headline3!
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
        ),
      ),

    );
  }
  Future<List<Album>> bow() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getString(key) ?? "0";
    final response = await http.get(
      Uri.parse(Apiconst.MYmatch+'user_id='+value),
    );
    var jsond = json.decode(response.body)["country"];
    print(jsond);
    List<Album> allround = [];
    for (var o in jsond)  {
      Album al = Album(
        o["id"],
        o["userid"],
        o["number"],
        o["amount"],
        o["gamesno"],
        o["time"],
        o["datetime"],
        o["status"],
      );

      allround.add(al);
    }
    return allround;
  }
}
class Album {


  String? id;
  String? userid;
  String? number;
  String? amount;
  String? gamesno;
  String? time;
  String? datetime;
  String? status;






  Album(
      this.id,
      this.userid,
      this.number,
      this.amount,
      this.gamesno,
      this.time,
      this.datetime,
      this.status
      );

}

