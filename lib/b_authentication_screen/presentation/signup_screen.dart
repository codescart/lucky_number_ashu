import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/b_authentication_screen/presentation/otp_verification_screen.dart';
import 'package:luckynumbers/b_authentication_screen/presentation/privacy_policy_screen.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/custom_button.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/_main_dashboard_screen.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/pklogon.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:luckynumbers/utils/core/widgets/Circularprogressbutton.dart';
import 'package:luckynumbers/utils/core/widgets/back_button.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luckynumbers/utils/core/widgets/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  final String? phone;


   SignupScreen({ required this.phone,});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPasswordVisible =false;
  bool isChecked = false;
  final userName = TextEditingController();
 // final userEmail = TextEditingController();
  final _number = TextEditingController();
 // final userPassword = TextEditingController();
  final userState = TextEditingController();
  final userReferralCode = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _number.text = widget.phone.toString();
  }
  @override

  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppConstant.primaryColor;
    }
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Register & Play'),
            leading: const CustomBackButton(),
          ),
          //backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                            child:
                            Image(image: AssetImage("assets/images/dmatka1.png"),)
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: userName,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow,
                        ),
                      ),
                      labelText: 'Name',
                    ),

                  ),
                  // TextFormField(
                  //   controller: userEmail,
                  //   decoration: const InputDecoration(
                  //
                  //     border: UnderlineInputBorder(
                  //
                  //     ),
                  //     focusedBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: Colors.yellow,
                  //       ),
                  //     ),
                  //
                  //     labelText: 'Email Address',
                  //   ),
                  // ),
                  // TextFormField(
                  //   controller: userPassword,
                  //   obscureText: true,
                  //   decoration: const InputDecoration(
                  //
                  //     border: UnderlineInputBorder(),
                  //     focusedBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: Colors.yellow,
                  //       ),
                  //     ),
                  //
                  //     labelText: 'Password',
                  //   ),
                  // ),
                  TextFormField(
                    readOnly: true,
                    controller: _number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow,
                        ),
                      ),

                      labelText: 'Mobile No',
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 150.w,
                        child: TextFormField(
                          controller: userState,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.yellow,
                              ),
                            ),

                            labelText: 'State',
                          ),
                        ),
                      ),

                      SizedBox(width: 40.w,),
                      Container(
                        width: 150.w,
                        child: TextFormField(
                          controller: userReferralCode,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.yellow,
                              ),
                            ),

                            labelText: 'Referal code',
                            hintStyle: TextStyle(
                              color: Colors.white
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [

                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'By signing up you will agree to our ',
                            ),
                            TextSpan(
                              text: 'Privacy\nPolicy',style: TextStyle(color: AppConstant.primaryColor),
                              recognizer: TapGestureRecognizer()..onTap =(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicyScreen()));
                              },
                            ),
                            TextSpan(
                              text: ' and ',
                            ),
                            TextSpan(
                              text: 'Terms',style: TextStyle(color: AppConstant.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicyScreen()));
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  _loading==false?
                  ButtonTheme(
                      height: 40,
                      minWidth: 200,
                      child: CustomButton(
                          text:'Register',
                          onTap: (){
                            Register(userName.text,_number.text,userState.text,userReferralCode.text);
                          },
                      )
                  ):Circularbutton2()
                ],
              ),
            ),
          ),
        )
    );
  }

  bool _loading = false;
  Register(String userName, String _number,  String userState, String userReferralCode, ) async {

    setState(() {
      _loading = true;
    });
    final response = await http.post(
      Uri.parse(
          Apiconst.baseurl+"register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile': _number,
        'name':userName,
        "state":userState,
        "referral_code":userReferralCode
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (data['error'] == 200) {

      setState(() {
        _loading = false;
      });
      final mobile = data['id'];
      final otp = data['otp'];

     Utils.flushBarsuccessMessage(data['msg'], context, AppConstant.titlecolor);
      print("Register SucessFully");

      Navigator.push(context, MaterialPageRoute(
          builder: (context) => OTPScreens(phone:_number,id:mobile, otp: otp,)));
    } else {
      setState(() {
        _loading = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, AppConstant.titlecolor);

    }
  }
}
