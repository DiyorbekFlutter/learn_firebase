import 'package:flutter/material.dart';
import 'package:learn_firebase/university_app/cfsservice.dart';
import 'package:learn_firebase/university_app/models/student_model.dart';

import 'admin/add_student.dart';

class StudentDetail extends StatefulWidget {
  final StudentModel studentModel;
  final String elementId;
  const StudentDetail({required this.studentModel, required this.elementId, super.key});

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${widget.studentModel.name}"),
            Text("Age: ${widget.studentModel.age}"),
            Text("Email: ${widget.studentModel.email}"),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          CommonButton(
                            text: "Bajarish",
                            onPressed: () async {
                              await CFSService.update(
                                collectionPath: "users",
                                id: widget.elementId,
                                data: StudentModel(
                                  name: name.text,
                                  age: int.parse(age.text),
                                  email: email.text
                                ).toJson
                              );

                              if(!context.mounted) return;
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Text("Ediit", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: InkWell(
                onTap: (){
                  CFSService.delete(collectionPath: "users", id: widget.elementId).then((value){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Text("Delete", style: TextStyle(color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
