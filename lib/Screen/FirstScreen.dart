import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:language_picker/languages.dart';
import 'package:share_plus/share_plus.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:tagalog_translate/Screen/DrawerUi.dart';
import 'package:tagalog_translate/model/history_hive.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ApiTranslate.dart';
import '../main.dart';
import 'package:hive_flutter/hive_flutter.dart';

Color bgColor = const Color.fromRGBO(206, 32, 41, 1);

//FOR LANGUAGE SELECTED .........
String sR = prefs.getString('rLang') ?? "en";
Language rLanguage = Language.fromIsoCode(sR);

String sL = prefs.getString('lLang') ?? "zu";
Language lLanguage = Language.fromIsoCode(sL);

bool swap_langauge = false;

//ANSWER FOR API CALLING STORE
var ans = "";

//SHAREDPREFRENCE FOR LIKE BUTTON.................

List<String> likeData = prefs.getStringList('Like') ?? [];
bool isLike = false;

class FirstScreen extends StatefulWidget {
  String? ui;
  String? uo;
  final bool back;

  FirstScreen({this.ui, this.uo, this.back = true});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  TextEditingController UserText = TextEditingController();
  TextToSpeech tts = TextToSpeech();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  FlutterTts flutterTts = FlutterTts();


  @override
  void initState() {
    _initSpeech();
    if (widget.ui != null) {
      UserText.text = widget.ui!;
    }
    if (widget.uo != null) {
      ans = widget.uo!;
    }
    flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [IosTextToSpeechAudioCategoryOptions.defaultToSpeaker],
    );

