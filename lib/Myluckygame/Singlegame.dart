import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/custom_button.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:luckynumbers/utils/core/widgets/Circularprogressbutton.dart';
import 'package:luckynumbers/utils/core/widgets/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Single_game_page extends StatefulWidget {
  final String time;
  Single_game_page({ required  this.time});

  @override
  State<Single_game_page> createState() => _Single_game_pageState();
}

class _Single_game_pageState extends State<Single_game_page> {


  final Singlegame = TextEditingController() ;

  final Singleamount = TextEditingController() ;

  String resultText = "";

  @override
  void initState() {
    super.initState();
    Singleamount.addListener(_calculateResult);
  }

  void _calculateResult() {
    int inputNumber = int.tryParse(Singleamount.text) ?? 0;
    setState(() {
      resultText = "$inputNumber x 9 = ₹ ${inputNumber * 9}";
    });
  }

  @override
  void dispose() {
    Singleamount.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: Singlegame,
            style: Theme.of(context).textTheme.headline4,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                counter: Offstage(),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Color(0xFFF65054)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Color(0xFFF65054)),
                ),
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 10.w),
                    Icon(Icons.looks_one_outlined, color: Colors.white),
                    Container(width: 2,color: Colors.white,
                      height: 30.h,
                    )
                  ],
                ),
                fillColor:  AppConstant.secondaryColor,
                filled: true,
                hintText: "Choose any 1 number",
                hintStyle: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w900)
            ),
            keyboardType: TextInputType.number,
            maxLength: 1,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('*\Select only Single no. 0 to 9',style: Theme.of(context).textTheme.headline4,)),


          SizedBox(height: 30.h,),
          TextField(
            controller: Singleamount,
            style: Theme.of(context).textTheme.headline4,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                counter: Offstage(),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Color(0xFFF65054)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Color(0xFFF65054)),
                ),
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 10.w),
                    Icon(Icons.money_rounded, color: Colors.white),
                    Container(width: 2,color: Colors.white,
                      height: 30.h,
                    )
                  ],
                ),
                fillColor:  AppConstant.secondaryColor,
                filled: true,
                hintText: "Enter Amount",
                hintStyle: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w900)
            ),
            keyboardType: TextInputType.number,
            maxLength: 7,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(resultText,style: Theme.of(context).textTheme.headline4,)),
          SizedBox(height: 100.h,),
          _loading==false?
          CustomButton(onTap: (){
            Singlegameapi(Singlegame.text,Singleamount.text);
          }, text: 'SUBMIT',):Circularbutton2()
        ],
      ),
    );
  }
  bool _loading = false;
  Singlegameapi(String Singlegame,String Singleamount) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getString(key) ?? "0";

    setState(() {
      _loading = true;
    });

    print('gggggggggggggggggggggg');
    final response = await http.post(
      Uri.parse(Apiconst.Gamebet),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": value,
        "number": Singlegame,
        "amount": Singleamount,
        "time": widget.time,

      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print('aaaaaaaaaaaaaaaaa');
    print('rrrrrrrrrrrrrrrrrr');
    if (data["error"] == "200") {
      setState(() {
        _loading = false;
      });
      Navigator.pop(context);
    } else {
      setState(() {
        _loading = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, AppConstant.titlecolor);
      print("Error");
    }
  }
}
