import 'package:hive/hive.dart';

part 'graphvalue.g.dart';

@HiveType(typeId: 0)
class Graphvalue {
  @HiveField(0)
  final int game;
  @HiveField(1)
  final int wrong;
  @HiveField(2)
  final int correct;

  Graphvalue(this.game, this.wrong, this.correct);
}
