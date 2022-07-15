import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class realtime_db extends StatefulWidget{

  @override
  _realtime_dbState createState() => _realtime_dbState();
}

class _realtime_dbState extends State<realtime_db>{
  late DatabaseReference _dbref ;
  String databasejson ="";
  @override
  void initState(){
    super.initState();
     _dbref= FirebaseDatabase.instance.ref();
  }

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Text("database: "+ databasejson),
            TextButton(onPressed: (){
              _updateValue();
            }, child: const Text("Update DB"))
          ])
        
        ,)
      ),
    );
  }





  _createDB(){
    _dbref.child("profile").set("Hala's House");
    _dbref.child("jobProfile").set({'Website': "website.come","website2": "www.google.com"});
  }

  _updateValue(){
    _dbref.child("8HcAT87dasVTkdgBGc7qoUg8LY03").update({"alias":"omar's room"});
  }


}