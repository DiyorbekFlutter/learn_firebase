import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'cfsservice.dart';
import 'firebase_service.dart';
import 'models/student_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot> itemList = [];
  List<StudentModel> list = [];
  List<String> elementId = [];
  int studentId = 0;
  bool isLoading = true;

  Future<void> loadData() async {
    list = [];
    elementId = [];
    itemList = await CFSService.read(collectionPath: "users");
    for (var element in itemList) {
      elementId.add(element.id);
      list.add(StudentModel.fromJson(element.data() as Map<String, dynamic>));
    }


    for(int i=0; i<list.length; i++){
      if(FirebaseAuth.instance.currentUser?.email == list[i].email){
        studentId = i;
      }
    }
    
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: isLoading ? const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
            strokeCap: StrokeCap.round,
          ),
        ) : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${list[studentId].name}"),
            Text("Age: ${list[studentId].age}"),
            Text("Email: ${list[studentId].email}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseService.logout(),
        child: const Icon(Icons.logout),
      ),
    );
  }
}
