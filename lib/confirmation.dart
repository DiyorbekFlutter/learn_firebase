import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_firebase/home.dart';
import 'package:pinput/pinput.dart';

class Confirmation extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const Confirmation({
    required this.phoneNumber,
    required this.verificationId,
    super.key,
  });

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Verification', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text('Telefon raqamingizga tasdiqlash kodini yubordik. Raqam: ${widget.phoneNumber}', textAlign: TextAlign.center),
          ),
          const SizedBox(height: 20),
          Center(
            child: Pinput(
              length: 5,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: controller,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: controller.text
                  );

                  await FirebaseAuth.instance.signInWithCredential(credential).then((value){
                    Navigator.pushAndRemoveUntil(context,
                      CupertinoPageRoute(builder: (context) => const Home()), (route) => false
                    );
                  });
                } catch(e){
                  snackBar("Xato: $e");
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Tasdiqlash', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              InkWell(
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 200)).then((value) => Navigator.of(context).pop());
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: const Text('Raqamni o\'zgartirish', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
              )
            ],
          )
        ],
      ),
    );
  }

  void snackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.horizontal,
        )
    );
  }
}
