import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/firebase_options.dart';
import 'package:learn_firebase/university_app/admin/admin_page.dart';
import 'package:learn_firebase/university_app/data.dart';
import 'package:learn_firebase/university_app/home_page.dart';
import 'package:learn_firebase/university_app/register.dart';
import 'package:learn_firebase/university_app/teacher_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthChecker(),
    );
  }
}


class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return page(snapshot.data?.displayName ?? "student");
        } else {
          return const Register();
        }
      },
    );
  }

  Widget page(String role) {
    switch(role){
      case "admin":
        return const AdminPage();
      case "teacher":
        return const Teacher();
      case "student":
        return const HomePage();
      default:
        return const HomePage();
    }
  }
}
