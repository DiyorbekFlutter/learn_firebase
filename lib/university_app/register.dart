import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_firebase/university_app/admin/admin_page.dart';
import 'package:learn_firebase/university_app/data.dart';
import 'package:learn_firebase/university_app/firebase_service.dart';
import 'package:learn_firebase/university_app/home_page.dart';
import 'package:learn_firebase/university_app/teacher_page.dart';

import 'loading.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Future<void> pushAndRemoveUntil(Widget page) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false
    );
  }
  Future<void> errorText() async => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nima xato ketdi')));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () async {
              loading(context);
              Roles? result = await FirebaseService.handleSignInWithGoogle(context);
              if(context.mounted) Navigator.pop(context);
              result != null
                  ? pushAndRemoveUntil(page(result))
                  : errorText();
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                side: const BorderSide(color: Colors.black, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/google.svg', width: 28, height: 28),
                const SizedBox(width: 10),
                const Text('Google', style: TextStyle(fontSize: 20, color: Colors.black))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget page(Roles role) {
    switch(role){
      case Roles.admin:
        return const AdminPage();
      case Roles.teacher:
        return const Teacher();
      case Roles.student:
        return const HomePage();
    }
  }
}
