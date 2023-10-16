// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:translator/translator.dart';

class JsonPage extends StatefulWidget {
  final String jsonUrl;
  const JsonPage({super.key, required this.jsonUrl});

  @override
  State<JsonPage> createState() => _JsonPageState();
}

class _JsonPageState extends State<JsonPage> {
  List listItems = [];
  List filteredList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  Future<void> getJsonData() async {
    final String response = await rootBundle.loadString(widget.jsonUrl);
    if (response != null && response.toString().trim().isNotEmpty) {
      final data = await json.decode(response);
      listItems.addAll(data['data']);
      filteredList.addAll(data['data']);
      setState(() {});
    }
  }

  void filterList(String query) {
    filteredList.clear();
    if (query.isEmpty) {
      filteredList.addAll(listItems);
    } else {
      // var searchList = listItems.where((item) =>
      //     item['serial_number'].toString().contains(query) ||
      //     // item['name_mr'].contains(query) ||
      //     item['name_en'].contains(query));

      var searchList = listItems
          .where((e) =>
              e["serial_number"]
                  .toString()
                  .toLowerCase()
                  .trim()
                  .contains(query) ||
              e["name_en"].toString().toLowerCase().trim().contains(query))
          .toList();
      filteredList.addAll(searchList);
    }
    setState(() {});
  }

  // Future<String> translateToMarathi(String searchText) async {
  //   // final translator = GoogleTranslator();
  //   // final input = "Здравствуйте. Ты в порядке?";
  //   // translator.translate(searchText, from: 'ru', to: 'en').then(print);
  //   // var translation =
  //   //     await translator.translate("Dart is very cool!", to: 'pl');
  //   // print(translation);
  //   // print(await "example here".translate(to: 'mr'));

  //   if(searchText.isEmpty || searchText == null){
  //     return '';
  //   }
  //   final translatedText = await searchText.translate(to: 'mr');
  //   print("TRANSLATED TEXT : " + translatedText.text);
  //   return translatedText.text;
  // }

  Widget borderContainer(String text, int flex, bool isTitle) {
    return Expanded(
      flex: flex,
      child: Container(
        height: isTitle ? 30 : 35,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(
                color: !isTitle ? Colors.grey.shade300 : Colors.grey.shade500),
            color: !isTitle ? Colors.white : Colors.grey.shade300),
        child: Text(text),
      ),
    );
  }

  Future<bool> onBackPress() async {
     
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextField(
            controller: searchController,
            onChanged: (query) async {
              filterList(searchController.text.toLowerCase());
            },
            decoration: const InputDecoration(
              hintText: 'Search...',
            ),
          ),
          actions: searchController.text.isEmpty
              ? []
              : [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          searchController.text = '';
                          filteredList.clear();
                          filteredList.addAll(listItems);
                        });
                      },
                      icon: Icon(Icons.clear))
                ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                // borderContainer('भाग', 2, true),
                borderContainer('अनु क्र.', 3, true),
                borderContainer('नाव', 11, true),
                // borderContainer('वय', 2, true),
                // borderContainer('लिंग', 2, true),
              ],
            ),
            listItems.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return Row(children: [
                          // borderContainer(filteredList[index]['bhag_number'] ?? '',  2,  false),
                          borderContainer(
                              filteredList[index]['serial_number'].toString(),
                              3,
                              false),
                          borderContainer(
                              filteredList[index]['name_mr'] ?? '', 11, false),
                          // borderContainer( filteredList[index]['age'] ?? '', 2, false),
                          // borderContainer( filteredList[index]['gender'] ?? '', 2, false),
                        ]);
                      },
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.warning_amber,
                            color: Colors.red[400],
                            size: 32,
                          ),
                        ),
                        Text("No Data Available"),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
