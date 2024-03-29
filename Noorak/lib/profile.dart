// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lastversion/main.dart';
import 'package:lastversion/mainpage.dart';
import 'package:lastversion/notifications/notification_api.dart';
import 'package:lastversion/screens/reusable_widgets.dart';
import 'package:neon/neon.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:lastversion/provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:provider/provider.dart';
import 'package:lastversion/l10n/l10n.dart';
import 'timer/test.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _Profile createState() => _Profile();
}

var _switchValue = false;
// bool isPlaying = false;
// int endTime;
//  = DateTime.now().millisecondsSinceEpoch + 1000 * 5;

class _Profile extends State<Profile> {
  bool ispassword = true;
  List selectedRooms = [];

  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
  }

  Future<String?> openDialog() {
    final TextEditingController controller = TextEditingController();

    return showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("New Light"),
              // content: TextField(
              //   autofocus: true,
              //   decoration: InputDecoration(hintText: 'Enter your light alias '),
              //   controller: controller,
              content: Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 150),
                  child: StreamBuilder(
                    stream: apiServices.rooms(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      // final Map data = snapshot.data.snapshot.value;

                      try {
                        final Map data = snapshot.data.snapshot.value;
                        final List roomKeys = data.keys.toList();
                        return Column(
                          children: [
                            Flexible(
                              child: ListView(
                                // crossAxisCount: 2,
                                children: List.generate(
                                    roomKeys.length,
                                    (index) => clickableRooms(
                                        title: data[roomKeys[index]]['alias'],
                                        roomColor:
                                            Color.fromARGB(186, 232, 232, 232),
                                        onSelect: () {
                                          selectedRooms
                                                  .contains(roomKeys[index])
                                              ? selectedRooms
                                                  .remove(roomKeys[index])
                                              : selectedRooms
                                                  .add(roomKeys[index]);
                                        })),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  // for(String id in selectedRooms){
                                  //   apiServices.setFeature("power-off",  _selectedTime.toString(), id);
                                  // }
                                },
                                child: Text("Set"))
                          ],
                        );
                      } catch (_) {
                        return ListView(
                          children: const [
                            SizedBox(
                              height: 120,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 150, horizontal: 150),
                              child: Icon(
                                Icons.meeting_room_sharp,
                                color: Colors.white,
                                size: 100,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 250, horizontal: 160),
                                child: Text(
                                  "No rooms yet...",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),

              actions: [
                TextButton(
                    onPressed: () {
                      // ignore: unnecessary_null_comparison
                      // if(controller.text == null || controller.text.isEmpty) return;
                      // apiServices.addLight(controller.text, widget.roomID);
                      // Navigator.of(context).pop();
                    },
                    child: Text('Submit'))
              ],
            ));
  }

  Future<int> getTime() async{
  final DatabaseReference  db = FirebaseDatabase.instance.ref("VMTnWxaqxrQwVEPeViX53pWjRBH3").child("rooms").child('room1');
      final DatabaseEvent event = await db.once();
    final Map data = event.snapshot.value as Map;
    return int.parse(data['scheduled-notifications']);
  }

  Future<int> get_ledStatus() async {
    final DatabaseReference db = FirebaseDatabase.instance.ref("VMTnWxaqxrQwVEPeViX53pWjRBH3").child("rooms").child('room1').child("lights").child("light1");
    final DatabaseEvent event = await db.once();
    final Map data = event.snapshot.value as Map;
    // print(data['led_status']);
    return data['led_status'];
  }

/* this function is listening to a hard-coded light continously-
    once the led status is changed, it checks if the notification switch
    is switched on. If the light is switched on and the notifications 
    switch is switched on, a notification is sent.

    Next step: find a way to calculate that the light is switched on 
    till the time that is set in the database. Once the light reached the 
    specific time, a notification must be sent directly
*/
  void listening_to_LEDstatus() {
    final DatabaseReference db = FirebaseDatabase.instance.ref("VMTnWxaqxrQwVEPeViX53pWjRBH3").child("rooms").child('room1').child("lights").child("light1");
    db.onValue.listen((event) async {
      final Map data = event.snapshot.value as Map;
      if (data['led_status'] == 1 && _switchValue == true) {
        print(data['led_status']);
        print(_switchValue.toString());
        int secondss = await getTime();
        int led_status = await get_ledStatus();

        // This executes the code after the given time
        Future.delayed(Duration(seconds: secondss), () {
          NotificationService().showNotification(
              1, "NOORAK", "Warning: some lights are switched on!  ", 1);

          print("A notification is sent after" + secondss.toString());
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    listening_to_LEDstatus();
    //  Future.delayed(
    //             Duration(seconds: 5),
    //              (){ print("Executed after 5 seconds"); }
    //              );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile
          ,style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.deepOrangeAccent,
                              blurRadius: 3,
                            ),
                            Shadow(
                             color: Colors.deepOrangeAccent,
                              blurRadius: 6,
                            ),
                            Shadow(
                            color: Colors.deepOrangeAccent,
                              blurRadius: 9,
                            ),
                          ]
                          ),
          ),
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height*1.1,
          child:
           Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            
           
              child: Column(
                children: [
                  Center(
                      child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 130, right: 115, top: 5),
                        child: Container(
                          width: 390,
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.blue.withOpacity(0.1))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage('images/2.jpg'),
                              )),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child:
                          Neon(
                            text:
                            apiServices.get_email().toString().split("@")[0],
                            color: Colors.pink,
                            // font: NeonFont.Monoton,
                            font: NeonFont.TextMeOne,
                          
                            flickeringText: true,
                            flickeringLetters: null,
                            fontSize: 35,
                            glowingDuration: new Duration(seconds: 3),
                      ),
                                  
                        //  Text(
                        //   // "The name ",
                        //   apiServices.get_email().toString().split("@")[0],

                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 28,
                        //     fontWeight: FontWeight.bold,
                        //      shadows: [
                        //     Shadow(
                        //       color: Colors.white,
                        //       blurRadius: 3,
                        //     ),
                        //     Shadow(
                        //       color: Colors.white,
                        //       blurRadius: 6,
                        //     ),
                        //     Shadow(
                        //       color: Colors.white,
                        //       blurRadius: 9,
                        //     ),
                        //   ]
                        //   ),
                        // ),
                      ),
                      // CountdownTimer(
                      //   endTime: endTime,
                      //   onEnd: onEnd,
                      //   ),
                      Container(
                        padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                        child:
                         Neon(
                            text:
                            apiServices.get_email().toString(),
                            color: Colors.pink,
                            // font: NeonFont.Monoton,
                            font: NeonFont.TextMeOne,
                          
                            flickeringText: true,
                            // flickeringLetters: null,
                            fontSize: 22,
                            glowing: true,
                            glowingDuration: new Duration(seconds: 3),
                      ),
                        //  Text(
                        //   // " Email@gmail.com",
                        //   apiServices.get_email().toString(),
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 22,
                        //     fontWeight: FontWeight.bold,
                        //     decoration: TextDecoration.underline,
                        //      shadows: [
                        //     Shadow(
                        //       color: Colors.white,
                        //       blurRadius: 3,
                        //     ),
                        //     Shadow(
                        //       color: Colors.white,
                        //       blurRadius: 6,
                        //     ),
                        //     Shadow(
                        //       color: Colors.white,
                        //       blurRadius: 9,
                        //     ),
                        //   ]
                        //   ),
                        // ),
                      ),
                    ],
                  )),
                  /*SizedBox(height: 50),
                buildTextField("Full Name", "Raghad", false),
              buildTextField("Email", "ragood.200024@gmail.com", false),
              buildTextField("Password", "********", true), */
                  //SizedBox(height: 30),
                  Stack(
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(top: 10, left: 118),
                      //   child: ElevatedButton(
                      //     onPressed: () {},
                      //     style: ElevatedButton.styleFrom(
                      //         primary: Colors.orange,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(20))),
                      //     child: Text("Edit Profile",
                      //         style: TextStyle(
                      //             fontSize: 15,
                      //             letterSpacing: 2,
                      //             color: Colors.white)),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 50,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.notify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                             shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color:Colors.black,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Colors.white70,
                              blurRadius: 9,
                            ),
                          ]
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   child:
                      Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: Container(
                          width: 400,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff575353),
                          ),
                        ),
                      ),
                      // onTap: () async{
                      //     int seconds = await getTime() ;
                      //     print(seconds);
                      //     print("hahaha");
                      //     NotificationService().showNotification(1, "NOORAK",
                      //     "Warning: Lights are on !  ",2  );
                      // },
                      // ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 95,
                          left: 300,
                        ),
                        child: FlutterSwitch(
                          width: 50,
                          height: 25,
                          valueFontSize: 25.0,
                          toggleSize: 45.0,
                          value: _switchValue,
                          borderRadius: 30.0,
                            onToggle: (value) async{
                            int seconds = await getTime() ;
                            // print(seconds);
                            // print("hahaha");
                            int led_status = await get_ledStatus();
                            // print(led_status);

                          //   if(value == true && led_status ==1 )
                          //  {
                            
                          //    NotificationService().showNotification(1, "NOORAK",
                          //   "Warning: Lights are on !  ",2  );
                          //  }
                        
                              setState(() {
                                _switchValue = value;
                              });
                      },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("tapped");
                          openDialog();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 95,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.turnnotify,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                               shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color:Colors.black,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Colors.white70,
                              blurRadius: 9,
                            ),
                          ]
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 170,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.location,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color:Colors.black,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Colors.white70,
                              blurRadius: 9,
                            ),
                          ]
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: Container(
                          width: 400,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff575353),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 208,
                          left: 320,
                        ),
                        child: Icon(
                          Icons.add_location,
                          size: 40,
                          color: Color.fromARGB(248, 233, 95, 210),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 215,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.setloc,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                             shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color:Colors.black,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Colors.white70,
                              blurRadius: 9,
                            ),
                          ]
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 290,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.report,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                             shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color:Colors.black,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Colors.white70,
                              blurRadius: 9,
                            ),
                          ]
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 330, left: 50),
                      //   child: ElevatedButton(
                      //     onPressed: () {},
                      //     style: ElevatedButton.styleFrom(
                      //         primary: Colors.orange,
                      //         padding: EdgeInsets.symmetric(horizontal: 70),
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(20)
                      //             )
                      //             ),
                      //     child: Text(AppLocalizations.of(context)!.checkre,
                      //         style: TextStyle(
                      //             fontSize: 15,
                      //             letterSpacing: 0.5,
                      //             color: Colors.white)),
                      //   ),
                      // ),

                   GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 320),
                      child: Container(
                        width: 380,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 218, 210, 219),
                           boxShadow: [
                            // isPressed?
                            BoxShadow(
                              color: Color.fromARGB(255, 163, 163, 163).withAlpha(255),
                               blurRadius: 5,
                               spreadRadius: 1,
                               offset: Offset(0,0)                               
                               )
                              //  :
                              //  BoxShadow()
                          ],
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 115, 22, 92),
                            Color.fromARGB(232, 160, 12, 133),
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft
                          
                          )
                        ),
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Poweroff()),
                      // );
                    },
                  ),

                   Padding(
                    padding: EdgeInsets.only(left: 20, top: 335),
                    child: Text(
                      AppLocalizations.of(context)!.spoweroff,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color:Colors.black,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Colors.white70,
                              blurRadius: 9,
                            ),
                          ]
                          ),
                    ),
                  ),

                      //////////////logout button//////
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     left: 20,
                      //     top: 390,
                      //   ),
                      //   child: Text(
                      //     AppLocalizations.of(context)!.logout,
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.w300,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 420),
                        child: ElevatedButton(
                          onPressed: () async {
                            await apiServices.signOut();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              padding: EdgeInsets.only(left: 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(AppLocalizations.of(context)!.logout,
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 2,
                                  color: Colors.white,
                                   shadows: [
                                    Shadow(
                                      color: Colors.white,
                                      blurRadius: 3,
                                    ),
                                    Shadow(
                                      color: Colors.white,
                                      blurRadius: 6,
                                    ),
                                    Shadow(
                                      color: Colors.white,
                                      blurRadius: 9,
                                    ),
                                  ]
                                  )
                                  ),
                        ),
                      ),

                      /* Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 350, vertical: 55),
                    child: Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 35,
                    ),
                  ), */

                      /* ElevatedButton(
                    onPressed: () {},
                    child: Text("Save",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        padding: EdgeInsets.symmetric(horizontal: 70),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ) */
                    ],
                  )
                ],
              ),
           
          ),
        ),
      ),
    );
  }

  /*  Widget buildTextField(String labelText, String placeholder, bool isPassword) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPassword ? true : false,
        decoration: InputDecoration(
            suffixIcon: ispassword
                ? IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {})
                : null,
            contentPadding: EdgeInsets.only(bottom: 5),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white, fontSize: 18),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
    );
    } */
}
