import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tagalog_translate/Screen/DrawerUi.dart';
import 'package:tagalog_translate/Screen/FirstScreen.dart';
import 'package:tagalog_translate/jModel/DictionaryModel.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  TextEditingController searchDictionary = TextEditingController();

  List<DataDictionary> dData = [];

  @override
  void initState() {
    GetData();
  }

  GetData() async {
    var data = await rootBundle.loadString("assets/Zulu_Dictionary.json");
    List list = json.decode(data);
    dData = list.map((e) => DataDictionary.fromJson(e)).toList();
    print(dData);
    setState(() {});
  }

  //TODO Json File Read krva mate......................
  // getDat1()
  // async {
  //   var data= await rootBundle.loadString("assets/Zulu_Dictionary.json");
  //   List list=json.decode(data);
  //   dData=list.map((e) => DataDictionary.fromJson(e)).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
           iconTheme: IconThemeData(color: Colors.white, size: 25),
          backgroundColor: blueColor,
          title: const Text(
            "Dictionary",
            style: TextStyle(
                color: Colors.white, fontFamily: 'boldFont', fontSize: 22),
          ),
          // leading: IconButton(onPressed: () {
          //   setState(() {
          //     Navigator.pop(context);
          //   });
          // }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,)),
          centerTitle: false,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                height: 75,
                color: bgColor,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        query = value;
                        setState(() {});
                      },
                      controller: searchDictionary,
                    // textAlign: TextAlign.center,
                    // textAlignVertical: TextAlignVertical.center,

                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                              fontFamily: 'semiBold',
                              color: Color.fromRGBO(200, 196, 196, 1),
                              fontSize: 18,),
                          // filled: true,
                          // fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 28,
                            color: Color.fromRGBO(200, 196, 196, 1),
                          ),
                          suffixIcon: searchDictionary.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchDictionary.clear();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Color.fromRGBO(200, 196, 196, 1),
                                  ))
                              : SizedBox()),
                    ),
                  ),
                )),
            Expanded(
              child: listView(),
            )
          ],
        ),
      ),
    );
  }

  String query = '';

  Widget listView() {
    List<DataDictionary> matchQuery = [];
    query = searchDictionary.text;

    for (var item in dData) {
      if (item.word.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return Scrollbar(
      thickness: 3,
      isAlwaysShown: true,
      child: ListView.builder(

        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 10, bottom: 5, top: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(246, 245, 245, 1),
              ),
              child: ListTile(
                title: Text(
                  "${matchQuery[index].word}",
                  style: TextStyle(fontSize: 20, fontFamily: 'boldFont'),
                ),
                subtitle: Text(
                  "${matchQuery[index].meaning}",
                  style: TextStyle(fontSize: 16, fontFamily: 'semiBold'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
