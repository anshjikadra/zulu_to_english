import 'package:hive/hive.dart';

part 'history_hive.g.dart';

@HiveType(typeId: 1)
class History {

  @HiveField(0)
  String input;

  @HiveField(1)
  String output;

  History(this.input, this.output);


  @override
  bool operator ==(covariant History other) {
    if (identical(this, other)) return true;
    return other.input == input && other.output == output;
  }
}



