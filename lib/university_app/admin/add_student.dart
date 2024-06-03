// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../cfsservice.dart';
//
// class AddStudent extends StatefulWidget {
//   const AddStudent({super.key});
//
//   @override
//   State<AddStudent> createState() => _AddStudentState();
// }
//
// class _AddStudentState extends State<AddStudent> {
//   bool isLoading = false;
//   List<QueryDocumentSnapshot> itemList = [];
//   List<Post> postList = [];
//
//   // create
//   Future<void> create() async {
//     refresh(false);
//     Post post = Post(userId: "userId", firstname: "firstname", lastname: "lastname", date: "date", content: "content");
//     await CFSService.createCollection(collectionPath: "users", data: post.toJson());
//     await loadData();
//   }
//
//   // refresh
//   void refresh(bool value) {
//     isLoading = value;
//     setState(() {});
//   }
//
//   // load
//   Future<void> loadData() async {
//     postList = [];
//     refresh(false);
//     itemList = await CFSService.read(collectionPath: "users");
//     refresh(true);
//     for (var element in itemList) {
//       postList.add(Post.fromJson(element.data() as Map<String, dynamic>));
//     }
//   }
//
//   // remove
//   Future<void>remove(String id)async{
//     refresh(false);
//     await CFSService.delete(collectionPath: "users", id: id);
//     await loadData();
//   }
//
//   // update
//   Future<void>update(String id, Post post)async{
//     refresh(false);
//     await CFSService.update(collectionPath: "users", id: id, data: post.toJson());
//     await loadData();
//   }
//
//
//   @override
//   void didChangeDependencies() async{
//     await loadData();
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoading
//           ? Center(
//         child: ListView.builder(
//           itemCount: postList.length,
//           itemBuilder: (_, __) {
//             return Card(
//               child: ListTile(
//                 onTap: () async {
//                   log(itemList[__].id);
//                   Post post = Post(userId: "New", firstname: "New", lastname: "New", date:"New", content: "New");
//                   await update(itemList[__].id, post);
//                 },
//                 onLongPress: () async {
//                   await remove(itemList[__].id);
//                 },
//                 title: Text(postList[__].firstname),
//                 subtitle: Text(postList[__].content),
//                 trailing: Text(postList[__].date),
//                 leading: Text(postList[__].userId),
//               ),
//             );
//           },
//         ),
//       )
//           : const Center(
//         child: CircularProgressIndicator(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await create();
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:learn_firebase/university_app/models/student_model.dart';

import '../cfsservice.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController email = TextEditingController();

  Future<void> create(Map<String, dynamic> data) async {
    await CFSService.createCollection(collectionPath: "users", data: data);
    if(!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 150),
          TextField(
            controller: name,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration: textFromFieldDecoration("Name", "Enter student name"),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: age,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration: textFromFieldDecoration("Age", "Enter student age"),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            decoration: textFromFieldDecoration("Email", "Enter student email"),
          ),
          const SizedBox(height: 200),
          CommonButton(
            text: "Bajarish",
            onPressed: () async {
              StudentModel studentModel = StudentModel(
                name: name.text,
                age: int.parse(age.text),
                email: email.text,
              );
              create(studentModel.toJson);
            },
          )
        ],
      ),
    );
  }
}

InputDecoration textFromFieldDecoration(String labelText, String hintText){
  return InputDecoration(
    labelText: labelText.isNotEmpty ? labelText : null,
    labelStyle: const TextStyle(color: Colors.grey),
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: labelText.isEmpty ? 10 : 0),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5)
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1)
    ),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1.5, color: Color(0xffe81409))
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black, width: 1)
    ),
  );
}



class CommonButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const CommonButton({
    required this.text,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.blue,
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




class Post {
  String? postKey;
  late String userId;
  late String firstname;
  late String lastname;
  late String date;
  late String content;
  String? image;

  Post({
    this.postKey,
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.date,
    required this.content,
    this.image});

  Post.fromJson(Map<String, dynamic> json) {
    postKey = json['postKey'];
    userId = json['userId'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    date = json['date'];
    content = json['content'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() => {
    'postKey': postKey,
    'userId': userId,
    'firstname': firstname,
    'lastname': lastname,
    'date': date,
    'content': content,
    'image': image,
  };
}