import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:tagalog_translate/Screen/DictionaryPage.dart';
import 'package:tagalog_translate/Screen/FavScreen.dart';
import 'package:tagalog_translate/Screen/FirstScreen.dart';
import 'package:tagalog_translate/Screen/HistoryPage.dart';
import '../main.dart';

Color blueColor = Color.fromRGBO(30, 65, 155, 1);

class DrawerUi extends StatefulWidget {
  const DrawerUi({Key? key}) : super(key: key);

  @override
  State<DrawerUi> createState() => _DrawerUiState();
}

class _DrawerUiState extends State<DrawerUi> {

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 2,
    googlePlayIdentifier: 'gujarati.kids.learning',
    appStoreIdentifier: '1661741363',
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                color: blueColor,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 70, left: 15),
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/Logo.png"),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(13)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 95, left: 10),
                        child: Text("Zulu Translator",
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'boldFont')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Simple, Easy & Effective",
                            style: TextStyle(
                                fontFamily: 'semiBold',
                                color: Color.fromRGBO(169, 169, 169, 1))),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) {
              //     return HistoryPage();
              //   },
              // ));
              setState(() {});
            },
            leading: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(240, 239, 239, 1),
              ),
              child: UnconstrainedBox(
                  child: SizedBox(
                      width: 25,
                      height: 25,
                      child:
                          SvgPicture.asset("assets/svgImage/translate.svg"))),
            ),
            title: const Text("Translator",
                style: TextStyle(
                    color: Colors.black, fontSize: 18, fontFamily: 'boldFont')),
          ),
          SizedBox(
            height: 8,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DictionaryPage();
                },
              ));
            },
            leading: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(240, 239, 239, 1),
              ),
              child: UnconstrainedBox(
                  child: SizedBox(
                      width: 17,
                      height: 20,
                      child:
                          SvgPicture.asset("assets/svgImage/Dictionary.svg"))),
            ),
            title: const Text("Dictionary",
                style: TextStyle(
                    color: Colors.black, fontSize: 18, fontFamily: 'boldFont')),
          ),
          SizedBox(
            height: 8,
          ),
          ListTile(
            onTap: () {},
            leading: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(240, 239, 239, 1),
              ),
              child: UnconstrainedBox(
                  child: SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset("assets/svgImage/pharse.svg"))),
            ),
            title: Text("Phrases",
                style: const TextStyle(
                    color: Colors.black, fontSize: 18, fontFamily: 'boldFont')),
          ),
          SizedBox(
            height: 8,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return FavScreen(
                    myLike: likeData,
                  );
                },
              ));
            },
            leading: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(240, 239, 239, 1),
              ),
              child: UnconstrainedBox(
                  child: SizedBox(
                      width: 19,
                      height: 19,
                      child: SvgPicture.asset(
                        "assets/svgImage/Like.svg",
                        color: Color.fromRGBO(206, 32, 41, 1),
                      ))),
            ),
            title: const Text("Bookmarks",
                style: TextStyle(
                    color: Colors.black, fontSize: 18, fontFamily: 'boldFont')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Support Us",
                  style: TextStyle(
                      fontSize: 17,
                      color: Color.fromRGBO(30, 30, 30, 1),
                      fontFamily: 'semiBolc'),
                )),
          ),
          ListTile(
            onTap: () {},
            leading: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(240, 239, 239, 1),
              ),
              child: UnconstrainedBox(
                  child: SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.asset(
                        "assets/svgImage/ShareD.svg",
                        color: Color.fromRGBO(206, 32, 41, 1),
                      ))),
            ),
            title: const Text("Share this app",
                style: TextStyle(
                    color: Colors.black, fontSize: 18, fontFamily: 'boldFont')),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              RatingButton();
              setState(() {});
            },
            leading: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(240, 239, 239, 1),
              ),
              child: UnconstrainedBox(
                  child: SizedBox(
                      width: 21,
                      height: 19,
                      child: SvgPicture.asset(
                        "assets/svgImage/star.svg",
                        color: Color.fromRGBO(206, 32, 41, 1),
                      ))),
            ),
            title: const Text("Rate this app",
                style: TextStyle(
                    color: Colors.black, fontSize: 18, fontFamily: 'boldFont')),
          ),
        ],
      ),
    );
  }

  RatingButton() {
    rateMyApp.showStarRateDialog(
      context,
      title: 'Rate this app',
      // The dialog title.
      message:
          "You like this app ? Then take a little bit of your time to leave a rating :",
      actionsBuilder: (context, stars) {
        return [
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(fontFamily: "Myfontlight", color: Colors.black),
            ),
            onPressed: () async {
              print('Thanks for the ' +
                  (stars == null ? '0' : stars.round().toString()) +
                  ' star(s) !');

              await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
              Navigator.pop<RateMyAppDialogButton>(
                  context, RateMyAppDialogButton.rate);
            },
          ),
        ];
      },
      ignoreNativeDialog: Platform.isAndroid,
      dialogStyle: const DialogStyle(
        titleAlign: TextAlign.center,
        messageAlign: TextAlign.center,
        messagePadding: EdgeInsets.only(bottom: 20),
      ),
      starRatingOptions: const StarRatingOptions(),
      onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
          .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
    );
  }
}
