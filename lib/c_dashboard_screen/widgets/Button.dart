import 'package:flutter/material.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';

class NewCustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const NewCustomButton({Key? key,required this.onPressed, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        style: ButtonStyle(

          backgroundColor: MaterialStateProperty.all<Color>(AppConstant.primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            )

        ),
        onPressed: onPressed,
        child: child);
  }
}
