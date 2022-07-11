// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lastversion/classes/language.dart';
import 'package:lastversion/provider/provider.dart';
import 'package:lastversion/register.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
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
        title:Text(
          "NOORAK ",
          style: TextStyle
          (color:Colors.white,
          fontSize: 35,
          fontWeight: FontWeight.bold,
          shadows: const <Shadow>[
                          Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 8.0,
                          color: Color.fromARGB(124, 3, 3, 3),
                        ),
                      ],
          ),
        
        ),
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
        height: MediaQuery.of(context).size.height,
         decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/0f3acc71f18597a61afe31e049795f73.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Color.fromARGB(0, 167, 152, 152), BlendMode.lighten)),
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height*0.035, 22, 50),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 485,
                )
                ,ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Signin()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(280, 45),
                    primary: Color.fromARGB(255, 152, 22, 105).withOpacity(0.75),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),),
                  side: BorderSide(width:1,color:Color.fromARGB(255, 37, 28, 35).withOpacity(0.7),
                                                  
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


        // child: Stack(
        //   children: [
          // Column(
          //     // ignore: prefer_const_literals_to_create_immutables
          //     children: [
          //       SizedBox(
          //           height:108,
          //           child: const Center(
          //             // child: Text(
          //             //   'NOORAK ',
          //             //   style: TextStyle(
          //             //     color: Colors.white,
          //             //     fontSize: 35,
          //             //     fontWeight: FontWeight.bold,
          //             //   ),
          //             // ),
          //           )),
          //     ],
          //   ), 
          //   Column(

          //     // padding: EdgeInsets.only(left: 10, top: 520),
          //     children: [
          //       Center (
                
          //         child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.of(context).push(
          //             MaterialPageRoute(builder: (context) => Register()));
          //       },
          //       style: ElevatedButton.styleFrom(
          //           minimumSize: Size(250, 40),
          //           primary: Color.fromRGBO(173, 71, 131, 1),
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(20))),
          //       child: Text(" Register",
          //           style: TextStyle(
          //               fontSize: 15, letterSpacing: 2, color: Colors.white)),
          //       /*  */
          //     )
          //     ,),
          //     ]
          //   ),
          //   Padding(
          //     padding: EdgeInsets.all(55),
          //     child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.of(context)
          //             .push(MaterialPageRoute(builder: (context) => Signin()));
          //       },
          //       style: ElevatedButton.styleFrom(
          //           minimumSize: Size(250, 40),
          //           primary: Color.fromARGB(255, 9, 4, 19),
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(20),),
          //         side: BorderSide(width:1,color:Color.fromARGB(255, 185, 45, 155).withOpacity(1),
                                                  
          //        ),
 
          //       ),
                        
          //       child: Text(" Sign in",
          //           style: TextStyle(
          //               fontSize: 15, letterSpacing: 2, color: Colors.white)),
          //       /*  */
          //     ),
          //   ),
          // ],
        // ),
      ),
    );
  }
}
