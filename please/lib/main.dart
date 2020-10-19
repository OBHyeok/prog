import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'dart:math' as math;



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            title: 'Flutter AdMob Demo',
            theme: CupertinoThemeData(
              primaryColor: Colors.blue,
            ),
            home: MyHomePage(title: 'Flutter AdMob Demo'),
          )
        : MaterialApp(
            title: 'Flutter AdMob Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
          home: MyHomePage(title: 'Flutter AdMob Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutter', 'firebase', 'admob'],
    testDevices: <String>[],
  );

  BannerAd bannerAd = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(
        appId: Platform.isIOS
            ? 'ca-app-pub-8161556053827608~1491422364' // iOS Test App ID
            : 'ca-app-pub-8161556053827608~5769578724'); // Android Test App ID
    bannerAd..load()..show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(widget.title),
            ),
            child: Container(),
          )
        : Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: Container(),
        );
  }
}
