// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:lastversion/bottomnavbar.dart';
// import 'package:lastversion/profile.dart';
import 'package:lastversion/smart_pages/poweroff.dart';
import 'package:lastversion/smart_pages/poweron.dart';
import 'package:lastversion/smart_pages/schedulenotification.dart';
import 'package:lastversion/smart_pages/sunrise.dart';
import 'package:lastversion/smart_pages/sunset.dart';

import 'package:lastversion/provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:neon/neon.dart';
import 'package:provider/provider.dart';
import 'package:lastversion/l10n/l10n.dart';

class SmartPage extends StatefulWidget {
  const SmartPage({key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SmartPageState();
}

class _SmartPageState extends State<SmartPage> {

  Color shadowColor = Color.fromARGB(255, 19, 23, 51);
  bool isPressed = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 50,
          title: 
          Text(
            AppLocalizations.of(context)!.smart,
            style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.red,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color: Colors.red,
                              blurRadius: 6,
                            ),
                            Shadow(
                             color: Colors.red,
                              blurRadius: 9,
                            ),
                          ]
                          ),
            )
         
          
          ,
          centerTitle: true,
          backgroundColor: Colors.black,
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
        body: SingleChildScrollView(
          
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              // width: double.infinity,
              width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  //  child: 
                  //   //  Neon(
                  //   //   text:AppLocalizations.of(context)!.auto,
                  //   //   color: Colors.blue,
                  //   //   font: NeonFont.Beon,
                  //   //   flickeringText: true,
                  //   //   flickeringLetters: null,
                  //   //   fontSize: 20,
                  //   // )
                  //   Text(
                  //     AppLocalizations.of(context)!.auto,
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Container(
                        width: double.infinity,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFF9C27B0),
                          boxShadow: [
                            // isPressed?
                            BoxShadow(
                              color: Color.fromARGB(255, 152, 92, 174).withAlpha(255),
                               blurRadius: 10,
                               spreadRadius: 1,
                               offset: Offset(0,0)                               
                               )
                              //  :
                              //  BoxShadow()
                          ],
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(162, 243, 168, 247),
                            Color.fromARGB(255, 99, 4, 116),
                            
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft
                          
                          )
                          
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        isPressed = !isPressed;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Poweron()),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 55),
                    child: Text(
                      AppLocalizations.of(context)!.spoweron,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: shadowColor,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color: shadowColor,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: shadowColor,
                              blurRadius: 9,
                            ),
                          ]
                          ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 320, vertical: 55),
                    child: Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  //Box number two :
                  //
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 170),
                      child: Container(
                        width: 400,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(232, 105, 184, 240),
                          boxShadow: [
                            // isPressed?
                            BoxShadow(
                              color: Color.fromARGB(232, 92, 149, 189).withAlpha(255),
                               blurRadius: 10,
                               spreadRadius: 1,
                               offset: Offset(0,0)                               
                               )
                              //  :
                              //  BoxShadow()
                          ],
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(232, 105, 184, 240),
                            Color.fromARGB(232, 9, 2, 131),
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft
                          
                          )
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sunrise()),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 180),
                    child: Text(
                      AppLocalizations.of(context)!.sunrise,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: shadowColor,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color: shadowColor,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: shadowColor,
                              blurRadius: 9,
                            ),
                          ]
                          
                          ),
                          
                          
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 320, vertical: 180),
                    child: Icon(
                      Icons.brightness_low,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),

                  //  Box number three sunset
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 290),
                      child: Container(
                        width: 400,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(218, 140, 218, 178),
                           boxShadow: [
                            // isPressed?
                            BoxShadow(
                              color: Color.fromARGB(179, 104, 152, 127).withAlpha(255),
                               blurRadius: 10,
                               spreadRadius: 1,
                               offset: Offset(0,0)                               
                               )
                              //  :
                              //  BoxShadow()
                          ],
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(218, 140, 218, 178),
                            Color.fromARGB(160, 0, 136, 25),
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft
                          
                          )
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SunSet()),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 300, left: 20),
                        child: Text(
                          AppLocalizations.of(context)!.sunset,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                             , shadows: [
                                Shadow(
                                  color: shadowColor,
                                  blurRadius: 3,
                                ),
                                Shadow(
                                  color: shadowColor,
                                  blurRadius: 6,
                                ),
                                Shadow(
                                  color: shadowColor,
                                  blurRadius: 9,
                                ),
                              ]
                              ),
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 320, vertical: 300),
                    child: Icon(
                      Icons.brightness_medium_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  //Box number four

                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 410),
                      child: Container(
                        width: 400,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffFBCCA3),
                           boxShadow: [
                            // isPressed?
                            BoxShadow(
                              color: Color.fromARGB(255, 178, 148, 122).withAlpha(255),
                               blurRadius: 10,
                               spreadRadius: 1,
                               offset: Offset(0,0)                               
                               )
                              //  :
                              //  BoxShadow()
                          ],
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 233, 178, 129),
                            Color.fromARGB(214, 187, 128, 0),
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft
                          
                          )
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Notifications()),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 420, left: 20),
                        child: Text(
                          AppLocalizations.of(context)!.snotify,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                              ,shadows: [
                            Shadow(
                              color: shadowColor,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color: shadowColor,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: shadowColor,
                              blurRadius: 9,
                            ),
                          ]
                              
                              ),
                        ),
                      ),
                    ],
                  ),
                  /* Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 350),
                child: Text(
                  'Schdule notificatios ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ), */
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 320, vertical: 420),
                    child: Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  ////////////////
                  ////
                  ///
                  ///
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 530),
                      child: Container(
                        width: 400,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 218, 210, 219),
                           boxShadow: [
                            // isPressed?
                            BoxShadow(
                              color: Color.fromARGB(255, 163, 163, 163).withAlpha(255),
                               blurRadius: 10,
                               spreadRadius: 1,
                               offset: Offset(0,0)                               
                               )
                              //  :
                              //  BoxShadow()
                          ],
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 218, 210, 219),
                            Color.fromARGB(232, 133, 133, 133),
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft
                          
                          )
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Poweroff()),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 540),
                    child: Text(
                      AppLocalizations.of(context)!.spoweroff,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: shadowColor,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color: shadowColor,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: shadowColor,
                              blurRadius: 9,
                            ),
                          ]
                          ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 320, top: 540),
                    child: Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        // ,bottomNavigationBar: MyBottomNavigationBar(),
        );
  }
}