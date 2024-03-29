// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lastversion/main.dart';
import 'package:lastversion/screens/reusable_widgets.dart';

class AutoDetails extends StatefulWidget {
  final String roomID;
  const AutoDetails({Key? key, required this.roomID}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AutoDetails();
}

class _AutoDetails extends State<AutoDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Automation Details",
           style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 51, 153, 204),
                              blurRadius: 3,
                            ),
                            Shadow(
                              color: Color.fromARGB(255, 51, 153, 204),
                              blurRadius: 6,
                            ),
                            Shadow(
                              color: Color.fromARGB(255, 51, 153, 204),
                              blurRadius: 9,
                            ),
                          ]
                          ),
          ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body:
      StreamBuilder(
        stream: apiServices.roomDetails(widget.roomID),
        builder:  (BuildContext context, AsyncSnapshot snapshot){
          
        if(!snapshot.hasData)
        {
          return Center(child: CircularProgressIndicator(color: Colors.white,),);
        }

        Map detailsData=<String,String>{ };
        try
        {
          final Map data = snapshot.data.snapshot.value;
          final List keys = data.keys.toList();
         
          if(keys.contains("power-on")){
             detailsData["Power-on at "] = data[keys[keys.indexOf('power-on')]].toString();
          }
          if(keys.contains("power-off")){
             detailsData["Power-off at "] = data[keys[keys.indexOf('power-off')]].toString();
          }
          if(keys.contains("scheduled-notifications")){
             detailsData["Get notifications after "] = data[keys[keys.indexOf('scheduled-notifications')]].toString()+"s";
          }
           if(keys.contains("sunrise")){
             detailsData["Sunrise is "] = "set";
            //  data[keys[keys.indexOf('sunrise')]].toString();
          }
           if(keys.contains("sunset")){
             detailsData["Sunset is "] = "set";
            //  data[keys[keys.indexOf('sunset')]].toString();
          }

            if(detailsData.isEmpty){
          return Center(child: Text("No automation details yet..",
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    ),
                    );
          }

          

           
              // {"Power-off": data[keys[keys.indexOf('power-off')]].toString();
            // "Power-on": data[keys[keys.indexOf('power-on')]].toString(),
            // "Scheduled notifications": data[keys[keys.indexOf('scheduled-notifications')]].toString(),
            // "Sunrise": data[keys[keys.indexOf('sunrise')]].toString(),
            // "Sunset": data[keys[keys.indexOf('sunset')]].toString(),
          // };
          
         final List detailsKeys = detailsData.keys.toList();

          // print(detailsKeys[1]);
          return ListView(
                // padding: EdgeInsets.symmetric(vertical: 150,horizontal: 20),
                
              // crossAxisCount: 1,
                // detailsKeys[index]+'\n\n'+detailsData[detailsKeys[index]]
                children: List.generate(detailsKeys.length, (index) =>
                // Flexible(
                //   child:
                  
                   Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Container(
                        height: 75.0,
                        width: 330.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey,
                        ),
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                    Container(
                        height: 75.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 240, 28, 13),
                        ),
                        child: 
                        IconButton(
                          icon:  Icon(
                          Icons.delete,
                          size: 40,
                          color: Colors.white,
                        ),
                        onPressed: (){
                          print(detailsKeys[index].toString().toLowerCase());
                          apiServices.removeFeature(widget.roomID, detailsKeys[index].toString().toLowerCase());
                        }
                        )
                      
                      ),
                  
                
                  Text(
                   detailsKeys[index]+detailsData[detailsKeys[index]],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                        
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                     child:
                      Icon(
                        Icons.edit,
                        color: Colors.transparent,

                      ),
                  )
                    ],
                  ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 10, left: 10),
            //     child:
         
                
               
             
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: 100, left: 45),
            //   child: Container(
            //     height: 75.0,
            //     width: 70.0,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: Color.fromARGB(255, 240, 28, 13),
            //     ),
            //     child: Icon(
            //       Icons.delete,
            //       size: 40,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
        
           
          ],
              ),
        ),
                // )
              );
        }
        catch(_)
        {
          
          return Center(child: Text("No lights yet...",
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    ),
                    );
          
         
        }

        
      
        },
      )

    );
  }
}