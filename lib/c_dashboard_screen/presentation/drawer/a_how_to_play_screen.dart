import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:luckynumbers/utils/core/app_constant.dart';
import 'package:luckynumbers/utils/core/widgets/back_button.dart';
import 'package:http/http.dart' as http;

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({Key? key}) : super(key: key);

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {

  var data;
   termsCondition() async {
    print('aaaaaaa');
    final response = await http.get(Uri.parse(Apiconst.howtoplay));
    final datas = jsonDecode(response.body);
    print('aaaaaaaaaaaa');
    print(datas);
    if (datas['error'] == '200') {
      setState(() {
        data = datas['userdata'];
      });
      print(data);
    } else {}
  }

  @override
  void initState() {
    termsCondition();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.85;
    return Scaffold(
      appBar: AppBar(
        title: const Text('How To Play'),
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding:  EdgeInsets.all(8.0),
          physics:  BouncingScrollPhysics(),
          child: data == null
              ? Center(child: CircularProgressIndicator())
              : HtmlWidget(
            data['name'].toString(),
          ),
        ),
      ),
    );
  }
}
