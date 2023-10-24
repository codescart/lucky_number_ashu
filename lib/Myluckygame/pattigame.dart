import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/custom_button.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:luckynumbers/utils/core/widgets/Circularprogressbutton.dart';
import 'package:luckynumbers/utils/core/widgets/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Patti_game_page extends StatefulWidget {
  final String time;
   Patti_game_page({ required  this.time});

  @override
  State<Patti_game_page> createState() => _Patti_game_pageState();
}

class _Patti_game_pageState extends State<Patti_game_page> {

  final Pattigame = TextEditingController() ;
  final Pattiamount = TextEditingController();
  final _globalkey = GlobalKey<FormState>();

  String resultText = "";

  @override
  void initState() {
    super.initState();
    Pattiamount.addListener(_calculateResult);
  }

  void _calculateResult() {
    int inputNumber = int.tryParse(Pattiamount.text) ?? 0;
    setState(() {
      resultText = "$inputNumber x 90 = ₹ ${inputNumber * 90}";
    });
  }

  @override
  void dispose() {
    Pattiamount.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: _globalkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextFormField(
              validator: validateName,
              controller: Pattigame,
              style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w900),
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
                      Icon(Icons.three_k_outlined, color: Colors.white),
                      Container(width: 2,color: Colors.white,
                        height: 30.h,
                      )
                    ],
                  ),
                  fillColor:  AppConstant.secondaryColor,
                  filled: true,
                  hintText: "Choose any 3 number",
                  hintStyle: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w900)
              ),
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),

            Align(
                alignment: Alignment.centerLeft,
                child: Text('*\Select only 3 digit no. 000 to 999',style: Theme.of(context).textTheme.headline4,)),
            SizedBox(height: 30.h,),
            TextField(
              controller: Pattiamount,
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
            if (_globalkey.currentState!.validate()) {
              pattigameapi(Pattigame.text,Pattiamount.text);
            }

            }, text: 'SUBMIT',):Circularbutton2()
          ],
        ),
      ),
    );
  }
  bool _loading = false;
  pattigameapi(String Pattigame,String Pattiamount) async {
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
        "number": Pattigame,
        "amount": Pattiamount,
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

  String? validateName(String? value) {
    if (value!.length < 3)
      return 'Value must be 3 charater';
    else
      return null;
  }
}
