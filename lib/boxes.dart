import 'package:generate/components/base.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<base> getTransactions() =>
      Hive.box<base>('Base');
}
