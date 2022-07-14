// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lastversion/main.dart';
import 'package:lastversion/screens/reusable_widgets.dart';

class Poweroff extends StatefulWidget {
  State<StatefulWidget> createState() => _Poweroff();
}



class _Poweroff extends State<Poweroff> {
  String _selectedTime = "Pick a time ";
  List selectedRooms =[];


Future<String?> openDialog() {

    return showDialog<String>(
    
    context: context, 
    builder: (context)=> AlertDialog(
      title: Center(child: Text("Feature is added successfully!")),
      // content: TextField(
      //   autofocus: true,
      //   decoration: InputDecoration(hintText: 'Enter your light alias '),
      //   controller: controller,
      // ),

      actions: [
        TextButton(
          onPressed: () {
                        // ignore: unnecessary_null_comparison
                        
                        // apiServices.addLight(controller.text, widget.roomID);
                        Navigator.of(context).pop();
          },
          child: Text('Ok'))
      ],
      
      
    )
    );
  }


  @override
  Widget build(BuildContext context) {
    Future<void> _openTimerPicker(BuildContext context) async {
      final TimeOfDay? t =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (t != null) {
        setState(() {
          _selectedTime = t.format(context);
        });
      }
    }

    return Scaffold(
      
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Power-off",
           style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.grey,
                              blurRadius: 3,
                            ),
                            Shadow(
                              color: Colors.grey,
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Colors.grey,
                              blurRadius: 9,
                            ),
                          ]
                          ),
          ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: 
      
      Stack(
        
        children: [
          
          Padding(
            padding: EdgeInsets.only(left: 30, top: 21),
            child: 
            
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),

            child:
               Text(
                "Power-off at:",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                  
              ),
            ),
          ),
          // SizedBox(height: 100),
          Padding(padding: EdgeInsets.only(top:50,left:160,right: 110),
          child:  RawMaterialButton(
              fillColor: Color.fromARGB(186, 232, 232, 232),
              child: Text(
                _selectedTime,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _openTimerPicker(context);
              }),
              ),
                Padding(
            padding: EdgeInsets.only(left: 30, top: 110),
            child: Text(
              "Select one room or more :",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
      SizedBox(
        child: Padding(padding: EdgeInsets.only(left: 10, top: 150),
        child:  StreamBuilder(
        stream: apiServices.rooms(),
        builder: (BuildContext context, AsyncSnapshot snapshot)
        {
          if(!snapshot.hasData)
          {
            return const Center(child: CircularProgressIndicator(),);
          }
          // final Map data = snapshot.data.snapshot.value;
          
           try{
              final Map data = snapshot.data.snapshot.value;
              final List roomKeys = data.keys.toList();
              return Column(
                children: [
                  Flexible(
                    child: ListView(
                      // crossAxisCount: 2,
                      children: List.generate(roomKeys.length, (index) =>  Rooms(image: "3596801", title: data[roomKeys[index]]['alias'], roomColor: Color.fromARGB(186, 232, 232, 232),
                      onSelect:(){
                        selectedRooms.contains(roomKeys[index])?selectedRooms.remove(roomKeys[index]):selectedRooms.add(roomKeys[index]);
                        
                      }
                      )),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      for(String id in selectedRooms){
                        apiServices.setFeature("power-off",  _selectedTime.toString(), id);
                      }

                       if(selectedRooms.isNotEmpty)
                         {
                          openDialog();
                         }
                    }
                  , child: Text("Set")
                  )
                ],
              );
          }
          catch(_) {
              return ListView(
        children: const [
          SizedBox(
            height: 120,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 150,horizontal: 150),
          child: Icon(
                Icons.meeting_room_sharp,
                color: Colors.white,
                size: 100,
              ),
          
          ),
          SizedBox(height: 10,),
          Padding(padding: EdgeInsets.symmetric(vertical: 250,horizontal:160 ),
          child :Text("No rooms yet...",
          textAlign:TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          )
          ),
          SizedBox(height: 10,),
  
        ],
      );

          }
        },
      ),
        ),
      
            //    Padding(
            //   padding: EdgeInsets.only(top: 230,left: 60,right: 60),
            //   child: Container(
            //     width: 300,
            //     height: 60,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: Color.fromARGB(255, 228, 193, 220),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 75, vertical: 245),
            //   child: Text(
            //     'Adams Room',
            //     style: TextStyle(
            //         fontSize: 25,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white),
            //   ),
            // ),
            // ////////////////////////////
            // ///
            // ///
            // ///
            // ///
            //  Padding(
            //   padding: EdgeInsets.only(top: 320,left: 60,right: 60),
            //   child: Container(
            //     width: 300,
            //     height: 60,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: Color.fromARGB(255, 228, 193, 220),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 75, top: 335),
            //   child: Text(
            //     'Kitchen',
            //     style: TextStyle(
            //         fontSize: 25,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white),
            //   ),
            // ),
            // //////////////////////
            // ///
            // ///
            // ////////////////////
            // Padding(
            //   padding: EdgeInsets.only(top: 410,left: 60,right: 60),
            //   child: Container(
            //     width: 300,
            //     height: 60,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: Color.fromARGB(255, 228, 193, 220),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 75, top: 425),
            //   child: Text(
            //     'Living Room',
            //     style: TextStyle(
            //         fontSize: 25,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white),
            //   ),
            // ),
            //  Padding(
            //   padding: EdgeInsets.only(left: 140, top: 510),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       /* Navigator.of(context).push(
            //           MaterialPageRoute(builder: (context) => Register())); */
            //     },
            //     style: ElevatedButton.styleFrom(
            //         minimumSize: Size(150, 40),
            //         primary: Colors.blue,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(20))),
            //     child: Text("Set",
            //         style: TextStyle(
            //             fontSize: 15, letterSpacing: 2, color: Colors.white)),
            //   ),
            //  ),
      )
        ],
      ),
    );
  }
}