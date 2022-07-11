import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lastversion/Smart.dart';
import 'package:lastversion/bottomnavbar.dart';
import 'package:lastversion/main.dart';
import 'package:lastversion/screens/reusable_widgets.dart';

class Sunrise extends StatefulWidget {
  const Sunrise({Key? key}) : super(key: key);

  @override
  State<Sunrise> createState() => _SunriseState();
}

class _SunriseState extends State<Sunrise> {
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
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      appBar: AppBar(
        title: const Text("MyHome"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: 
      Stack(
        
        children: [
          
          //  const Padding(
          //   padding: EdgeInsets.all(30.0),
          //   child: Text(
          //     "Turn off the switch at sunrise",
          //     style: TextStyle(
               
          //         fontSize: 20,
          //         color: Color.fromARGB(255, 255, 255, 255),
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const Padding(
          //   padding: EdgeInsets.only(left: 30, top: 60, bottom: 50),
          //   child: Text(
          //     "Sunrise is at :  5:35am ",
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
              // return GridView.count(
              //   padding: EdgeInsets.symmetric(vertical: 150,horizontal: 20),
              //   crossAxisCount: 2,
              //   children: List.generate(roomKeys.length, (index) => Rooms(image: "3596801", title: data[roomKeys[index]]['alias'], roomColor: Color.fromARGB(206, 168, 209, 255),onSelect: (){})),
              // );
              return Column(
                children: [
                  
             const Padding(
               padding: EdgeInsets.only(left: 10,top: 10),
               child: Text(
                
                "Turn off the switch at sunrise",
                
                style: TextStyle(
                  
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold),
            ),
             ),
         
       
             const Text(
              "Sunrise is at :  5:35 am ",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          
                  Flexible(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(roomKeys.length, (index) =>  Rooms(image: "3596801", title: data[roomKeys[index]]['alias'], roomColor: Color.fromARGB(206, 168, 209, 255),
                      onSelect:(){
                        selectedRooms.contains(roomKeys[index])?selectedRooms.remove(roomKeys[index]):selectedRooms.add(roomKeys[index]);
                        
                      }
                      )),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      for(String id in selectedRooms){
                        apiServices.setSunsFeature("sunrise",  true, id);
                      }
                      if(selectedRooms.isNotEmpty)
                         {
                          openDialog();
                         }
                    }
                  , child: Text("Set")
                  ),
                  
                ],
              );
          }
      
      catch(_) {
        return ListView(
        children: const [
          // SizedBox(
          //   // height: 150,
          // ),
          Padding(padding: EdgeInsets.symmetric(vertical: 150,horizontal: 150),
          child: Icon(
                Icons.meeting_room_sharp,
                color: Colors.white,
                size: 100,
              ),
          
          ),
          // SizedBox(height: 10,),
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
      //  Center(
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