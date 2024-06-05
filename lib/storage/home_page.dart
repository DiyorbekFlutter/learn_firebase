import 'package:flutter/material.dart';
import 'package:learn_firebase/storage/audio.dart';
import 'package:learn_firebase/storage/pdf.dart';
import 'package:learn_firebase/storage/picture.dart';
import 'package:learn_firebase/storage/video.dart';

import 'other.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Storage', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Picture"),
              Tab(text: "Video"),
              Tab(text: "Audio"),
              Tab(text: "PDF"),
              Tab(text: "Other"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Picture(),
            Video(),
            Audio(),
            Pdf(),
            Other(),
          ],
        ),
      ),
    );
  }
}
