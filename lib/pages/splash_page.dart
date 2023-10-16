// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_one/pages/home_page.dart';


class SplashPage extends StatefulWidget {

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startSplash();
  }

  void startSplash() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
          image: AssetImage(
            'assets/elec3.jpg',
          ),
          fit: BoxFit.fitWidth,
        ))),
      ),
    );
  }
}
