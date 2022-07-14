// ignore_for_file: prefer_const_constructors, sort_child_properties_last, deprecated_member_use


import 'package:flutter/material.dart';
import 'package:lastversion/signinemail.dart';
import 'package:lastversion/l10n/l10n.dart';
import 'package:lastversion/provider/provider.dart';
import 'package:lastversion/signinemail.dart';
import 'package:neon/neon.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import 'classes/language.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Signin();
}
void _changeLanguage(Language language) {
      print(language.languageCode);
    }

class _Signin extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
       extendBodyBehindAppBar: true,
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
                   fontSize: 30,
                   glowingDuration: new Duration(seconds: 3),
             ),
        // Text("NOORAK ",
        // style: TextStyle(color:Colors.white,
        // fontSize: 35,
        // fontWeight: FontWeight.bold,
        // shadows: const <Shadow>[
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
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/0f3acc71f18597a61afe31e049795f73.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Color.fromARGB(48, 255, 243, 243), BlendMode.lighten)),
        ),
        child: Stack(
          children: [
            Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
              
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.29,
                  width: MediaQuery.of(context).size.height
                  // width: MediaQuery.of(context).size.width-100,
                ),
                Padding(padding: EdgeInsets.only(right:135),
                child: Text(
                        AppLocalizations.of(context)!.control,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 35,
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
                ),
                 Padding(padding: EdgeInsets.only(right:170),
                child: Text(
                           AppLocalizations.of(context)!.anywhere,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
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
                ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.28,
            
            ),
                Padding(
                    padding: EdgeInsets.only( left:1),
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Signinmail())); 
                      },
                       child: Text(AppLocalizations.of(context)!.signemail,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                
                          primary: Color.fromARGB(255, 46, 28, 66).withOpacity(0.9),
                          padding: EdgeInsets.symmetric(horizontal: 115,vertical: 15),
                          shape: RoundedRectangleBorder(
                            
                              borderRadius: BorderRadius.circular(20),
                            
                              
                              
                              ),
                              side: BorderSide(width:1,color:Color.fromARGB(255, 89, 58, 133).withOpacity(0),
                              )
                              
                              ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only( left:35),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                          AppLocalizations.of(context)!.google,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                        
                          primary: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 12),
                          shape: RoundedRectangleBorder(
                            
                              borderRadius: BorderRadius.circular(20)
                              
                              
                              ),
                              
                              
                              ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( left:40),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(AppLocalizations.of(context)!.appleid,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                        
                          primary: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 12),
                          shape: RoundedRectangleBorder(
                            
                              borderRadius: BorderRadius.circular(20)
                              
                              
                              ),
                              
                              
                              ),
                    ),
                  ),

             
              ],
            ),
            SizedBox(height: 20,),
            Text(AppLocalizations.of(context)!.by,
            style: TextStyle(color: Color.fromARGB(255, 255, 250, 250),fontSize: 14,fontWeight: FontWeight.normal),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
