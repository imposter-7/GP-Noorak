// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lastversion/Home.dart';
import 'package:lastversion/classes/language.dart';
import 'package:lastversion/register.dart';
import 'package:lastversion/screens/reset_password.dart';
import 'package:lastversion/screens/reusable_widgets.dart';
import 'package:neon/neon.dart';
import 'l10n/l10n.dart';
import 'provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:provider/provider.dart';

import 'Firsthome.dart';

class Signinmail extends StatefulWidget {
  const Signinmail({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Signinmail();
}

class _Signinmail extends State<Signinmail> {
  bool _isobsecure = true;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final formKey= GlobalKey<FormState>();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:true,
      appBar: AppBar(
        
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
         Neon(
                   text:"NOORAK",
                   color: Colors.pink,
                   font: NeonFont.Monoton,
                  // font: NeonFont.TextMeOne,
                 
                   flickeringText: true,
                   flickeringLetters: null,
                   fontSize: 35,
                   glowingDuration: new Duration(seconds: 3),
             ),
        // Text("NOORAK ",
        // style: TextStyle(color:Colors.white,
        // fontSize: 35,
        // fontWeight: FontWeight.bold,
        // shadows: <Shadow>[
        //                   Shadow(
        //                   offset: Offset(5.0, 5.0),
        //                   blurRadius: 8.0,
        //                   color: Color.fromARGB(124, 3, 3, 3),
        //                 ),
        //               ],
        // ),
        
        // ),
        centerTitle: true,
          actions: <Widget>[

            Padding(
              padding: EdgeInsets.all(8.0),
              child: DropdownButton<Locale>(
                underline: SizedBox(),
                icon: Icon(
                  Icons.language_rounded,
                  color: Colors.white,
                ),
                items: List.generate(
                    L10n.all.length,
                    (index) => DropdownMenuItem<Locale>(
                          value: L10n.all[index],
                          child: Text(L10n.all[index].languageCode),
                        )),
                onChanged: (value) {
                  final provider =
                      Provider.of<LocalProvider>(context, listen: false);
                  provider.setLocale(value);
                },
              ),
            ),
        ],
      ),
      body: Container( 
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*1.0,
        
         decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/0f3acc71f18597a61afe31e049795f73.jpg"),
              fit: BoxFit.cover,
             colorFilter: ColorFilter.mode(Color.fromARGB(48, 255, 243, 243), BlendMode.lighten)),
        ),
      child:Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          reverse: true,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height*0.035, 20,40),
            child: Column(
              children: <Widget>[
               
                    Text(
                        AppLocalizations.of(context)!.welcome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 8.0,
                          color: Color.fromARGB(124, 3, 3, 3),
                        ),
                      ],
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.signincontrol,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(
                  height: 150,
                ),


                //-----------Email Controller---------------

                // reusableTextField("Email", Icons.person_outline, false,
                //     _emailTextController),

                 TextFormField(
                  controller: _emailTextController,
                  validator:(value){
                        if(value!.isEmpty){
                            return AppLocalizations.of(context)!.erequir;
                          
                          }
                        else if(!RegExp(r'^[a-z0-9]+@[a-z]+\.[a-z]{2,4}$').hasMatch(value)){
                            return AppLocalizations.of(context)!.entercorrect;
                        }
                        else{
                          return null;
                        }
                      },
                  obscureText: false,
                  enableSuggestions: true,
                  autocorrect: true,
                  cursorColor: Color.fromARGB(255, 249, 247, 247),
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Color.fromARGB(179, 255, 255, 255),
                    ),
                    
                          labelText: AppLocalizations.of(context)!.email,
                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.black.withOpacity(0.7),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                  ),
                  keyboardType: false
                      ? TextInputType.visiblePassword
                      : TextInputType.emailAddress,
                ),

                //------------------------------------------
                const SizedBox(
                  height: 20,
                ),

                //-----------Password Controller---------------

                // reusableTextField("Password..", Icons.lock_outline, true,
                //     _passwordTextController),

              TextFormField(
                  controller: _passwordTextController,

                  validator:(value){
                        if(value!.isEmpty ){
                          errorMessage=' ';
                            return AppLocalizations.of(context)!.passrequir;
                        }
                        else if (RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$').hasMatch(value)){
                            return AppLocalizations.of(context)!.invalidpass;
                        }
                        else{
                          return null;
                        }
                      },
                  
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  cursorColor: Color.fromARGB(255, 249, 247, 247),
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.9)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color.fromARGB(179, 255, 255, 255),
                    ),
                    
                    labelText: AppLocalizations.of(context)!.pass,
                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.black.withOpacity(0.7),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                  ),
                  keyboardType: true
                      ? TextInputType.visiblePassword
                      : TextInputType.emailAddress,
                ),
                Text(
                      errorMessage,
                      style: const TextStyle(
                          color: Color.fromARGB(221, 250, 9, 9), fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                //----------------------------------------------
                // const SizedBox(
                //   // height: 5,
                // ),

                forgetPassword(context),

                //----------------Sign in Button----------------

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: ElevatedButton(
                    onPressed: () async {
                      // if the validation is correct, the user can be signed in 
                      if(formKey.currentState!.validate()){
                        try{
                          formKey.currentState?.save();
                          errorMessage='';
                          await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                                    email: _emailTextController.text.trim(),
                                    password: _passwordTextController.text.trim())
                                .then((value) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => FirstHome()));
                            });
                            
                        }
                        
                        on FirebaseAuthException catch(error){
                            errorMessage = error.message!;
                        }

                      }
                    },
                    child: Text(
                            AppLocalizations.of(context)!.signin,
                      style: const TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.black26;
                          }
                          return Colors.white;
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                  ),
                ),

               
                signUpOption()
              ],
            ),
          ),
        ),
      )
      
      )
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context)!.donthave,
            style: TextStyle(color: Color.fromARGB(216, 236, 222, 222))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            AppLocalizations.of(context)!.register,
            style: TextStyle(color: Color.fromARGB(255, 235, 228, 228), fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          AppLocalizations.of(context)!.forget,
          style: TextStyle(color: Color.fromARGB(255, 255, 254, 254)),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }

}
