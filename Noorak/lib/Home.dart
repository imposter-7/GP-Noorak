// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart' show FlutterSwitch;
import 'package:lastversion/classes/neon.dart';
import 'package:lastversion/roomdetails.dart';
import 'main.dart';
import 'package:lastversion/provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:provider/provider.dart';
import 'package:lastversion/l10n/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

// Future<int>
void get_lights(DatabaseReference db, int status) async {
  final DatabaseEvent event = await db.once();
  final Map data = event.snapshot.value as Map;
  final List lights = data.keys.toList();
  for (String light_id in lights) {
    // print(data[light_id]['led_status']);
    await db.child(light_id).update({'led_status': status});
  }
}

// this function tracks all rooms to set the home switch_value on/off
// Future<void> rooms_listener (DatabaseReference db) async {
//     //   // final DatabaseReference  db = FirebaseDatabase.instance.ref(apiServices.get_UID()).child("rooms");
//     //    final DatabaseEvent event = await db.once();
//     // db.onValue.listen((event) async {
//     //   final Map data = event.snapshot.value as Map;
//     //   print(data);
//     //   if(_switchValue)
//     // });
//       final DatabaseEvent event = await db.once();
//       final Map data = event.snapshot.value as Map;
//       final List lights  = data.keys.toList();
//       for(String light_id in lights){
//         // print(data[light_id]['led_status']);
//         // await db.child(light_id).update({'led_status': status});
//         if(data[light_id]['led_status'] == 1)
//           _switchValue =true;
//       }
// }

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        
        title: Text(
          AppLocalizations.of(context)!.myhome
           ,style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 161, 86, 223),
                              blurRadius: 3,
                            ),
                            Shadow(
                             color: Color.fromARGB(255, 161, 86, 223),
                              blurRadius: 6,
                            ),
                            Shadow(
                            color: Color.fromARGB(255, 161, 86, 223),
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
      body: StreamBuilder(
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

            return ListView(
              // crossAxisCount: 2,
              children: List.generate(
                  roomKeys.length,
                  (index) => Room(
                        roomID: roomKeys[index],
                        title: data[roomKeys[index]]['alias'].toString(),
                        onToggle: () {},
                      )),
            );
          } catch (_) {
            return ListView(
              children: [
                SizedBox(
                  height: 120,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 150),
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
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 160),
                    child: Text(
                      AppLocalizations.of(context)!.noroomsyet,
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
    );
  }
}

class Room extends StatefulWidget {
  final String title, roomID;
  final VoidCallback onToggle;

  const Room({
    key,
    required this.roomID,
    required this.title,
    required this.onToggle,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  bool _switchValue = false;
  @override
  void dispose() {
    super.dispose();
  }

     Future<String?> edit_alias_openDialog(String roomID) {
    final TextEditingController controller = TextEditingController();

    return showDialog<String>(
    
    context: context, 
    builder: (context)=> AlertDialog(
      title: Text("Edit Room Name"),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: 'Enter new Room name '),
        controller: controller,
      ),

      actions: [
        TextButton(
          onPressed: () async {
              if(controller.text == null || controller.text.isEmpty) return;
              await FirebaseDatabase.instance.ref(apiServices.get_UID()).child("rooms").child(widget.roomID).update({"alias":controller.text});
              Navigator.of(context).pop();
          },
          child: Text('Submit'))
      ],
      
      
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoomDetail(roomID: widget.roomID)),
                );
              },
      child: Container(
        width: double.infinity,
        height: 100,
        child: Center(
          child: Stack(
            children: [
              // Flexible(
              //   child: 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child:
                  //  ClipRRect(
                  //   borderRadius: BorderRadius.circular(15),
                    
                  //   child: Image(
                  //     image: AssetImage("images/2855009bf094635e8cb1d32c65b7c99b.png"),
                  //     fit: BoxFit.cover,
                  //     color:Colors.white,
                  //     //colorBlendMode: BlendMode.darken,
                  //     height: 120,
                  //     width: double.infinity,
                  //   ),
                  // ),
                   CustomPaint(
                      foregroundPainter: BorderPainter(),
                      child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      width: double.infinity,
                      height: 100,
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  
                  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  
                  child: GestureDetector(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlutterSwitch(
                      width: 75,
                      height: 30,
                      valueFontSize: 35.0,
                      toggleSize: 50.0,
                      value: _switchValue,
                      borderRadius: 30.0,
                      onToggle: (value) {
                        final DatabaseReference db = FirebaseDatabase.instance
                            .ref(apiServices.get_UID())
                            .child("rooms")
                            .child(widget.roomID)
                            .child("lights");
                  
                        if (value == true) {
                          get_lights(db, 1);
                  
                          // rooms_listener(db);
                        } else {
                          get_lights(db, 0);
                        }
                        setState(() {
                          _switchValue = value;
                        });
                  
                        widget.onToggle();
                      },
                    ),
                    SizedBox(width: 10,),
                       Text(
                          widget.title.toString().toUpperCase().length > 9 ? widget.title.toString().toUpperCase().split('-')[0] : widget.title.toString().toUpperCase(),
    
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                              , shadows: [
                              Shadow(
                                color: Color.fromARGB(255, 75, 26, 86),
                                blurRadius: 5,
                              ),
                              Shadow(
                                color: Color.fromARGB(255, 75, 26, 86),
                                blurRadius: 10,
                              ),
                              Shadow(
                                color: Color.fromARGB(255, 75, 26, 86),
                                blurRadius: 15,
                              ),
                            ]
                              ),
                                    
                        ),
                      ],
                    ),
                   ),
              // ),
                  ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child:
                  Row(
                    // padding: EdgeInsets.only(left: 10,top:70),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       IconButton(
                      icon:  Icon(
                        Icons.edit,
                        size:25,
                        color: Color.fromARGB(255, 131, 126, 126),
                      ),
                      onPressed: ()async{
                          edit_alias_openDialog(widget.roomID);
                      },
                    ),
                        IconButton(
                        onPressed:()=>{
                          apiServices.removeRoom(widget.roomID)
                        }
                         //print(widget.roomID),
                        //  apiServices.removeFeature(widget.roomID,),
                          ,icon:  Icon(Icons.delete_sharp,size:25,color: Color.fromARGB(255, 172, 48, 48),)
                    ),
                    
    
    
    
                         ]
                          ),
                  
                          ),
              
                
              ]),
                 
                    
           /*          
               Padding(padding: EdgeInsets.only(top: 140,left:85),
                  child:IconButton(
                      onPressed:()async=>
                      // print(lightKeys[index]),
                      //  apiServices.removeLight(widget.roomID, lightKeys[index].toString().toLowerCase()),
                      edit_alias_openDialog(lightKeys[index].toString().toLowerCase()),
    
                        icon:  Icon(Icons.edit,size:30,color: Color.fromARGB(255, 131, 126, 126),)
                  ),
               ), */
            ],
          ),
        ),
    )
    );
  }
}
