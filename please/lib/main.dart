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
    return MaterialApp(
      title: 'Flutter AdMob Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness : Brightness.light,
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

var _default = 60 ;
var _timer1 = 1;
var _timer2 = 2;
var _timer3 = 3;

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
    _loadCounter();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _timer1 = (prefs.getInt('timer1') ?? 60);
      _timer2 = (prefs.getInt('timer2') ?? 90);
      _timer3 = (prefs.getInt('timer3') ?? 30);
    });
  }

  int _counter = _default;

  var _icon = Icons.play_arrow;
  var _color = Colors.amber;
  Timer _timer;
  var _isPlaying = false;


  void _incrementCounterPlus() {
    setState(() {
      _counter++;
    });
  }

  void _incrementCounterMinus() {
    setState(() {
      _counter--;
    });
  }

  void _default1() {
    setState(() {
      _default = _timer1;
      _reset();
    });
  }

  void _default2() {
    setState(() {
      _default = _timer2;
      _reset();
    });
  }

  void _default3() {
    setState(() {
      _default = _timer3;
      _reset();
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    var min = _counter ~/ 60; // 초
    var sec = '${_counter % 60}'.padLeft(2, '0');
    var timeString = '$min'+':'+'$sec';

    var _timer1min = '${_timer1 ~/ 60}'; // 초
    var _timer1sec = '${_timer1 % 60}'.padLeft(2, '0');
    var _timer1string = '$_timer1min'+':'+'$_timer1sec';

    var _timer2min = '${_timer2 ~/ 60}'; // 초
    var _timer2sec = '${_timer2 % 60}'.padLeft(2, '0');
    var _timer2string = '$_timer2min'+':'+'$_timer2sec';

    var _timer3min = '${_timer3 ~/ 60}'; // 초
    var _timer3sec = '${_timer3 % 60}'.padLeft(2, '0');
    var _timer3string = '$_timer3min'+':'+'$_timer3sec';

    final _shadow_1 = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.all(Radius.circular(50)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          offset: Offset(4.0, 4.0),
          blurRadius: 15.0,
          spreadRadius: 1.0),
        BoxShadow(
          color: Colors.white,
          offset: Offset(-4.0, -4.0),
          blurRadius: 15.0,
          spreadRadius: 1.0
        ),
      ]
    );

    final _shadow_2 = BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[500],
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0
          ),
        ]
    );

    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(title: Text(widget.title)),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(width : ((MediaQuery.of(context).size.width)*7/8)-15),
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    child: new IconButton(
                      icon : Icon(Icons.settings),
                      onPressed:() async{
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TimerSetting()),
                        );
                        print("Update State of FirstPage");
                        setState(() {
                        });
                      },
                    ),
                  ),
                ],
              ),
            new Container(
              width : (MediaQuery.of(context).size.width)*7/8,
              height: (MediaQuery.of(context).size.width)*7/8,
              margin: EdgeInsets.all(0.0),
              decoration: _shadow_1,
              child : Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : <Widget> [
                    SizedBox(
                        height: (MediaQuery.of(context).size.width)*1/8
                    ),
                    Container(
                      child : new Text(
                        '$timeString',
                        style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.width)*2/8,
                          color: Colors.black, fontWeight: FontWeight.w300,fontFamily: "Roboto"
                        ),
                      ),
                    ),
                    Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new IconButton(key:null, onPressed:_incrementCounterMinus,
                            color: Colors.black,
                            icon: Icon(Icons.remove_circle_outline),
                          ),
                          new IconButton(key:null, onPressed:_incrementCounterPlus,
                            color: Colors.black,
                            icon: Icon(Icons.add_circle_outline),
                          ),
                        ]
                    ),
                  ]
              ),
            ),
            SizedBox(height:20),
            Row (
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                      onPressed : _default1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                          alignment: Alignment.center,
                          width : (((MediaQuery.of(context).size.width)*7/8)-20)/3,
                          height : (((MediaQuery.of(context).size.width)*7/8)-20)/6,
                          decoration: _shadow_2,
                          padding: const EdgeInsets.all(10.0),
                          child : new Text(
                            "$_timer1string",
                            style: new TextStyle(fontSize:20.0,
                                // color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Roboto"),
                          )
                      )
                  ),
                  new SizedBox(width : 10),
                  new RaisedButton(
                      onPressed : _default2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                          alignment: Alignment.center,
                          width : (((MediaQuery.of(context).size.width)*7/8)-20)/3,
                          height : (((MediaQuery.of(context).size.width)*7/8)-20)/6,
                          decoration: _shadow_2,
                          padding: const EdgeInsets.all(10.0),
                          child : new Text(
                            "$_timer2string",
                            style: new TextStyle(fontSize:20.0,
                                // color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Roboto"),
                          )
                      )
                  ),
                  new SizedBox(
                    width: 10,
                  ),
                  new RaisedButton(
                      onPressed : _default3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                          alignment: Alignment.center,
                          width : (((MediaQuery.of(context).size.width)*7/8)-20)/3,
                          height : (((MediaQuery.of(context).size.width)*7/8)-20)/6,
                          decoration: _shadow_2,
                          padding: const EdgeInsets.all(10.0),
                          child : new Text(
                            "$_timer3string",
                            style: new TextStyle(fontSize:20.0,
                                // color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Roboto"),
                          )
                      )
                  ),
                ]
            ),
            new SizedBox(
              height: 15,
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new RaisedButton(
                      onPressed: () => setState(() {
                        _reset();
                      }),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                          alignment: Alignment.center,
                          width : (((MediaQuery.of(context).size.width)*7/8)-20)/2,
                          height : (((MediaQuery.of(context).size.width)*7/8)-20)/4,
                          decoration: _shadow_2,
                          padding: const EdgeInsets.all(10.0),
                          child : new Text(
                            '리셋',
                            style: new TextStyle(fontSize:20.0,
                                // color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Roboto"),
                          )
                      )
                  ),
                  new SizedBox(width : 20,),
                  new RaisedButton(
                      onPressed: () => setState(() {
                        _click();
                      }),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                          alignment: Alignment.center,
                          width : (((MediaQuery.of(context).size.width)*7/8)-20)/2,
                          height : (((MediaQuery.of(context).size.width)*7/8)-20)/4,
                          decoration: _shadow_2,
                          padding: const EdgeInsets.all(10.0),
                          child : new Text(
                            _text,
                            style: new TextStyle(fontSize:20.0,
                                // color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Roboto"),
                          )
                      )
                  ),
                ],
              ),
              new SizedBox(height:50)
              ]
            )
          ),
      ),
    );
  }

  var _text = '시작';

  void _click() {
    _isPlaying = !_isPlaying;

    if (_isPlaying) {
      _icon = Icons.pause;
      _color = Colors.grey;
      _text = '중지';
      _start();
      // controller.reverse(
      //     from: controller.value == 0.0
      //         ? 1.0
      //         : controller.value);
    } else {
      _icon = Icons.play_arrow;
      _color = Colors.amber;
      _text = '시작';
      _pause();
      // controller.stop();
    }
  }

  void _start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 1) {
          if (_counter == 6) {
            HapticFeedback.lightImpact();
            print('5 sec left');
          }
          _counter--;
        }
        else if (_counter == 1) {
          _reset();
          HapticFeedback.vibrate();
          FlutterRingtonePlayer.playNotification();
          print('0 sec left');
        }
      });
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  void _reset() {
    setState(() {
      if (_isPlaying == true ) {
        _click();
      }
      _counter = _default;
    });
  }
}

