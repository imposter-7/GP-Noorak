// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:lastversion/Home.dart';
import 'package:lastversion/bottomnavbar.dart';
import 'package:lastversion/provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:provider/provider.dart';
import 'package:lastversion/l10n/l10n.dart';

class FirstHome extends StatefulWidget {
  const FirstHome({key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FirstHome();
}

class _FirstHome extends State<FirstHome> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("MyHome"),
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
        children: [
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
          Padding(padding: EdgeInsets.only(top:270,left:110),
          child:   ElevatedButton(
                      onPressed: () {
                           Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      // ignore: sort_child_properties_last
                      child: Text("Reload",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(horizontal:50),
                          shape: RoundedRectangleBorder(
                            
                              borderRadius: BorderRadius.circular(20)
                              
                              
                              ),
                              
                              
                              ),
                    ) ,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 215,vertical:285),
          child: Icon(
            Icons.autorenew_rounded,
                color: Colors.white,
                size: 20,
          ),
          ),

        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
