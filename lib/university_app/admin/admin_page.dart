import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/university_app/admin/add_student.dart';
import 'package:learn_firebase/university_app/firebase_service.dart';

import '../show_all_students.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonButton(
            text: "Add student",
            onPressed: (){
              navigatorPush(const AddStudent());
            },
          ),
          CommonButton(
            text: "Remove student",
            color: Colors.grey,
            onPressed: (){},
          ),
          CommonButton(
            text: "Add teacher",
            color: Colors.grey,
            onPressed: (){},
          ),
          CommonButton(
            text: "Remove teacher",
            color: Colors.grey,
            onPressed: (){},
          ),
          CommonButton(
            text: "Show all students",
            onPressed: (){
              navigatorPush(const ShowAllStudents());
            },
          ),
          CommonButton(
            text: "Show all teachers",
            color: Colors.grey,
            onPressed: (){},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseService.logout(),
        child: const Icon(Icons.logout),
      ),
    );
  }

  void navigatorPush(Widget page){
    Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
  }
}



class CommonButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color? color;
  const CommonButton({
    required this.text,
    required this.onPressed,
    this.color,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        decoration: BoxDecoration(
          color: color ?? Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}