class TimerSetting extends StatefulWidget {
  @override
  _TimerSettingState createState() => _TimerSettingState();
}

class _TimerSettingState extends State<TimerSetting> {

  final myController1min = TextEditingController();
  final myController1sec = TextEditingController();
  final myController2min = TextEditingController();
  final myController2sec = TextEditingController();
  final myController3min = TextEditingController();
  final myController3sec = TextEditingController();

  @override
  void initState() {
    print("initState() of _SecondPage");
    super.initState();
  }

  @override
  void dispose() {
    print("dispose() of _SecondPage");
    //storeSettingValues();
    super.dispose();
  }

  void storeSettingValues() {
    print("store setting values");
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          storeSettingValues();
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              brightness: Brightness.light,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              centerTitle: true,
              backgroundColor: Colors.grey[200],
              title: Text("타이머 설정",style: new TextStyle(fontSize:20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Roboto"
              ),
            ),
            ),
            body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width : MediaQuery.of(context).size.width*7/8,
                      height : MediaQuery.of(context).size.width*7/8,
                      decoration : _shadow_1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                              children: [
                                Container(
                                    width : MediaQuery.of(context).size.width*2/3,
                                    child : Text(
                                      "1번 타이머",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          // fontSize: 15,
                                          color: Colors.black, fontWeight: FontWeight.w600,fontFamily: "Roboto"
                                      ),
                                    )
                                ),
                                Container(
                                    child : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children : <Widget>[
                                          Container(
                                            padding: const EdgeInsets.all(12.0),
                                            width : MediaQuery.of(context).size.width/3,
                                            child :
                                            new TextField(
                                              controller: myController1min,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-99]')),],
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  border: UnderlineInputBorder(),
                                                  hintText: '${_timer1~/60}'
                                              ),
                                            ),
                                          ),
                                          Container(
                                              child :
                                              Text("분")
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(12.0),
                                            width : MediaQuery.of(context).size.width/3,
                                            child : new TextField(
                                              controller: myController1sec,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-99]')),],
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  border: UnderlineInputBorder(),
                                                  hintText: '${_timer1%60}'
                                              ),
                                            ),
                                          ),
                                          Container(
                                              child :
                                              Text("초")
                                          ),
                                        ]
                                    )
                                ),
                                SizedBox(height:5),
                              ]
                          ),
                          Column(
                              children: [
                                Container(
                                    width : MediaQuery.of(context).size.width*2/3,
                                    child : Text(
                                      "2번 타이머",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        // fontSize: 15,
                                          color: Colors.black, fontWeight: FontWeight.w600,fontFamily: "Roboto"
                                      ),)
                                ),
                                Container(
                                    child : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children : <Widget>[
                                          Container(
                                            padding: const EdgeInsets.all(12.0),
                                            width : MediaQuery.of(context).size.width/3,
                                            child :
                                            new TextField(
                                              controller: myController2min,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-99]')),],
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  border: UnderlineInputBorder(),
                                                  hintText: '${_timer2~/60}'
                                              ),
                                            ),
                                          ),
                                          Container(
                                              child :
                                              Text("분")
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(12.0),
                                            width : MediaQuery.of(context).size.width/3,
                                            child : new TextField(
                                              controller: myController2sec,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-99]')),],
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  border: UnderlineInputBorder(),
                                                  hintText: '${_timer2%60}'
                                              ),
                                            ),
                                          ),
                                          Container(
                                              child :
                                              Text("초")
                                          ),
                                        ]
                                    )
                                ),
                                SizedBox(height:5),
                              ]
                          ),
                          Column(
                              children: [
                                Container(
                                    width : MediaQuery.of(context).size.width*2/3,
                                    child : Text(
                                      "3번 타이머",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        // fontSize: 15,
                                          color: Colors.black, fontWeight: FontWeight.w600,fontFamily: "Roboto"
                                      ),
                                    )
                                ),
                                Container(
                                    child : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children : <Widget>[
                                          Container(
                                            padding: const EdgeInsets.all(12.0),
                                            width : (MediaQuery.of(context).size.width)/3,
                                            child :
                                            new TextField(
                                              controller: myController3min,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-99]')),],
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  border: UnderlineInputBorder(),
                                                  hintText: '${_timer3~/60}'
                                              ),
                                            ),
                                          ),
                                          Container(
                                              child :
                                              Text("분")
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(12.0),
                                            width : MediaQuery.of(context).size.width/3,
                                            child : new TextField(
                                              controller: myController3sec,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-99]')),],
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                  border: UnderlineInputBorder(),
                                                  hintText: '${_timer3%60}'
                                              ),
                                            ),
                                          ),
                                          Container(
                                              child :
                                              Text("초")
                                          ),
                                        ]
                                    )
                                ),
                              ]
                          ),
                        ],
                      ),
                    ),
                    new SizedBox(height: 30,),
                    new RaisedButton(
                      // color: Colors.white,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10.0),
                      //     side: BorderSide(color: Colors.black12)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        _changeTimer();
                        showSnackbarWithKey();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width : (((MediaQuery.of(context).size.width)*7/8)-20)/3,
                          height : (((MediaQuery.of(context).size.width)*7/8)-20)/6,
                          padding: const EdgeInsets.all(10.0),
                          decoration : _shadow_2,
                          child: Text('저장')
                      ),
                    ),
                  ],

                )
            )
        ));
  }

  showSnackbarWithKey() {
    // 키를 통해 Scaffold에 접근하여 스낵바 출력
    scaffoldKey.currentState
        .showSnackBar(SnackBar(
          content: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 75),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("저장되었습니다."),
              )
          ),
      // backgroundColor: Colors.transparent,
      // elevation: 1000,
      behavior: SnackBarBehavior.floating,
    )
    );
  }

  final _shadow_1 = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.all(Radius.circular(50)),
      boxShadow: [
        BoxShadow(
            color: Colors.grey[500],
            offset: Offset(4.0, 4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0),
        BoxShadow(
            color: Colors.white,
            offset: Offset(-4.0, -4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0
        ),
      ]
  );

  final _shadow_2 = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.all(Radius.circular(30)),
      boxShadow: [
        BoxShadow(
            color: Colors.grey[500],
            offset: Offset(4.0, 4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0),
        BoxShadow(
            color: Colors.white,
            offset: Offset(-4.0, -4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0
        ),
      ]
  );

  _changeTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var _timerList = [ _timer1~/60, _timer1%60, _timer2~/60, _timer2%60,_timer3~/60, _timer3%60,  ] ;
      var controllerList = [myController1min,myController1sec,myController2min,myController2sec,myController3min,myController3sec];
      for (var controller in controllerList) {
        if (controller.text == ''){
          controller.text = _timerList[controllerList.indexOf(controller)].toString();
        }
      }
      _timer1 = int.parse(myController1min.text) * 60 +
          int.parse(myController1sec.text);
      prefs.setInt('timer1', _timer1);

      _timer2 = int.parse(myController2min.text) * 60 +
          int.parse(myController2sec.text);
      prefs.setInt('timer2', _timer2);

      _timer3 = int.parse(myController3min.text) * 60 +
          int.parse(myController3sec.text);
      prefs.setInt('timer3', _timer3);
    });
  }
}

class SnackbarManager {
  static void showSnackBar(
      GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}