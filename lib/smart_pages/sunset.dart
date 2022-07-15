// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:lastversion/Smart.dart';
// import 'package:lastversion/bottomnavbar.dart';
import 'package:lastversion/screens/reusable_widgets.dart';
// import 'package:lastversion/Home.dart';
import 'package:lastversion/provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:provider/provider.dart';
import 'package:lastversion/l10n/l10n.dart';
import '../main.dart';

class SunSet extends StatefulWidget {
  const SunSet({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SunSet();
}

class _SunSet extends State<SunSet> {
  List selectedRooms =[];

  Future<String?> openDialog() {

    return showDialog<String>(
    
    context: context, 
    builder: (context)=> AlertDialog(
      title: Center(child: Text(AppLocalizations.of(context)!.added)),
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
          child: Text(AppLocalizations.of(context)!.ok))
      ],
      
      
    )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.sunset),
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
      
      body: Stack(
        
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          
          //  Padding(
          //   padding: EdgeInsets.all(30.0),
          //   child: Text(
          //     "Turn on the switch at sunset",
          //     style: TextStyle(
               
          //         fontSize: 20,
          //         color: Color.fromARGB(255, 255, 255, 255),
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(left: 30, top: 60),
          //   child: Text(
          //     "Sunset is at :  12:25",
          //     style: TextStyle(
          //         fontSize: 20,
          //         color: Colors.grey,
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
          
        StreamBuilder(
          
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
                  
              Padding(
               padding: EdgeInsets.only(left: 10,top: 10),
               child: Text(
                AppLocalizations.of(context)!.switchsunset,
                
                style: TextStyle(
                  
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold),
            ),
             ),
         
       
              Text(
              AppLocalizations.of(context)!.sunsetat,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          
                  Flexible(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(roomKeys.length, (index) =>  Rooms(image: "3596801", title: data[roomKeys[index]]['alias'], roomColor:Color.fromARGB(166, 168, 255, 196),
                      onSelect:(){
                        selectedRooms.contains(roomKeys[index])?selectedRooms.remove(roomKeys[index]):selectedRooms.add(roomKeys[index]);
                        
                      }
                      )),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      for(String id in selectedRooms){
                        apiServices.setSunsFeature(AppLocalizations.of(context)!.sunset, true , id);
                      }
                      if(selectedRooms.isNotEmpty)
                         {
                          openDialog();
                         }
                    }
                  , child: Text(AppLocalizations.of(context)!.set)
                  ),
                  
                ],
              );
          }
          catch(_){
              return ListView(
        children:  [
          SizedBox(
            height: 150,
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
          child :Text(AppLocalizations.of(context)!.noroomsyet,
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
      // Center(
      //   child: ElevatedButton(
      //                 onPressed: () {
      //                      Navigator.of(context).push(
      //                 MaterialPageRoute(builder: (context) => SmartPage()));
      //                 },
      //                 // ignore: sort_child_properties_last
      //                 child: Text("Add Lights ",
      //                     style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.white)),
      //                 style: ElevatedButton.styleFrom(
      //                     primary: Colors.blueAccent,
      //                     padding: EdgeInsets.symmetric(horizontal:50),
      //                     shape: RoundedRectangleBorder(
                            
      //                         borderRadius: BorderRadius.circular(20)
                              
                              
      //                         ),
                              
                              
      //                         ),
      //               ) ,
      // )
        ],
      ),
      
      //  bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}