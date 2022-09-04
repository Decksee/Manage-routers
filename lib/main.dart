import 'package:flutter/material.dart';
import 'package:generate/components/base.dart';
import 'package:generate/screens/Home.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(baseAdapter());
  await Hive.openBox<base>('Base');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF9F9FB)),
      home: Home(),
    );
  }
}

