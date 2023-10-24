import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';



class Circularbutton2 extends StatefulWidget {
  const Circularbutton2({
    Key? key,

    this.btnColor = AppConstant.primaryColor,
    this.textColor = AppConstant.titlecolor,
    this.border,
  }) : super(key: key);



  final Color? btnColor;
  final Color? textColor;
  final BoxBorder? border;

  @override
  State<Circularbutton2> createState() => _Circularbutton2State();
}

class _Circularbutton2State extends State<Circularbutton2> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return InkWell(

      child: Ink(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                100
            ),
          ),
          child: Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: widget.btnColor,
              borderRadius: BorderRadius.circular(
                100,
              ),
              border: widget.border,
            ),
            child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: Center(
                  child: CircularProgressIndicator(color: AppConstant.titlecolor,
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }



}