// To parse this JSON data, do
//
//     final dataDictionary = dataDictionaryFromJson(jsonString);



class DataDictionary {
  int id;
  dynamic isUserAdded;
  String meaning;
  String word;

  DataDictionary({
    required this.id,
    this.isUserAdded,
    required this.meaning,
    required this.word,
  });

  factory DataDictionary.fromJson(Map<String, dynamic> json) => DataDictionary(
    id: json["Id"],
    isUserAdded: json["is_user_added"],
    meaning: json["meaning"],
    word: json["word"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "is_user_added": isUserAdded,
    "meaning": meaning,
    "word": word,
  };
}
