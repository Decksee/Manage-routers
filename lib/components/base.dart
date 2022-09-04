import 'package:hive/hive.dart';

part 'base.g.dart';

@HiveType(typeId: 0)
class base extends HiveObject{
  @HiveField(0)
  late String Direction;

  @HiveField(1)
  late String Fournisseur;

  @HiveField(2)
  late int NumberSim;

  @HiveField(3)
  late String CodeBox;

  @HiveField(4)
  late DateTime DateA;

  @HiveField(5)
  late DateTime DateFA;

  @HiveField(6)
  late DateTime DateNO;
 }