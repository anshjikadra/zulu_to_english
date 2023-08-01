import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tagalog_translate/Screen/FirstScreen.dart';

import 'model/history_hive.dart';

late Box<History> history;
late Box<History> favorite;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs=await SharedPreferences.getInstance();



  //USING HIVE....HISTORY...
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter());
  history = await Hive.openBox<History>("history");
  favorite = await Hive.openBox<History>("favorite");


  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirstScreen(back: false),
  ));
}
late SharedPreferences prefs;
