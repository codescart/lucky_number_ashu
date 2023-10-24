import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/b_authentication_screen/widgets/custom_button.dart';
import 'package:luckynumbers/c_dashboard_screen/presentation/Referalhistory.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:scratcher/scratcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class scrachpop extends StatefulWidget {
  final reffhistory code;
  scrachpop({required this.code});

  @override
  State<scrachpop> createState() => _scrachpopState();
}

class _scrachpopState extends State<scrachpop> {
  double _opacity = 0.0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppConstant.subtitlecolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      title: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "You Earned Gift",
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Divider(
              color: Colors.black,
            ),
          ),
        ],
      ),
      content: StatefulBuilder(builder: (context, StateSetter setState) {
        return Scratcher(
          color: Colors.cyan,
          accuracy: ScratchAccuracy.low,
          threshold: 30,
          brushSize: 40,
          onThreshold: () {
            setState(() {
              _opacity = 1;
            });
          },
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 100),
            opacity: _opacity,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                children: [
                  Text(
                    widget.code.matchcode == null ? '' : '${widget.code.matchcode}',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                      child: Image(
                    image: NetworkImage(
                        widget.code.image == null ? 'Wait....' :'${widget.code.image}'),
                  ))
                ],
              ),
            ),
          ),
        );
      }),
      actions: [
        CustomButton(
            onTap: () {

              Reedem( widget.code.coupon_code.toString(), context);
             // Navigator.pop(context);
            },
            text: 'Close')
      ],
    );
  }


}
