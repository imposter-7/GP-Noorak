import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lastversion/screens/reusable_widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          
          decoration: BoxDecoration(
            color:  Colors.black87
            
          //     gradient: LinearGradient(colors: [
          //   hexStringToColor("CB2B93"),
          //   hexStringToColor("9546C4"),
          //   hexStringToColor("5E61F4")
          // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
          
          ),
          child: SingleChildScrollView(
              child: Padding(
                
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                Text(
                      errorMessage,
                      style: const TextStyle(
                          color: Color.fromARGB(221, 250, 9, 9), fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                firebaseUIButton(context, "Reset Password", () async {
                  try{
                       errorMessage = '';
                      await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value) => Navigator.of(context).pop());
                      
                  }
                    on FirebaseAuthException catch(error){
                            errorMessage = error.message!;
                            print(errorMessage);
                        }
                  
                }
                )
              ],
            ),
          ))),
    );
  }
}