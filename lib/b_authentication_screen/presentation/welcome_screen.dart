import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/b_authentication_screen/presentation/login_screen.dart';
import 'package:luckynumbers/b_authentication_screen/presentation/otp_screen.dart';
import 'package:luckynumbers/b_authentication_screen/presentation/signup_screen.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/custom_button.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               SizedBox(),
              Padding(
                padding:  EdgeInsets.all(50.0.r),
                child: Image.asset("assets/images/dmatka1.png"),
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomButton(
                      text: 'Login with Phone',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OTPScreen(),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const OTPScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Login',
                              style:
                                  Theme.of(context).textTheme.headline4!.copyWith(
                                        color: AppConstant.primaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
