import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tagalog_translate/Screen/FirstScreen.dart';
import '../api_model/api_model.dart';


 Translate? answer;
//
// class ApiCalling {
//   static Future<String> createAlbum(String text) async {
//     print(rLanguage.name);
//     print(lLanguage.name);
//     final response = await http.get(
//       Uri.parse(
//           'https://translate.googleapis.com/translate_a/single?client=gtx&dt=t&dt=bd&dj=1&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=at&sl=${rLanguage.isoCode}&tl=${lLanguage.isoCode}&q=${text.replaceAll('.','')}'),
//     );
//     if (response.statusCode == 200) {
//       answer = Translate.fromJson(jsonDecode(response.body)['sentences'][0]);
//       return answer!.trans.toString();
//     } else {
//       throw Exception('Failed.......');
//     }
//   }
// }


class ApiCalling {
  static Future<String> createAlbum(String text) async {
    final List<String> sentences = text.split(RegExp(r'(?<=[.!?])\s+'));
    final List<String> translatedSentences = [];

    for (String sentence in sentences) {
      final response = await http.get(
        Uri.parse(
          'https://translate.googleapis.com/translate_a/single?client=gtx&dt=t&dt=bd&dj=1&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=at&sl=${rLanguage.isoCode}&tl=${lLanguage.isoCode}&q=${sentence.replaceAll('.', '')}',
        ),
      );

      print(response.body);
      if (response.statusCode == 200) {
        final answer = Translate.fromJson(jsonDecode(response.body)['sentences'][0]);
        translatedSentences.add(answer.trans);
      } else {
        throw Exception('Failed.......');
      }
    }

    return translatedSentences.join(' ');
  }



}