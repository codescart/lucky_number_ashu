import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeTag extends StatefulWidget {
  const WelcomeTag({Key? key}) : super(key: key);

  @override
  State<WelcomeTag> createState() => _WelcomeTagState();
}

class _WelcomeTagState extends State<WelcomeTag> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        Container(
          height: 200.r,
          width: 200.r,
          child: Image(image:AssetImage("assets/images/dmatka1.png") ),
        ),
        // SizedBox(
        //   height: 10.h,
        // ),
        // Text(
        //   'Welcome to ',
        //   style: Theme.of(context).textTheme.headline2,
        // ),
        // Text(
        //   'My Lucky Number',
        //   style: Theme.of(context).textTheme.headline2!.copyWith(
        //         fontWeight: FontWeight.w900,
        //       ),
        // ),
        SizedBox(
          height: 50.h,
        ),
      ],
    );
  }
}
