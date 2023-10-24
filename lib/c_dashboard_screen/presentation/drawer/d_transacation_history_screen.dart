import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:luckynumbers/utils/core/widgets/back_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        leading: const CustomBackButton(),
      ),
      body: FutureBuilder<List<Album>>(
          future: bow(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data!.length);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: AppConstant.secondaryColor,
                      child: ListTile(
                        title: Text('${snapshot.data![index].description}'),
                        leading: Text('\u{20B9}'+'${snapshot.data![index].amount}',
                          style: TextStyle(
                            fontSize: 30,
                          ),),
                        subtitle: Text('${snapshot.data![index].datetime}'),
                        trailing: Text('${snapshot.data![index].type}',
                          style: TextStyle(
                            color: snapshot.data![index].type == 'debit'? Colors.red: Colors.green,

                          ),


                        ),
                      ),
                    ),
                  );
                }
            ):Center(child: Text("Wait For History"));
          }
      )
    );
  }
  Future<List<Album>> bow() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getString(key) ?? "0";

    final response = await http.get(
      Uri.parse(Apiconst.transctionhistory+value),
    );
    var jsond = json.decode(response.body)["country"];
    print(jsond);
    print('kkkkkkkkkkkkkkkkkkkkkkkkk');

    List<Album> allround = [];
    for (var o in jsond)  {
      Album al = Album(
        o["type"],
        o["amount"],
        o["description"],
        o["datetime"],
      );

      allround.add(al);
    }
    return allround;
  }
}
class Album {
  String? type;
  String? amount;
  String? description;
  String? datetime;
  Album(
      this.type,
      this.amount,
      this.description,
      this.datetime
      );

}

