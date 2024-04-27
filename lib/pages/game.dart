import 'dart:async';

import 'dart:math';

import 'package:dishu/pages/star.dart';
import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

class Gaminger extends StatelessWidget {
  const Gaminger({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "gaming",
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Gaming(),
    );
  }
}

class Gaming extends StatefulWidget {
  @override
  _Gaming createState() => _Gaming();
}

class _Gaming extends State<Gaming> {
  final Random _random = Random();
  final player = AudioPlayer();

  int _moles = -1;
  int _score = 0;
  int _gametime = 30;
  Timer? _jishiqi;

  @override
  void initState() {
    super.initState();
    _startagme();
  }

  @override
  void dispose() {
    _jishiqi?.cancel();
    super.dispose();
  }

  void _startagme() {
    //开始游戏 执行的函数
    _gametime = 30;
    _jishiqi = Timer.periodic(Duration(seconds: 1), (timer) {
      _gametime--;

      if (_gametime <= 0) {
        _endgame();
      } else {
        _nextmole();
        print("生成袋鼠");
      }
    });
  }

  void _endgame() {
    //游戏结束时 执行的函数
    _jishiqi?.cancel();
    showAboutDialog(context: context);
    Builder:
    (Builder(BuildContext context)) {
      return AlertDialog(
        title: Text("游戏结束"),
        content: Text("时间到,游戏结束"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _score = 0;
                  _startagme();
                });
              },
              child: Text("重开")),
        ],
      );
    };
  }

  void _nextmole() {
    //此函数用于随机生成袋鼠

    setState(() {
      _moles = _random.nextInt(9);
    });
  }

  void _onMole(int index) {
    //用于处理点击袋鼠
    if (index == _moles) {
      setState(() {
        player.resume();

        player.setSource(AssetSource('pop.mp3'));
        _score++;
        print("现在分数 $_score");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("打地鼠"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ViewApp()));
          },
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("倒计时  $_gametime",
                style: const TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 23, 121, 9))),
            Text("得分" + _score.toString(),
                style: const TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 23, 121, 9))),
            SizedBox(height: 20),
            Container(
              width: 240,
              height: 240,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => _onMole(index),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == _moles ? Colors.brown : Colors.green,
                      ),
                      child: Center(
                        child: index == _moles ? Icon(Icons.cloud) : null,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
