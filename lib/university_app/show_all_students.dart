import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/university_app/models/student_model.dart';
import 'package:learn_firebase/university_app/student_detail.dart';

import 'cfsservice.dart';

class ShowAllStudents extends StatefulWidget {
  const ShowAllStudents({super.key});

  @override
  State<ShowAllStudents> createState() => _ShowAllStudentsState();
}

class _ShowAllStudentsState extends State<ShowAllStudents> {
  List<QueryDocumentSnapshot> itemList = [];
  List<StudentModel> list = [];
  List<String> elementId = [];
  bool isLoading = true;

  Future<void> loadData() async {
    list = [];
    elementId = [];
    itemList = await CFSService.read(collectionPath: "users");
    for (var element in itemList) {
      elementId.add(element.id);
      list.add(StudentModel.fromJson(element.data() as Map<String, dynamic>));
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
      body: isLoading ? const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
          strokeCap: StrokeCap.round,
        ),
      ) : ListView.separated(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 20,
          left: 10,
          right: 10
        ),
        itemCount: list.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) => InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDetail(studentModel: list[index], elementId: elementId[index])));
          },
          child: Container(
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              list[index].name,
              style: const TextStyle(color: Colors.white, fontSize: 20)
            ),
          ),
        ),
      ),
    );
  }
}
