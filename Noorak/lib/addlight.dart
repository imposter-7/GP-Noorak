// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lastversion/main.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:lastversion/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:lastversion/l10n/l10n.dart';
// import 'Home.dart';

class AddLight extends StatefulWidget {
  final String roomID;
  const AddLight({Key? key, required this.roomID}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddLight();
}

class _AddLight extends State<AddLight> {

  int pin=0;

  @override
  void initState(){
    super.initState();

    
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String?> openDialog() async {
    final TextEditingController controller = TextEditingController();
    final Map reservedPins = await apiServices.getReservedPins(widget.roomID);
    reservedPins.removeWhere((key, value) => value == true); 
    if(reservedPins.isEmpty)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You have used all the pins! ")));
      return null;
    }
    late int? dropDown;
    return showDialog<String>(
    context: context, 
    builder: (context)=> AlertDialog(
      title: Text("New Light"),
      content: Column(
        children: [
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: AppLocalizations.of(context)!.enteralias ),
            controller: controller,
          ),
        DropdownButtonFormField<int>(items: List.generate(reservedPins.length, (index) => DropdownMenuItem(child: Text(reservedPins.keys.toList()[index]), value: int.parse(reservedPins.keys.toList()[index].split('p').last))),
         onChanged: (value) => dropDown = value)
        ],
      ),
      

      actions: [
        TextButton(
          onPressed: () async{
                        // ignore: unnecessary_null_comparison
                        if(controller.text == null || controller.text.isEmpty) return;
                        await apiServices.addLight(controller.text, widget.roomID, dropDown!);
                        
                        Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.submit))
      ],
      
      
    )
    );
  }

  ///////////////
  ///
  ///
  ///
   Future<String?> edit_alias_openDialog(String lightID) {
    final TextEditingController controller = TextEditingController();

    return showDialog<String>(
    
    context: context, 
    builder: (context)=> AlertDialog(
      title: Text(AppLocalizations.of(context)!.editlight),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: AppLocalizations.of(context)!.newname),
        controller: controller,
      ),

      actions: [
        TextButton(
          onPressed: () async {
              if(controller.text == null || controller.text.isEmpty) return;
              await apiServices.editLightAlias(widget.roomID, lightID, controller.text);

              Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.submit))
      ],
      
      
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.light),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions:<Widget> [
          IconButton(onPressed: openDialog, icon: Icon(Icons.add, color: Colors.white,)),
      
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
      stream: apiServices.lights(widget.roomID),
      builder: (BuildContext context, AsyncSnapshot snapshot)
      {
        if(!snapshot.hasData)
        {
          return Center(child: CircularProgressIndicator(color: Colors.white,),);
        }

        try
        {
          final Map data = snapshot.data.snapshot.value;
          final List lightKeys = data.keys.toList();
          return GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          children: List.generate(lightKeys.length, (index) => GestureDetector(
            onTap: () async => await apiServices.toggleLight(widget.roomID, lightKeys[index]),
            child: Column(
              children: [
              Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(data[lightKeys[index]]['alias'], style: TextStyle(color: Colors.white, fontSize: 20,),),
              
           
                ],
              )
                
              , Flexible(
                  child: Container(
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                
                            decoration: BoxDecoration(
                               image: DecorationImage(
                                image: AssetImage(
                                  data[lightKeys[index]]['led_status'].toString() == '1' ? 'images/lighton.png' : 'images/lightoff.png',
                                ),
                                fit: BoxFit.fill,
                              ), 
                              color: Color.fromARGB(255, 244, 234, 144),
                              borderRadius: BorderRadius.circular(20),
                
                            ),
                            
                          
                          
                          
                child:
                Row(
                  children: [ 
                    Padding(padding: EdgeInsets.only(top: 140),
                   child: IconButton(
                  onPressed:(){
                    // print(lightKeys[index]),
                    apiServices.removeLight(widget.roomID, lightKeys[index].toString().toLowerCase());
                    
                  }
                  ,
                    icon:  Icon(Icons.delete_sharp,size:30,color: Color.fromARGB(255, 190, 59, 59),)
              ),



                    ),
             
                
                
           Padding(padding: EdgeInsets.only(top: 140,left:85),
              child:IconButton(
                  onPressed:()async=>
                  // print(lightKeys[index]),
                  //  apiServices.removeLight(widget.roomID, lightKeys[index].toString().toLowerCase()),
                  edit_alias_openDialog(lightKeys[index].toString().toLowerCase()),

                    icon:  Icon(Icons.edit,size:30,color: Color.fromARGB(255, 131, 126, 126),)
              ),
           ),
                  ],
                ),
                  ),
              ),
          
                ],
              )
                ),
          ),
          );
        }
          
 
        catch(_)
        {
          return Center(child: Text(AppLocalizations.of(context)!.nolight,
          textAlign:TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          ),);
        }

        
      } ,
     ),

    );
  } 
}









// Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SafeArea(
//         child: Scaffold(
//           backgroundColor: Color.fromARGB(255, 27, 27, 27),
//           appBar: AppBar(
//             title: const Text("MyHome"),
//             centerTitle: true,
//             backgroundColor: Colors.black,
//           ),
//           body: Stack(
//            // mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 70,left:60),
//                 child: Text(
//                   "Left Light",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//                Padding(
//                 padding: EdgeInsets.only(top: 70,left:230),
//                 child: Text(
//                   "Right Light",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 100),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       alignment: Alignment.topCenter,
//                       height: 250.0,
//                       width: 150.0,

//                       decoration: BoxDecoration(
//                          image: DecorationImage(
//                           image: AssetImage(
//                             'images/newbulb2.png',
//                           ),
//                           fit: BoxFit.fill,
//                         ), 
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.circular(20),

//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Container(
//                       alignment: Alignment.topCenter,
                      
//                       height: 250.0,
//                       width: 150.0,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('images/electric-light-bulb.png'),
//                           fit: BoxFit.fill,
                          
//                         ),
//                         color: Color.fromARGB(255, 240, 235, 235),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }