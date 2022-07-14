// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lastversion/classes/language.dart';
import 'package:lastversion/provider/provider.dart';
import 'package:lastversion/register.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:neon/neon.dart';
import 'package:provider/provider.dart';
import 'package:lastversion/l10n/l10n.dart';

import 'mainsignin.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    void _changeLanguage(Language language) {
      print(language.languageCode);
    }

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
             )
        // Text(
        //   "NOORAK ",
        //   style: TextStyle
        //   (color:Colors.white,
        //   fontSize: 35,
        //   fontWeight: FontWeight.bold,
        //   shadows: const <Shadow>[
        //                   Shadow(
        //                   offset: Offset(5.0, 5.0),
        //                   blurRadius: 8.0,
        //                   color: Color.fromARGB(124, 3, 3, 3),
        //                 ),
        //               ],
        //   ),
        
        // ),
        ,centerTitle: true,
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
        height: MediaQuery.of(context).size.height,
         decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/0f3acc71f18597a61afe31e049795f73.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Color.fromARGB(47, 120, 120, 120), BlendMode.lighten))
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height*0.035, 22, 50),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.7
                )
                ,ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Signin()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(280, 45),
                    primary: Color.fromARGB(197, 174, 78, 132).withOpacity(0.75),
                    
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),),
                  side: BorderSide(width:1,color:Color.fromARGB(255, 80, 67, 77).withOpacity(0.7),
                                                  
                 ),
 
                ),
                        
                child: Text(AppLocalizations.of(context)!.signin,
                      style: TextStyle(
                        fontSize: 15,
                         letterSpacing: 0.5, 
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                         )),
                /*  */
              ),

              SizedBox(
                height: 10,
              )
                
                ,ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Register()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(280, 45),
                    primary: Color.fromARGB(255, 31, 28, 30).withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text(AppLocalizations.of(context)!.register,
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.5, 
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          )),
                /*  */
              ),
              ]
            )
            )

      ),
    );
  }
}
