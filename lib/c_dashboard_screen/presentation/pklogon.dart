
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/custom_button.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/welcome_tag.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/_main_dashboard_screen.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:luckynumbers/utils/core/widgets/flushbar.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';




class OTPScreens extends StatefulWidget {
  final String? phone;
  final String? id;
  final String? otp;
  OTPScreens({
    required this.phone,
    required this.id,
    required this.otp
  });
  @override
  _OTPScreensState createState() => _OTPScreensState();
}

class _OTPScreensState extends State<OTPScreens> {

  String code = "";
  _verifyOtpCode(String code)async {


    print(code);
    print("hhhhhhh");
    print(code);
    print(widget.otp);


    if (int.parse(widget.otp.toString()) == int.parse(code)) {

      final prefs1 = await SharedPreferences.getInstance();
      final key1 = 'user_id';
      final mobile = widget.id.toString();
      prefs1.setString(key1, mobile);
      print('qqqqqqqqqqqqqqqq');
      print('rrrrrrrrrrrrrr');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>MainDashboardScreen()));
    }
    else {

      Utils.flushBarErrorMessage('Incorrect OTP', context, AppConstant.backgroundColor);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding:  EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Center(
                      child: WelcomeTag(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Verification',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp,
                          color: AppConstant.titlecolor
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 5.h),
                      child: Text('Enter the code send to the number',
                        style: TextStyle(color:AppConstant.titlecolor),),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 5.h),
                      child: Text('+91'+"${widget.phone}",
                        style: TextStyle(color:AppConstant.titlecolor),),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18,right: 18),
                      child: Center(
                        child: Container(
                          height: 40.h,
                          child: Pinput(
                            onChanged: (value) {
                              setState(() {
                                code = value;
                              });
                            },
                            length: 6,
                            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            errorPinTheme: defaultPinTheme.copyBorderWith(

                              border: Border.all(color: Colors.redAccent),
                            ),
                            disabledPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      width: double.maxFinite,
                      child:  CustomButton(
                        text: 'Submit',
                        textColor: AppConstant.titlecolor,
                        onTap: () {
                          print(code);
                          print('wwwwwwwwww');
                          _verifyOtpCode( code);
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
  bool _loading =false;
  Color focusedBorderColor = AppConstant.titlecolor;
  Color fillColor = AppConstant.titlecolor;
  Color borderColor = AppConstant.primaryColor;


  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: AppConstant.backgroundColor,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: AppConstant.primaryColor),
    ),
  );



}
