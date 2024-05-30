import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'confirmation.dart';
import 'dart:ui';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  Country country = CountryParser.parseCountryCode('UZ');
  final phoneNumber = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Telefon raqamingizni kiriting', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Text("Raqamingizni tasdiqlash uchun telefon raqamingizga tasdiqlash kodi yuborilidi.", textAlign: TextAlign.center),
          ),
          const SizedBox(height: 60),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 35),
                height: 50,
                width: double.infinity,
                child: TextField(
                  autofocus: true,
                  readOnly: true,
                  controller: TextEditingController(text: ' '),
                  decoration: const InputDecoration(
                      labelText: 'Country',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              InkWell(
                onTap: showPicker,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      Text('${country.flagEmoji} +${country.phoneCode} ${country.displayNameNoCountryCode}'),
                      const SizedBox(width: 20),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.grey),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 35),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Center(child: Text('+${country.phoneCode}', style: const TextStyle(fontSize: 16))),
                ),
                const SizedBox(width: 10),
                const Text('|', style: TextStyle(color: Colors.grey, fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: phoneNumber,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: country.example,
                        hintStyle: const TextStyle(color: Colors.grey)
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
      floatingActionButton: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: (){
          if(country.example.length == phoneNumber.length){
            myShowDialog();
          } else {
            snackBar('Raqam noto\'g\'ri');
          }
        },
        child: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue,
          child: !isLoading
            ? const Center(
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white
                )
              )
            : const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeCap: StrokeCap.round
                ),
            ),
        ),
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

  void showPicker(){
    showCountryPicker(
        context: context,
        favorite: ['UZ', 'US', 'RU'],
        countryListTheme: const CountryListThemeData(
            bottomSheetHeight: 600,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            inputDecoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.black),
                hintText: 'Search your country here...',
                border: InputBorder.none
            )
        ),
        onSelect: (country){
          setState(() {
            this.country = country;
          });
        }
    );
  }

  Future myShowDialog(){
    return showDialog(
      barrierColor: Colors.white.withOpacity(0.8),
      context: context,
      builder: (context) => Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Text('Raqam to\'g\'rimi?', style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 15)),
            content: SizedBox(
              height: 65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('+${country.phoneCode} ${phoneNumber.text}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Text('Edit', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                      ),
                      InkWell(
                        onTap: () async {
                          sendCode();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendCode() async {
    isLoading = true;
    setState((){});

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+${country.phoneCode}${phoneNumber.text}",
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        log(error.toString());
      },
      codeSent: (verificationId, forceResendingToken) {
        log("verificationId: $verificationId");
        if(!context.mounted) return;
        Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return Confirmation(
              verificationId: verificationId,
              phoneNumber: '+${country.phoneCode} ${phoneNumber.text}'
            );
          })
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {
        log(verificationId);
      },
    );

    isLoading = false;
    setState((){});
  }
}
