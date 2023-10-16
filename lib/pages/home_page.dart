// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_one/pages/json_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> onBackPress() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to close the app?"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: DefaultTabController(
          length: 6,
          child: Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              title: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage('assets/elect1.jpeg'),
                        fit: BoxFit.fill)),
              ),
              // backgroundColor: const Color(0xFF9CD69C),
              backgroundColor: const Color(0xFFFFFFFF),
              bottom: const TabBar(
                labelColor: Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.w500),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
                tabs: [
                  Tab(child: Text("Ward 1")),
                  Tab(child: Text("Ward 2")),
                  Tab(child: Text("Ward 3")),
                  Tab(child: Text("Ward 4")),
                  Tab(child: Text("Ward 5")),
                  Tab(child: Text("Ward 6")),
                ],
                isScrollable: true,
              ),
              toolbarHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            body: const TabBarView(
              children: [
                JsonPage(jsonUrl: 'assets/ward1.json'),
                JsonPage(jsonUrl: 'assets/ward2.json'),
                JsonPage(jsonUrl: 'assets/ward3.json'),
                JsonPage(jsonUrl: 'assets/ward4.json'),
                JsonPage(jsonUrl: 'assets/ward5.json'),
                JsonPage(jsonUrl: 'assets/ward6.json'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
