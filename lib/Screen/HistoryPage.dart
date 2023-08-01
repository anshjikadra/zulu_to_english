import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tagalog_translate/Screen/DrawerUi.dart';
import 'package:tagalog_translate/main.dart';
import '../model/history_hive.dart';
import 'FirstScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor:blueColor,
        title: Text("History", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                OpenDilouge();
                setState(() {});
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              )),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: ValueListenableBuilder(
        valueListenable: history.listenable(),
        builder: (context, value, child) {
          return ListView.builder(
            //physics: NeverScrollableScrollPhysics(),
            itemCount: history.length,
            itemBuilder: (context, index) {
              var data = history.getAt((history.length - 1) - index);
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:Color.fromRGBO(246, 245, 245, 1),
                ),
                margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: ListTile(

                  onTap: () {
                    log('heleloeoe');
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return FirstScreen(
                          ui: data!.input,
                          uo: data.output,
                        );
                      },
                    )

                    );
                  },
                  title: Text(data!.input,style: TextStyle(
                      fontSize: 17, fontFamily: 'boldFont')),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(data.output,style: TextStyle(
                          fontSize: 15, fontFamily: 'semiBold'))),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  OpenDilouge() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Delete History',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              content: const Text('Are you sure?'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      history.clear();
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                           bgColor)),
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(bgColor)),
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ));
  }
}
