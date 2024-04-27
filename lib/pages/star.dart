import 'package:dishu/pages/game.dart';
import 'package:flutter/material.dart';

class ViewApp extends StatelessWidget {
  const ViewApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (Scaffold(
        backgroundColor: Color.fromARGB(255, 17, 94, 165),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage("assets/user.png"),
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "打地鼠",
                style: TextStyle(
                    fontSize: 40, color: Color.fromARGB(255, 159, 111, 23)),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "鼠标点击突出颜色的地鼠",
                style: TextStyle(
                    fontSize: 40, color: Color.fromARGB(255, 1, 27, 3)),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        print("点击了开始");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Gaminger()));
                      },
                      child: Text("开始")),
                  const SizedBox(
                    width: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print("点击退出");
                      },
                      child: Text("退出")),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
