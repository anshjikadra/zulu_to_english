import 'package:flutter/material.dart';
import 'package:tagalog_translate/Screen/DrawerUi.dart';
import 'package:tagalog_translate/main.dart';

import 'FirstScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavScreen extends StatefulWidget {
  List myLike;

  FavScreen({required this.myLike});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 1,
        title: const Text("Saved", style: TextStyle(color: Colors.white)),
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
      body: favorite.isEmpty
          ? const Center(
              child: Text(
              "No data found !",
              style: TextStyle(fontSize: 20),
            ))
          : ValueListenableBuilder(
              valueListenable: favorite.listenable(),
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: favorite.length,
                  itemBuilder: (context, index) {
                    var favdata = favorite.getAt((favorite.length - 1) - index);
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:  Color.fromRGBO(246, 245, 245, 1),
                      ),
                      //elevation: 5,
                      margin:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),

                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return FirstScreen(
                                ui: favdata!.input,
                                uo: favdata.output,
                              );
                            },
                          ));
                        },
                        title: Text(favdata!.input,
                            style: TextStyle(
                                fontSize: 17, fontFamily: 'boldFont')),
                        subtitle: Text(favdata.output,
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'semiBold')),
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
                'Delete Favourites',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              content: const Text('Are you sure?'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      favorite.clear();
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(bgColor)),
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
                        backgroundColor:
                            MaterialStateProperty.all<Color>(bgColor)),
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ));
  }
}