    // close=widget.ans_t;
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    setState(() {});
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      UserText.text = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {});
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(


          iconTheme: IconThemeData(color: Colors.white,size: widget.back?25:35),
          elevation: 0,
          backgroundColor: Color.fromRGBO(30, 65, 155, 1),
          // leading:widget.back?null:Icon(
          //   Icons.arrow_back_ios,
          //   color: Colors.white,
          // ),
          leading: widget.back
              ? null
              : Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: IconButton(
                        onPressed :  () {
                          print("TAP DRAWER");
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(Icons.menu)),
                  );
                }),
          actions: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Text(
                            "${rLanguage.name}",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'boldFont',
                              color: Colors.white,
                            ),
                          )),
                    ),
                    SwipButton(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "${lLanguage.name}",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'boldFont',
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 5),
                child: Text(
                  "${rLanguage.name}",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'boldFont',
                      color: Color.fromRGBO(95, 93, 93, 1)),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, top: 10, right: 10, left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(244, 244, 244, 1),
                  ),
                  padding: EdgeInsets.only(left: 12, right: 12, bottom: 10),
                  child: Column(
                    children: [
                      Flexible(
                        child: TextField(
                          onChanged: (value) {

                            setState(() {
                              UserText.text=value;
                              if(UserText.text.isEmpty)
                                {
                                  ans='';
                                }
                            });
                          },

                          controller: UserText,
                          style: TextStyle(fontSize: 18, fontFamily: 'semiBold'),
                          maxLines: 50000,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: swap_langauge
                                  ? "Faka umbhalo wakho"
                                  : "Enter Your Text"),
                        ),
                      ),
                      Row(
                        children: [
                          //COPY BUTTON
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                                onTap: () {
                                  if (UserText.text.isNotEmpty) {
                                    Clipboard.setData(
                                            ClipboardData(text: UserText.text))
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(CopySnackbar()));
                                  }

                                  print("Copy Text");
                                  setState(() {});
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: bgColor),
                                  child: UnconstrainedBox(
                                      child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                              "assets/svgImage/copy.svg"))),
                                )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  flutterTts.speak(UserText.text);
                                  // tts.setVolume(15);
                                  // tts.getVoice();
                                });
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: bgColor,
                                ),
                                child: UnconstrainedBox(
                                    child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: SvgPicture.asset(
                                          "assets/svgImage/volume.svg",
                                          color: Colors.white,
                                        ))),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          MicButton(),
                          //PASET BUTTON
                          // GestureDetector(
                          //     onTap: () {
                          //       Clipboard.getData(Clipboard.kTextPlain).then((value) {
                          //         UserText.text =
                          //             UserText.text + " " + value!.text.toString();
                          //       });
                          //       setState(() {});
                          //     },
                          //     child: Container(
                          //       height: 45,
                          //       width: 45,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.all(Radius.circular(10)),
                          //         color: bgColor,
                          //       ),
                          //       child: UnconstrainedBox(
                          //           child: SizedBox(
                          //               height: 20,
                          //               width: 20,
                          //               child: SvgPicture.asset(
                          //                   "assets/svgImage/past.svg"))),
                          //     )),
                          // TranslateButton(),

                          //VOLUME SPEAK....
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  UserText.clear();
                                   ans = "";
                                  flutterTts.stop();
                                });
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: bgColor,
                                ),
                                child: UnconstrainedBox(
                                    child: SizedBox(
                                        child: SvgPicture.asset(
                                            "assets/svgImage/close.svg"))),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
              TranslateButton(),
              SizedBox(
                height: 20,
              ),
              if(UserText.text.isNotEmpty&&ans.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "${lLanguage.name} Translate",
                  style: TextStyle(fontSize: 20, fontFamily: 'boldFont'),
                ),
              ),
              if(UserText.text.isNotEmpty&&ans.isNotEmpty)
              Divider(
                indent: 12,
                endIndent: 12,
                thickness: 0.5,
                color: Color.fromRGBO(228, 227, 227, 1),
              ),
              if(UserText.text.isNotEmpty&&ans.isNotEmpty)
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // mainAxisSize: MainAxisSize.max,
                      //physics: NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15,right: 15),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("${ans}",
                                style: TextStyle(
                                    fontFamily: 'semiBold', fontSize: 18)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 140),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Copy Button
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Share.share(ans);
                                    });
                                  },
                                  child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                        color: bgColor,
                                      ),
                                      child: UnconstrainedBox(
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                              "assets/svgImage/share.svg"),
                                        ),
                                      ))),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (ans != '') {
                                    Clipboard.setData(ClipboardData(text: ans))
                                        .then((value) =>
                                        CopySnackbar());
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    color: bgColor,
                                  ),
                                  child: UnconstrainedBox(
                                      child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                              "assets/svgImage/copy.svg"))),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      flutterTts.speak(ans);
                                    });
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      color: bgColor,
                                    ),
                                    child: UnconstrainedBox(
                                        child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: SvgPicture.asset(
                                                "assets/svgImage/volume.svg"))),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              LikeButton(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
        drawer: widget.back
            ? null
            : Drawer(
                child: DrawerUi(),
                backgroundColor: Colors.white,
              ),
        backgroundColor: Colors.white,
      ),
    );
  }

  SwipButton() {
    return GestureDetector(
      onTap: () {
        print("I Am Swap");
        swap_langauge = !swap_langauge;
        print(swap_langauge);

        if (swap_langauge) {
          setState(() {
            rLanguage = Language.fromIsoCode('zu');
            print("RightLanguage:${rLanguage.name}");
            lLanguage = Language.fromIsoCode('en');
            print("LeftLanguage:${lLanguage.name}");
          });

          // String rL=rLanguage.isoCode;

          prefs.setString('rLang', rLanguage.isoCode);
          prefs.setString('lLang', lLanguage.isoCode);

          setState(() {});
        } else {
          setState(() {
            lLanguage = Language.fromIsoCode('zu');
            print("Lest else Language:${lLanguage.name}");

            rLanguage = Language.fromIsoCode('en');
            print("Right else Language:${rLanguage.name}");
          });

          prefs.setString('lLang', lLanguage.isoCode);
          prefs.setString('rLang', rLanguage.isoCode);

          setState(() {});
        }

        String just = UserText.text;
        UserText.text = ans;
        ans = just;

        print("SAwap User Text transfer to Answer:::$ans");
      },
      child: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: bgColor,
          ),
          child: UnconstrainedBox(
            child: SizedBox(
              height: 35,
              width: 35,
              child: SvgPicture.asset("assets/svgImage/Swap.svg",
                  color: Colors.white),
            ),
          )),
    );
  }

  TranslateButton() {
    return GestureDetector(
        onTap: () async {
          if (UserText.text.isNotEmpty) _loadingDialog(context);
          ans = (await ApiCalling.createAlbum(UserText.text));
          history.add(History(UserText.text, ans));

          Navigator.pop(context);

          setState(() {});
        },
        child: Padding(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: Container(
              height: 60,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: bgColor,
              ),
              child: Center(
                  child: Text(
                "Translate",
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'boldFont'),
              ))),
        ));
  }

  MicButton() {
    return GestureDetector(
        onTap: () {
          print("Start");

          if (_speechToText.isListening) {
            print("Mic Start");
          } else {
            print("Mic is nmt start");
          }

          _speechToText.isNotListening ? _startListening() : _stopListening();
          print(_speechToText.isNotListening);
          print("I am Mick");
        },
        child: _speechToText.isNotListening
            ? Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: bgColor,
                ),
                child: UnconstrainedBox(
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          "assets/svgImage/mic.svg",
                          color: Colors.white,
                        ))))
            : Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: bgColor,
                ),
                child: UnconstrainedBox(
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          "assets/svgImage/mic.svg",
                          color:blueColor,
                        ))),
              ));
  }

  void _loadingDialog(context) {
    showDialog(
      context: context,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child:
                CircularProgressIndicator.adaptive(backgroundColor: blueColor),
          ),
        ),
      ),
    );
  }

  LikeButton() {
    return ValueListenableBuilder(
      valueListenable: favorite.listenable(),
      builder: (context, value, child) {
        return GestureDetector(
            onTap: () {
              // if (favorite.values.contains(History(UserText.text, ans))) {
              //   var index = favorite.values.toList().indexOf(History(UserText.text, ans));
              //   favorite.deleteAt(index);
              // }
              // else {
              //   if (UserText.text.isNotEmpty && ans.isNotEmpty) {
              //     favorite.add(History(UserText.text, ans));
              //   }
              // }
              //

              if (ans != "") {
                favorite
                    .add(History(UserText.text, ans))
                    .then((value) => SaveSnackbar());
              }
            },
            child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: bgColor,
                ),
                child: UnconstrainedBox(
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          "assets/svgImage/Like.svg",
                        )))));
      },
    );
  }

  CopySnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Copied."),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  SaveSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Saved."),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _shareTextOnWhatsApp(String text) async {
    final url = "whatsapp://send?text=${Uri.encodeComponent(text)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void shareTweet(String text) async {
    final String tweetUrl =
        'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(text)}';
    if (await canLaunch(tweetUrl)) {
      await launch(tweetUrl);
    } else {
      // Handle error: Could not launch the tweet.
      print('Error: Could not launch the tweet.');
    }
  }
}
