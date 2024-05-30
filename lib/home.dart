import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_firebase/data.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  int season = 1;
  int count = 0;
  String title = "Shopping app";
  Map<String, dynamic> style = {
    "useBorder": false,
    "borderWidth": 0.0,
    "borderRadius": 10.0,
  };

  Future<void> fetchData() async {
    remoteConfig.setDefaults({
      "season": 1,
      "count": 0,
      "title": "Shopping app",
      "style": json.encode({
        "useBorder": false,
        "borderWidth": 0.0,
        "borderRadius": 10.0,
      })
    });

    await activateData();
    remoteConfig.onConfigUpdated.listen((changes) async {
      await activateData();
    });
  }

  Future<void> activateData() async {
    await remoteConfig.fetchAndActivate();
    season = remoteConfig.getInt("season");
    count = remoteConfig.getInt("count");
    title = remoteConfig.getString("title");
    style = jsonDecode(remoteConfig.getString("style"));

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: appColor[season],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            color: appColor[season]!.withOpacity(0.5),
            child: Text(
              season == 1
                  ? "Bahor"
                  : season == 2
                  ? "Yoz"
                  : season == 3
                  ? "Kuz"
                  : "Qish",
              style: const TextStyle(
                fontSize: 30,
                color: Colors.grey,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          FoundData(
            count: count,
            color: appColor[season] ?? Colors.blue,
            useBorder: style["useBorder"] as bool,
            borderWidth: style["borderWidth"].toDouble(),
            borderRadius: style["borderRadius"].toDouble(),
          ),
        ],
      ),
    );
  }

  Map<int, Color> appColor = {
    1: Colors.green,
    2: Colors.amber,
    3: Colors.deepOrange,
    4: Colors.blue
  };
}
