import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';



class LiveResult extends StatefulWidget {


  @override
  State<LiveResult> createState() => _LiveResultState();
}

class _LiveResultState extends State<LiveResult> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Album>>(
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
            child: Text('No Data Found'),
          );
        }
        else {
          return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 1,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                print(snapshot.data!.length);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: AppConstant.secondaryColor,
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          decoration: BoxDecoration(
                            color: AppConstant.primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 5.0,
                            ),
                            child: Column(

                              children: [
                                Text(
                                  '${snapshot.data![index].single}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                    color:
                                    AppConstant.backgroundColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'SINGLE',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                    color:
                                    AppConstant.titlecolor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        title: Center(
                          child: Text(
                            'TIME : '+'${snapshot.data![index].time}',
                            style:
                            Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              'Winner Number',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                color:
                                AppConstant.subtitlecolor,
                              ),
                            ),
                            Text(
                              '${snapshot.data![index].dateTime}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                color: AppConstant
                                    .subtitlecolor,
                              ),
                            ),
                          ],
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: AppConstant.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              bottomLeft: Radius.circular(8.r),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 5.0,
                            ),
                            child: Column(

                              children: [
                                Text(
                                  '${snapshot.data![index].patti}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                    color:
                                    AppConstant.backgroundColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'PATTI',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                    color:
                                    AppConstant.titlecolor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }
  Future<List<Album>> bow() async {


    print('eeeeeeeeeeeee');
    final response = await http.get(
      Uri.parse(Apiconst.Chart),
    );
    var jsond = json.decode(response.body)["data"];
    print(jsond);
    List<Album> allround = [];
    for (var o in jsond) {
      Album al = Album(
        o["id"],
        o["gamesno"],
        o["single"],
        o["patti"],
        o["status"],
        o["time"],
        o["date_time"],
      );
      allround.add(al);
    }
    return allround;
  }
}
class Album {
  String? id;
  String? gamesno;
  String? single;
  String? patti;
  String? status;
  String? time;
  String? dateTime;

  Album(
      this.id,
      this.gamesno,
      this.single,
      this.patti,
      this.status,
      this.time,
      this.dateTime,
      );}
