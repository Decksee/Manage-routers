import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:desktop_window/desktop_window.dart';

import 'package:flutter/material.dart';

import 'package:generate/components/base.dart';
import 'package:generate/screens/Home.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:local_notifier/local_notifier.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DesktopWindow.setMinWindowSize(Size(1300,600));

  await DesktopWindow.setFullScreen(true);

  await localNotifier.setup(
    appName: 'Gestion des box internet',
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  LaunchAtStartup.instance.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );
  await launchAtStartup.enable();
  await launchAtStartup.disable();
  bool isEnabled = await launchAtStartup.isEnabled();


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

